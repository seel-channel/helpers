import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Quad;

class InteractiveTable extends StatefulWidget {
  const InteractiveTable({
    Key? key,
    required this.itemBuilder,
    required this.cellHeight,
    required this.cellWidth,
    required this.columnsCount,
    required this.rowsCount,
  }) : super(key: key);

  final Widget Function(int row, int column) itemBuilder;
  final double cellHeight;
  final double cellWidth;
  final int columnsCount;
  final int rowsCount;

  @override
  _InteractiveTableState createState() => _InteractiveTableState();
}

class _InteractiveTableState extends State<InteractiveTable> {
  Quad _cachedViewport = Quad();
  int _firstVisibleColumn = 0;
  int _firstVisibleRow = 0;
  final ValueNotifier<int> _hash = ValueNotifier(0);
  int _lastVisibleColumn = 0;
  int _lastVisibleRow = 0;

  void _updateVisibleCells(Quad viewport) {
    if (viewport != _cachedViewport) {
      final Rect aabb = _axisAlignedBoundingBox(viewport);
      _cachedViewport = viewport;
      _firstVisibleRow = ((aabb.top / widget.cellHeight) - 1)
          .clamp(0, widget.rowsCount)
          .floor();
      _lastVisibleRow = ((aabb.bottom / widget.cellHeight) + 1)
          .clamp(0, widget.rowsCount)
          .floor();
      _firstVisibleColumn = ((aabb.left / widget.cellWidth) - 1)
          .clamp(0, widget.columnsCount)
          .floor();
      _lastVisibleColumn = ((aabb.right / widget.cellWidth) + 1)
          .clamp(0, widget.columnsCount)
          .floor();
      _hash.value = _firstVisibleRow +
          _firstVisibleColumn +
          _lastVisibleRow +
          _lastVisibleColumn;
    }
  }

  Rect _axisAlignedBoundingBox(Quad quad) {
    double xMin = 0;
    double xMax = 0;
    double yMin = 0;
    double yMax = 0;
    for (final point in [quad.point0, quad.point1, quad.point2, quad.point3]) {
      if (point.x < xMin) xMin = point.x;
      if (point.x > xMax) xMax = point.x;
      if (point.y < yMin) yMin = point.y;
      if (point.y > yMax) yMax = point.y;
    }
    return Rect.fromLTRB(xMin, yMin, xMax, yMax);
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.rowsCount * widget.cellHeight;
    final width = widget.columnsCount * widget.cellWidth;
    return _TableInheritedWidget(
      state: this,
      child: InteractiveViewer.builder(
        minScale: 0.3,
        builder: (_, Quad viewport) {
          _updateVisibleCells(viewport);
          return SizedBox(height: height, width: width, child: const _Table());
        },
      ),
    );
  }
}

class _TableInheritedWidget extends InheritedWidget {
  const _TableInheritedWidget({
    Key? key,
    required this.state,
    required Widget child,
  }) : super(key: key, child: child);

  final _InteractiveTableState state;

  @override
  bool updateShouldNotify(_TableInheritedWidget old) => false;

  static _TableInheritedWidget of(BuildContext context) {
    final _TableInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_TableInheritedWidget>();
    assert(result != null, 'No _NumericInheritedWidget found in context');
    return result!;
  }
}

class _Table extends StatelessWidget {
  const _Table({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = _TableInheritedWidget.of(context).state;
    return ValueListenableBuilder(
      valueListenable: state._hash,
      builder: (_, __, ___) {
        final InteractiveTable widget = state.widget;
        final List<Widget> children = [];
        for (int row = state._firstVisibleRow;
            row < state._lastVisibleRow + 1;
            row++) {
          final List<Widget> rowChildren = [];
          for (int column = state._firstVisibleColumn;
              column < state._lastVisibleColumn + 1;
              column++) {
            rowChildren.add(
              SizedBox(
                width: widget.cellWidth,
                height: widget.cellHeight,
                child: widget.itemBuilder(row, column),
              ),
            );
          }
          children.add(Row(children: rowChildren));
        }

        return Transform.translate(
          offset: Offset(
            state._firstVisibleRow * widget.cellWidth,
            state._firstVisibleColumn * widget.cellHeight,
          ),
          child: Column(children: children),
        );

        // return ListView.builder(
        //   itemCount: widget.columnsCount,
        //   itemExtent: widget.cellHeight,
        //   padding: EdgeInsets.zero,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemBuilder: (_, row) {
        //     final isVisible =
        //         row >= _firstVisibleRow && row <= _lastVisibleRow;
        //     return isVisible
        //         ? ListView.builder(
        //             // controller: _scrollController,
        //             padding: EdgeInsets.zero,
        //             physics: const NeverScrollableScrollPhysics(),
        //             itemExtent: widget.cellWidth,
        //             scrollDirection: Axis.horizontal,
        //             itemCount: widget.rowsCount,
        //             itemBuilder: (_, index) {
        //               return widget.itemBuilder(row, index);
        //             },
        //           )
        //         : const SizedBox();
        //   },
        // );

        // final List<Widget> children = [];

        // for (int row = state._firstVisibleRow;
        //     row < state._lastVisibleRow + 1;
        //     row++) {
        //   final double top = row * state.widget.cellHeight;
        //   for (int column = state._firstVisibleColumn;
        //       column < state._lastVisibleColumn + 1;
        //       column++) {
        //     children.add(
        //       Positioned(
        //         left: column * state.widget.cellWidth,
        //         top: top,
        //         width: state.widget.cellWidth,
        //         height: state.widget.cellHeight,
        //         child: state.widget.itemBuilder(row, column),
        //       ),
        //     );
        //   }
        // }
        // return Stack(children: children);
      },
    );
  }
}
