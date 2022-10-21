import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

class ScrollableTable<T> extends StatefulWidget {
  const ScrollableTable({
    Key? key,
    this.scrollViewWrapper,
    this.tableWrapper,
    this.cellPadding,
    this.columnAppBar,
    this.columnBackground,
    this.columnCellPadding,
    this.columnHeight = 48,
    this.columnWidths,
    required this.columns,
    this.contentPadding,
    required this.defaultColumnWidth,
    this.footer,
    this.footerOffsetToHide,
    this.header,
    this.headerOffsetToHide,
    this.horizontalController,
    this.initialMinScale = 1 / 2,
    this.initialScale,
    this.initialScaleFitToWidth = false,
    this.isLoading,
    required this.itemBuilder,
    this.itemCount,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.loadingIndicator,
    this.paddingTopOnHeaderHide,
    this.physics,
    this.rowHeight = 48,
    this.rowsListenable,
    this.showStrokesIntoColumns = true,
    this.strokeColor,
    this.strokeWidth,
    this.isEmptyBackground,
    this.tablePadding,
    this.verticalController,
  }) : super(key: key);

  final Widget Function(Widget child)? scrollViewWrapper;
  final Widget Function(Widget child)? tableWrapper;
  final EdgeInsets? cellPadding;
  final Widget? columnAppBar;
  final Widget? columnBackground;
  final EdgeInsets? columnCellPadding;
  final double columnHeight;
  final Map<int, double>? columnWidths;
  final List<Widget> columns;
  final EdgeInsets? contentPadding;
  final double defaultColumnWidth;
  final Widget? footer;
  final double? footerOffsetToHide;
  final Widget? header;
  final double? headerOffsetToHide;
  final ScrollController? horizontalController;
  final double initialMinScale;
  final double? initialScale;
  final bool initialScaleFitToWidth;
  final Widget? isEmptyBackground;
  final ValueNotifier<bool>? isLoading;
  final List<Widget> Function(int index) itemBuilder;
  final int? itemCount;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final Widget? loadingIndicator;
  final double? paddingTopOnHeaderHide;
  final ScrollPhysics? physics;
  final double rowHeight;
  final ValueListenable<List<T>>? rowsListenable;
  final bool showStrokesIntoColumns;
  final Color? strokeColor;
  final double? strokeWidth;
  final EdgeInsets? tablePadding;
  final ScrollController? verticalController;

  @override
  State<ScrollableTable<T>> createState() => _ScrollableTableState<T>();
}

class _ScrollableTableState<T> extends State<ScrollableTable<T>> {
  double _globalWidth = 0.0;
  final ValueNotifier<double> _headerHeight = ValueNotifier(0.0);
  final ValueNotifier<double> _headerPosition = ValueNotifier(0.0);
  late ScrollController _horizontalController;
  Drag? _horizontalDrag;
  ScrollHoldController? _horizontalHold;
  double _initialScale = 1.0;
  final double _maxScale = 1.0;
  double _minScale = 0.2;
  int _pointers = 0;
  final Map<Type, GestureRecognizer> _recognizers = <Type, GestureRecognizer>{};
  final ValueNotifier<double> _scale = ValueNotifier<double>(1.0);
  double _tableWidth = 0.0;
  late ScrollController _verticalController;
  Drag? _verticalDrag;
  ScrollHoldController? _verticalHold;
  double _width = 0;

