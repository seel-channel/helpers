import 'dart:ui';
import 'package:helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

///Displays a SlidingPanelPage above the current contents of the app.
///
///The [page] argument needs a [SlidingPanelPage] Widget
///
///Example:
/// ```dart
///openSlidingPanelPage(
///   context,
///   SlidingPanelPage(builder: (_, __) => SlidingPanelContainer(...)),
///);
/// ```
Future<void> openSlidingPanelPage(BuildContext context, Widget page) async {
  await Navigator.push(
    context,
    TransparentRoute(builder: (_) => page, duration: Duration.zero),
  );
}

class SlidingPanelContainer extends StatelessWidget {
  ///Useful for entering content to the SlidingPanelPage [builder]
  ///
  /// ```dart
  ///return ClipRRect(
  ///   borderRadius: borderRadius,
  ///   child: Container(
  ///     height: height,
  ///     width: double.infinity,
  ///     child: child,
  ///     padding: padding,
  ///     decoration: BoxDecoration(boxShadow: boxShadow,color: color),
  ///   ),
  ///);
  /// ```
  const SlidingPanelContainer({
    Key key,
    this.child,
    this.height,
    this.boxShadow,
    this.color = Colors.white,
    EdgeInsetsGeometry padding,
    BorderRadius borderRadius,
  })  : this.padding = padding ?? const EdgeInsets.all(20.0),
        this.borderRadius = borderRadius ??
            const BorderRadius.vertical(top: Radius.circular(20.0)),
        super(key: key);

  /// The color to paint behind the [child].
  final Color color;

  /// The [child] contained by the container.
  final Widget child;

  ///Creates a widget that combines common painting, positioning, and sizing widgets.
  ///The height value include the padding.
  final double height;

  ///A list of shadows cast by this box behind the box.
  ///The shadow follows the [shape] of the box.
  final List<BoxShadow> boxShadow;

  ///The border radius of the rounded corners.
  ///Values are clamped so that horizontal and vertical radii sums do not exceed width/height.
  ///
  ///Default:
  /// ```dart
  ///const BorderRadius.vertical(top: Radius.circular(20.0))
  /// ```
  final BorderRadius borderRadius;

  ///Empty space to inscribe inside the [decoration].
  ///The [child], if any, is placed inside this padding.
  ///
  ///Default:
  /// ```dart
  ///const EdgeInsets.all(20.0),
  /// ```
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        height: height,
        width: double.infinity,
        child: child,
        padding: padding,
        decoration: BoxDecoration(boxShadow: boxShadow, color: color),
      ),
    );
  }
}

class SlidingPanelPage extends StatefulWidget {
  ///Create a SlidingPanel like a AlertDialog.
  ///This widget is using the [sliding_up_panel](https://pub.dev/packages/sliding_up_panel) package.
  ///
  ///Example:
  ///```dart
  ///openSlidingPanelPage(
  ///   context,
  ///   SlidingPanelPage(builder: (_, __) => SlidingPanelContainer(...)),
  ///);
  ///```
  SlidingPanelPage({
    Key key,
    @required this.builder,
    this.isDraggable = true,
    Color chevronColor,
    Color backgroundColor,
    this.backgroundBlur = 0.0,
  })  : assert(builder != null),
        this.backgroundColor = backgroundColor ?? Colors.black.withOpacity(0.2),
        this.chevronColor = chevronColor ?? Colors.white.withOpacity(0.4),
        super(key: key);

  ///Allows toggling of the draggability of the SlidingUpPanel.
  ///Set this to false to prevent the user from being able to drag the panel up and down. Defaults to true
  final bool isDraggable;

  ///The color to paint the [chevron].
  ///
  ///Default:
  ///```dart
  ///Colors.white.withOpacity(0.4)
  ///```
  final Color chevronColor;

  ///The color to paint behind the [builder].
  ///
  ///Default:
  ///```dart
  ///Colors.black.withOpacity(0.2)
  ///```
  final Color backgroundColor;

  ///Creates an image filter that applies a Gaussian blur.
  final double backgroundBlur;