  @override
  void dispose() {
    _headerHeight.dispose();
    _headerPosition.dispose();
    _horizontalController.removeListener(_handleHorizontalListener);
    if (widget.horizontalController == null) _horizontalController.dispose();
    if (widget.verticalController == null) _verticalController.dispose();
    for (final item in _recognizers.values) {
      item.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    _horizontalController = widget.horizontalController ?? ScrollController();
    _verticalController = widget.verticalController ?? ScrollController();
    _horizontalController.addListener(_handleHorizontalListener);
    Misc.onLayoutRendered(() {
      _recognizers[PanGestureRecognizer] = PanGestureRecognizer()
        ..onDown = _handleDragDown
        ..onStart = _handleDragStart
        ..onUpdate = _handleDragUpdate
        ..onEnd = _handleDragEnd
        ..onCancel = _handleDragCancel
        ..minFlingDistance = widget.physics?.minFlingDistance
        ..minFlingVelocity = widget.physics?.minFlingVelocity
        ..maxFlingVelocity = widget.physics?.maxFlingVelocity
        ..velocityTrackerBuilder =
            ScrollConfiguration.of(context).velocityTrackerBuilder(context)
        ..dragStartBehavior = DragStartBehavior.start;
      _recognizers[ScaleGestureRecognizer] = ScaleGestureRecognizer()
        ..onStart = _handleScaleStart
        ..onUpdate = _handleScaleUpdate
        ..dragStartBehavior = DragStartBehavior.start;
      _calculateSizes();
      setState(() {});
    });
    super.initState();
  }

  bool get hasBorder =>
      widget.strokeWidth != null && widget.strokeColor != null;

  void _handleHorizontalListener() {
    final double offset = _horizontalController.offset;
    if (offset + _globalWidth > _tableWidth) {
      _horizontalController.jumpTo(offset.clamp(0, _tableWidth - _globalWidth));
    }
  }

  void _calculateRelativeTableWidth() {
    _tableWidth = _width * _scale.value + (widget.tablePadding?.right ?? 0);
  }

  void _calculateSizes() {
    _globalWidth = context.media.width;
    _width = widget.tablePadding?.horizontal ?? 0;
    final int columnsCount = widget.columns.length;
    for (var i = 0; i < columnsCount; i++) {
      _width += widget.columnWidths?[i] ?? widget.defaultColumnWidth;
      if (hasBorder && i < columnsCount) _width += widget.strokeWidth!;
    }
    _minScale =
        _globalWidth / (_width + (widget.tablePadding?.horizontal ?? 0));
    if (widget.initialScaleFitToWidth) {
      _scale.value = _minScale;
    } else {
      _scale.value = widget.initialScale ??
          ((_globalWidth * 2) / _width).clamp(
              _minScale >= widget.initialMinScale
                  ? _minScale
                  : widget.initialMinScale,
              _maxScale);
    }
    _calculateRelativeTableWidth();
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _initialScale = _scale.value;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    final double newScale = _initialScale * details.scale;
    _scale.value = newScale.clamp(_minScale, _maxScale);
    _calculateRelativeTableWidth();
    _handleHorizontalListener();
  }

  void _handleDragDown(DragDownDetails details) {
    _horizontalHold =
        _horizontalController.position.hold(() => _horizontalHold = null);
    _verticalHold =
        _verticalController.position.hold(() => _verticalHold = null);
  }

  void _handleDragStart(DragStartDetails details) {
    _horizontalDrag = _horizontalController.position
        .drag(details, () => _horizontalDrag = null);
    _verticalDrag =
        _verticalController.position.drag(details, () => _verticalDrag = null);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final Offset delta = details.delta;
    final Duration? sourceTimeStamp = details.sourceTimeStamp;
    _horizontalDrag?.update(DragUpdateDetails(
      sourceTimeStamp: sourceTimeStamp,
      delta: Offset(delta.dx, 0),
      primaryDelta: delta.dx,
      globalPosition: details.globalPosition,
    ));
    _verticalDrag?.update(DragUpdateDetails(
      sourceTimeStamp: sourceTimeStamp,
      delta: Offset(0, delta.dy),
      primaryDelta: delta.dy,
      globalPosition: details.globalPosition,
    ));
  }

  void _handleDragEnd(DragEndDetails details) {
    final Velocity velocity = details.velocity;
    final Offset pixelsPerSecond = velocity.pixelsPerSecond;
    _horizontalDrag?.end(DragEndDetails(
      velocity: velocity,
      primaryVelocity: pixelsPerSecond.dx,
    ));
    _verticalDrag?.end(DragEndDetails(
      velocity: velocity,
      primaryVelocity: pixelsPerSecond.dy,
    ));
  }

  void _handleDragCancel() {
    _horizontalHold?.cancel();
    _horizontalDrag?.cancel();
    _verticalHold?.cancel();
    _verticalDrag?.cancel();
  }

  List<Widget> _castTableRow(List<Widget> children, {bool isColumn = false}) {
    final int length = children.length;
    final int last = length - 1;
    final List<Widget> values = [];
    final Widget? stroke = hasBorder
        ? Container(width: widget.strokeWidth, color: widget.strokeColor)
        : null;
    for (var i = 0; i < length; i++) {
      final Widget e = children[i];
      final double width = widget.columnWidths?[i] ?? widget.defaultColumnWidth;
      Widget child = Padding(
        padding: (isColumn ? widget.columnCellPadding : widget.cellPadding) ??
            Margin.zero,
        child: e,
      );
      if (isColumn) {
        if (i == 0) {
          child = CenterLeftAlign(child: child);
        } else if (i == last) {
          child = CenterRightAlign(child: child);
        } else {
          child = Center(child: child);
        }
      }
      values.addAll([
        SizedBox(width: width, child: child),
        if (stroke != null && i != last)
          if (isColumn && widget.showStrokesIntoColumns)
            stroke
          else if (!isColumn)
            stroke
      ]);
    }
    return values;
  }

  @override
  Widget build(BuildContext context) {
    final BuildMedia media = context.media;
    final double height = media.height;

    Widget _sliverRows({required int? itemCount}) {
      final Decoration decoration = BoxDecoration(
        border: hasBorder
            ? Border(
                bottom: BorderSide(
                  color: widget.strokeColor!,
                  width: widget.strokeWidth!,
                ),
              )
            : null,
      );

      return SliverPadding(
        padding: widget.contentPadding ?? Margin.zero,
        sliver: widget.isEmptyBackground != null && (itemCount ?? 0) <= 0
            ? SliverFillRemaining(child: widget.isEmptyBackground)
            : SliverFixedExtentList(
                itemExtent: widget.rowHeight,
                delegate: SliverChildBuilderDelegate(
                  (_, index) => DecoratedBox(
                    decoration: decoration,
                    child:
                        Row(children: _castTableRow(widget.itemBuilder(index))),
                  ),
                  childCount: itemCount,
                ),
              ),
      );
    }

    Widget rows = widget.rowsListenable != null
        ? ValueListenableBuilder<List<T>>(
            valueListenable: widget.rowsListenable!,
            builder: (_, value, ___) => _sliverRows(
              itemCount: value.length,
            ),
          )
        : _sliverRows(itemCount: widget.itemCount);

    if (widget.isLoading != null) {
      rows = ValueListenableBuilder<bool>(
        valueListenable: widget.isLoading!,
        builder: (_, isLoading, child) {
          if (isLoading) {
            return widget.loadingIndicator ??
                const SliverFillRemaining(child: CircularProgressIndicator());
          }
          return child!;
        },
        child: rows,
      );
    }

    final Widget table = Listener(
      onPointerUp: (e) => _pointers -= 1,
      onPointerDown: (e) {
        _pointers += 1;
        if (_pointers == 1) {
          _recognizers[PanGestureRecognizer]?.addPointer(e);
        }
        _recognizers[ScaleGestureRecognizer]?.addPointer(e);
      },
      behavior: HitTestBehavior.translucent,
      child: CustomScrollView(
        controller: _horizontalController,
        scrollDirection: Axis.horizontal,
        cacheExtent: _width,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              width: _width,
              child: Padding(
                padding: widget.tablePadding ?? Margin.zero,
                child: ValueListenableBuilder<double>(
                  valueListenable: _scale,
                  builder: (_, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      alignment: Alignment.topLeft,
                      child: FractionallySizedBox(
                        heightFactor: height / (height * scale),
                        alignment: Alignment.topLeft,
                        child: widget.scrollViewWrapper != null
                            ? widget.scrollViewWrapper!(child!)
                            : child,
                      ),
                    );
                  },
                  child: CustomScrollView(
                    controller: _verticalController,
                    physics:
                        NeverScrollableScrollPhysics(parent: widget.physics),
                    keyboardDismissBehavior: widget.keyboardDismissBehavior,
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        primary: false,
                        automaticallyImplyLeading: false,
                        backgroundColor: context.color.scaffold,
                        shadowColor: Colors.transparent,
                        titleSpacing: 0.0,
                        toolbarHeight: widget.columnHeight,
                        title: SizedBox(
                          height: widget.columnHeight,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.columnAppBar != null)
                                widget.columnAppBar!,
                              Stack(children: [
                                Positioned.fill(
                                  child: widget.columnBackground ??
                                      const SizedBox.shrink(),
                                ),
                                Row(
                                  children: _castTableRow(
                                    widget.columns,
                                    isColumn: true,
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),
                      rows
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Stack(children: [
      if (widget.header != null) ...[
        Column(children: [
          AnimatedBuilder(
            animation: Listenable.merge([_headerHeight, _headerPosition]),
            builder: (_, __) {
              final double height = _headerHeight.value;
              final double lerp =
                  height > 0 ? (_headerPosition.value / height) : 1;
              final padding = Misc.lerpDouble(0, height, lerp)
                  .clamp(widget.paddingTopOnHeaderHide ?? 0.0, double.infinity);
              return SizedBox(height: padding);
            },
          ),
          Expanded(
            child: widget.tableWrapper != null
                ? widget.tableWrapper!(table)
                : table,
          ),
        ]),
        OnScrollHideContent(
          controller: _verticalController,
          offsetToHideButton: widget.headerOffsetToHide ?? _headerHeight.value,
          onSizeChanged: (height) {
            _headerPosition.value = height;
            _headerHeight.value = height;
          },
          onChanged: (lerp) => _headerPosition.value = lerp,
          child: widget.header!,
        ),
      ] else
        table,
      if (widget.footer != null)
        BottomCenterAlign(
          child: OnScrollHideContent(
            onTop: false,
            controller: _verticalController,
            offsetToHideButton:
                widget.footerOffsetToHide ?? _headerHeight.value,
            child: widget.footer!,
          ),
        ),
    ]);
  }
}