  ///Provides a [ScrollController] to attach to a scrollable
  ///object in the panel that links the panel position with the scroll position.
  ///Useful for implementing an infinite scroll behavior.
  final Widget Function(BuildContext, ScrollController) builder;

  @override
  _SlidingPanelPageState createState() => _SlidingPanelPageState();
}

class _SlidingPanelPageState extends State<SlidingPanelPage> {
  final ValueNotifier<double> _opacity = ValueNotifier<double>(0.0);
  final PanelController _controller = PanelController();

  Future<bool> closeSlide() async {
    await _controller.close();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: closeSlide,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          GestureDetector(
            onTap: closeSlide,
            behavior: HitTestBehavior.opaque,
            child: ValueListenableBuilder(
              valueListenable: _opacity,
              builder: (_, double value, __) {
                final color = widget.backgroundColor;
                final blur = widget.backgroundBlur * value;
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                  child: Container(
                    color: color.withOpacity(color.opacity * value),
                  ),
                );
              },
            ),
          ),
          _SlidingPanel(
            builder: widget.builder,
            autoOpen: true,
            minHeight: 0.0,
            controller: _controller,
            isDraggable: widget.isDraggable,
            chevronColor: widget.chevronColor,
            onPanelSlide: (value) => _opacity.value = value > 0.9 ? 1.0 : value,
            onPanelClosed: () => Navigator.pop(context),
          ),
        ]),
      ),
    );
  }
}

class _SlidingPanel extends StatefulWidget {
  _SlidingPanel({
    Key key,
    @required this.builder,
    this.minHeight = 0,
    this.autoOpen = false,
    this.isDraggable = true,
    this.chevronColor = Colors.white,
    this.onPanelClosed,
    this.onPanelOpened,
    this.onPanelSlide,
    PanelController controller,
  })  : this.controller = controller ?? PanelController(),
        super(key: key);

  final bool autoOpen;
  final bool isDraggable;
  final double minHeight;
  final Color chevronColor;
  final PanelController controller;
  final void Function() onPanelClosed;
  final void Function() onPanelOpened;
  final void Function(double amount) onPanelSlide;
  final Widget Function(BuildContext, ScrollController) builder;

  @override
  _SlidingPanelState createState() => _SlidingPanelState();
}

class _SlidingPanelState extends State<_SlidingPanel> {
  final GlobalKey _contentKey = GlobalKey();
  PanelController _controller;
  double _contentHeight = 800;
  bool _isPanelOpen = false;

  @override
  void initState() {
    _controller = widget.controller;
    _updateSize(widget.autoOpen ? _controller.open : null);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _SlidingPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSize();
  }

  void _updateSize([void Function() callback]) {
    Misc.onLayoutRendered(() {
      if (_contentKey != null) {
        final double height = BuildKey(_contentKey).height;
        if (_contentHeight != height) setState(() => _contentHeight = height);
        callback?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      color: Colors.transparent,
      boxShadow: null,
      maxHeight: _contentHeight,
      minHeight: widget.minHeight + 26,
      controller: _controller,
      isDraggable: widget.isDraggable,
      backdropEnabled: false,
      onPanelClosed: () {
        if (_isPanelOpen) setState(() => _isPanelOpen = false);
        if (widget.onPanelClosed != null) widget.onPanelClosed();
      },
      onPanelOpened: () {
        if (!_isPanelOpen) setState(() => _isPanelOpen = true);
        if (widget.onPanelOpened != null) widget.onPanelOpened();
      },
      onPanelSlide: widget.onPanelSlide,
      panelBuilder: (sc) {
        return Column(children: [
          Column(key: _contentKey, mainAxisSize: MainAxisSize.min, children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: _PanelChevron(color: widget.chevronColor),
              onTap: () async {
                if (_isPanelOpen) {
                  setState(() => _isPanelOpen = false);
                  await _controller.close();
                } else {
                  setState(() => _isPanelOpen = true);
                  await _controller.open();
                }
              },
            ),
            widget.builder(context, sc),
          ])
        ]);
      },
    );
  }
}

class _PanelChevron extends StatelessWidget {
  const _PanelChevron({Key key, @required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 6,
      margin: Margin.horizontal(20) + Margin.vertical(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: EdgeRadius.all(20),
      ),
    );
  }
}
