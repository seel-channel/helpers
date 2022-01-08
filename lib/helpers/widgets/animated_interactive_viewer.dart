import 'package:flutter/material.dart';

class AnimatedInteractiveViewer extends StatefulWidget {
  ///It is very similar to the InteractiveViewer except the AnimatedInteractiveViewer
  ///have a double-tap animated zoom
  const AnimatedInteractiveViewer({
    Key? key,
    required this.child,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 200),
    this.clipBehavior = Clip.none,
    this.alignPanAxis = false,
    this.boundaryMargin = EdgeInsets.zero,
    this.constrained = true,
    this.panEnabled = true,
    this.scaleEnabled = true,
    this.maxScale = 2.0,
    this.minScale = 0.8,
    this.onInteractionEnd,
    this.onInteractionStart,
    this.onInteractionUpdate,
    this.transformationController,
    this.onDoubleTapDown,
  }) : super(key: key);

  /// It is the curve that the SwipeTransition performs
  final Curve curve;

  /// The Widget to perform the transformations on.
  ///
  /// Cannot be null.
  final Widget child;

  ///The length of time than the double-tap zoom
  ///
  ///Default: `Duration(milliseconds: 200)`
  final Duration duration;

  /// If set to [Clip.none], the child may extend beyond the size of the InteractiveViewer,
  /// but it will not receive gestures in these areas.
  /// Be sure that the InteractiveViewer is the desired size when using [Clip.none].
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// If true, panning is only allowed in the direction of the horizontal axis
  /// or the vertical axis.
  ///
  /// In other words, when this is true, diagonal panning is not allowed. A
  /// single gesture begun along one axis cannot also cause panning along the
  /// other axis without stopping and beginning a new gesture. This is a common
  /// pattern in tables where data is displayed in columns and rows.
  ///
  /// See also:
  ///  * [constrained], which has an example of creating a table that uses
  ///    alignPanAxis.
  final bool alignPanAxis;

  /// A margin for the visible boundaries of the child.
  ///
  /// Any transformation that results in the viewport being able to view outside
  /// of the boundaries will be stopped at the boundary. The boundaries do not
  /// rotate with the rest of the scene, so they are always aligned with the
  /// viewport.
  ///
  /// To produce no boundaries at all, pass infinite [EdgeInsets], such as
  /// `EdgeInsets.all(double.infinity)`.
  ///
  /// No edge can be NaN.
  ///
  /// Defaults to [EdgeInsets.zero], which results in boundaries that are the
  /// exact same size and position as the [child].
  final EdgeInsets boundaryMargin;

  /// Whether the normal size constraints at this point in the widget tree are
  /// applied to the child.
  ///
  /// If set to false, then the child will be given infinite constraints. This
  /// is often useful when a child should be bigger than the InteractiveViewer.
  ///
  /// For example, for a child which is bigger than the viewport but can be
  /// panned to reveal parts that were initially offscreen, [constrained] must
  /// be set to false to allow it to size itself properly. If [constrained] is
  /// true and the child can only size itself to the viewport, then areas
  /// initially outside of the viewport will not be able to receive user
  /// interaction events. If experiencing regions of the child that are not
  /// receptive to user gestures, make sure [constrained] is false and the child
  /// is sized properly.
  ///
  /// Defaults to true.
  ///
  /// {@tool dartpad --template=stateless_widget_scaffold}
  /// This example shows how to create a pannable table. Because the table is
  /// larger than the entire screen, setting `constrained` to false is necessary
  /// to allow it to be drawn to its full size. The parts of the table that
  /// exceed the screen size can then be panned into view.
  ///
  /// ```dart
  ///   Widget build(BuildContext context) {
  ///     const int _rowCount = 48;
  ///     const int _columnCount = 6;
  ///
  ///     return InteractiveViewer(
  ///       alignPanAxis: true,
  ///       constrained: false,
  ///       scaleEnabled: false,
  ///       child: Table(
  ///         columnWidths: <int, TableColumnWidth>{
  ///           for (int column = 0; column < _columnCount; column += 1)
  ///             column: const FixedColumnWidth(200.0),
  ///         },
  ///         children: <TableRow>[
  ///           for (int row = 0; row < _rowCount; row += 1)
  ///             TableRow(
  ///               children: <Widget>[
  ///                 for (int column = 0; column < _columnCount; column += 1)
  ///                   Container(
  ///                     height: 26,
  ///                     color: row % 2 + column % 2 == 1
  ///                         ? Colors.white
  ///                         : Colors.grey.withOpacity(0.1),
  ///                     child: Align(
  ///                       alignment: Alignment.centerLeft,
  ///                       child: Text('$row x $column'),
  ///                     ),
  ///                   ),
  ///               ],
  ///             ),
  ///         ],
  ///       ),
  ///     );
  ///   }
  /// ```
  /// {@end-tool}
  final bool constrained;

  /// If false, the user will be prevented from panning.
  ///
  /// Defaults to true.
  ///
  /// See also:
  ///
  ///   * [scaleEnabled], which is similar but for scale.
  final bool panEnabled;

  /// If false, the user will be prevented from scaling.
  ///
  /// Defaults to true.
  ///
  /// See also:
  ///
  ///   * [panEnabled], which is similar but for panning.
  final bool scaleEnabled;

  /// The maximum allowed scale.
  ///
  /// The scale will be clamped between this and [minScale] inclusively.
  ///
  /// Defaults to 2.5.
  ///
  /// Cannot be null, and must be greater than zero and greater than minScale.
  final double maxScale;

  /// The minimum allowed scale.
  ///
  /// The scale will be clamped between this and [maxScale] inclusively.
  ///
  /// Scale is also affected by [boundaryMargin]. If the scale would result in
  /// viewing beyond the boundary, then it will not be allowed. By default,
  /// boundaryMargin is EdgeInsets.zero, so scaling below 1.0 will not be
  /// allowed in most cases without first increasing the boundaryMargin.
  ///
  /// Defaults to 0.8.
  ///
  /// Cannot be null, and must be a finite number greater than zero and less
  /// than maxScale.
  final double minScale;

  /// Called when the user ends a pan or scale gesture on the widget.
  ///
  /// At the time this is called, the [TransformationController] will have
  /// already been updated to reflect the change caused by the interaction,
  /// though a pan may cause an inertia animation after this is called as well.
  ///
  /// {@template flutter.widgets.InteractiveViewer.onInteractionEnd}
  /// Will be called even if the interaction is disabled with [panEnabled] or
  /// [scaleEnabled] for both touch gestures and mouse interactions.
  ///
  /// A [GestureDetector] wrapping the InteractiveViewer will not respond to
  /// [GestureDetector.onScaleStart], [GestureDetector.onScaleUpdate], and
  /// [GestureDetector.onScaleEnd]. Use [onInteractionStart],
  /// [onInteractionUpdate], and [onInteractionEnd] to respond to those
  /// gestures.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [onInteractionStart], which handles the start of the same interaction.
  ///  * [onInteractionUpdate], which handles an update to the same interaction.
  final GestureScaleEndCallback? onInteractionEnd;

  /// Called when the user begins a pan or scale gesture on the widget.
  ///
  /// At the time this is called, the [TransformationController] will not have
  /// changed due to this interaction.
  ///
  /// {@macro flutter.widgets.InteractiveViewer.onInteractionEnd}
  ///
  /// The coordinates provided in the details' `focalPoint` and
  /// `localFocalPoint` are normal Flutter event coordinates, not
  /// InteractiveViewer scene coordinates. See
  /// [TransformationController.toScene] for how to convert these coordinates to
  /// scene coordinates relative to the child.
  ///
  /// See also:
  ///
  ///  * [onInteractionUpdate], which handles an update to the same interaction.
  ///  * [onInteractionEnd], which handles the end of the same interaction.
  final GestureScaleStartCallback? onInteractionStart;

  /// Called when the user updates a pan or scale gesture on the widget.
  ///
  /// At the time this is called, the [TransformationController] will have
  /// already been updated to reflect the change caused by the interaction, if
  /// the interation caused the matrix to change.
  ///
  /// {@macro flutter.widgets.InteractiveViewer.onInteractionEnd}
  ///
  /// The coordinates provided in the details' `focalPoint` and
  /// `localFocalPoint` are normal Flutter event coordinates, not
  /// InteractiveViewer scene coordinates. See
  /// [TransformationController.toScene] for how to convert these coordinates to
  /// scene coordinates relative to the child.
  ///
  /// See also:
  ///
  ///  * [onInteractionStart], which handles the start of the same interaction.
  ///  * [onInteractionEnd], which handles the end of the same interaction.
  final GestureScaleUpdateCallback? onInteractionUpdate;

  /// A [TransformationController] for the transformation performed on the
  /// child.
  ///
  /// Whenever the child is transformed, the [Matrix4] value is updated and all
  /// listeners are notified. If the value is set, InteractiveViewer will update
  /// to respect the new value.
  ///
  /// {@tool dartpad --template=stateful_widget_material_ticker}
  /// This example shows how transformationController can be used to animate the
  /// transformation back to its starting position.
  ///
  /// ```dart
  /// final TransformationController _transformationController = TransformationController();
  /// Animation<Matrix4>? _animationReset;
  /// late final AnimationController _controllerReset;
  ///
  /// void _onAnimateReset() {
  ///   _transformationController.value = _animationReset!.value;
  ///   if (!_controllerReset.isAnimating) {
  ///     _animationReset!.removeListener(_onAnimateReset);
  ///     _animationReset = null;
  ///     _controllerReset.reset();
  ///   }
  /// }
  ///
  /// void _animateResetInitialize() {
  ///   _controllerReset.reset();
  ///   _animationReset = Matrix4Tween(
  ///     begin: _transformationController.value,
  ///     end: Matrix4.identity(),
  ///   ).animate(_controllerReset);
  ///   _animationReset!.addListener(_onAnimateReset);
  ///   _controllerReset.forward();
  /// }
  ///
  /// // Stop a running reset to home transform animation.
  /// void _animateResetStop() {
  ///   _controllerReset.stop();
  ///   _animationReset?.removeListener(_onAnimateReset);
  ///   _animationReset = null;
  ///   _controllerReset.reset();
  /// }
  ///
  /// void _onInteractionStart(ScaleStartDetails details) {
  ///   // If the user tries to cause a transformation while the reset animation is
  ///   // running, cancel the reset animation.
  ///   if (_controllerReset.status == AnimationStatus.forward) {
  ///     _animateResetStop();
  ///   }
  /// }
  ///
  /// @override
  /// void initState() {
  ///   super.initState();
  ///   _controllerReset = AnimationController(
  ///     vsync: this,
  ///     duration: const Duration(milliseconds: 400),
  ///   );
  /// }
  ///
  /// @override
  /// void dispose() {
  ///   _controllerReset.dispose();
  ///   super.dispose();
  /// }
  ///
  /// @override
  /// Widget build(BuildContext context) {
  ///   return Scaffold(
  ///     backgroundColor: Theme.of(context).colorScheme.primary,
  ///     appBar: AppBar(
  ///       automaticallyImplyLeading: false,
  ///       title: const Text('Controller demo'),
  ///     ),
  ///     body: Center(
  ///       child: InteractiveViewer(
  ///         boundaryMargin: const EdgeInsets.all(double.infinity),
  ///         transformationController: _transformationController,
  ///         minScale: 0.1,
  ///         maxScale: 1.0,
  ///         onInteractionStart: _onInteractionStart,
  ///         child: Container(
  ///           decoration: const BoxDecoration(
  ///             gradient: LinearGradient(
  ///               begin: Alignment.topCenter,
  ///               end: Alignment.bottomCenter,
  ///               colors: <Color>[Colors.orange, Colors.red],
  ///               stops: <double>[0.0, 1.0],
  ///             ),
  ///           ),
  ///         ),
  ///       ),
  ///     ),
  ///     persistentFooterButtons: <Widget>[
  ///       IconButton(
  ///         onPressed: _animateResetInitialize,
  ///         tooltip: 'Reset',
  ///         color: Theme.of(context).colorScheme.surface,
  ///         icon: const Icon(Icons.replay),
  ///       ),
  ///     ],
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [ValueNotifier], the parent class of TransformationController.
  ///  * [TextEditingController] for an example of another similar pattern.
  final TransformationController? transformationController;

  /// A pointer that might cause a double tap has contacted the screen at a
  /// particular location.
  ///
  /// Triggered immediately after the down event of the second tap.
  ///
  /// If the user completes the double tap and the gesture wins, [onDoubleTap]
  /// will be called after this callback. Otherwise, [onDoubleTapCancel] will
  /// be called after this callback.
  ///
  /// See also:
  ///
  ///  * [kPrimaryButton], the button this callback responds to.
  final GestureTapDownCallback? onDoubleTapDown;

  @override
  _AnimatedInteractiveViewerState createState() =>
      _AnimatedInteractiveViewerState();
}

class _AnimatedInteractiveViewerState extends State<AnimatedInteractiveViewer>
    with TickerProviderStateMixin {
  late TransformationController _controller;
  late AnimationController _animationController;
  Animation<Matrix4>? _animationMatrix4;

  @override
  void dispose() {
    if (widget.transformationController == null) _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = widget.transformationController ?? TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    super.initState();
  }

  //Clear Matrix4 animation
  void _onInteractionStart(ScaleStartDetails details) {
    widget.onInteractionStart?.call(details);
    if (_animationController.status == AnimationStatus.forward) {
      _clearAnimation();
    }
  }

  void _changeControllerMatrix4() {
    _controller.value = _animationMatrix4!.value;
    if (!_animationController.isAnimating) _clearAnimation();
  }

  void _clearAnimation() {
    _animationController.stop();
    _animationMatrix4?.removeListener(_changeControllerMatrix4);
    _animationMatrix4 = null;
    _animationController.reset();
  }

  //Animate MATRIX4
  Future<void> _onDoubleTapHandle(TapDownDetails details) async {
    if (_controller.value == Matrix4.identity()) {
      final double scale = widget.maxScale;
      final Offset position = details.localPosition;
      // final Matrix4 matrix = Matrix4.diagonal3Values(scale, scale, 1.0);

      // if (scale > 2.4) {
      //   matrix.translate(-position.dx, -position.dy);
      // } else {
      //   matrix.setTranslation(vector.Vector3(-position.dx, -position.dy, 0.0));
      // }

      final Matrix4 matrix = Matrix4(
          //Column1
          scale,
          0.0,
          0.0,
          0.0,
          //Column2
          0.0,
          scale,
          0.0,
          0.0,
          //Column3
          0.0,
          0.0,
          scale,
          0.0,
          //Column4
          scale < 2.4 ? -position.dx : -position.dx * scale,
          scale < 2.4 ? -position.dy : -position.dy * scale,
          0.0,
          1.0);
      await animateMatrix4(matrix);
    } else {
      await animateMatrix4(Matrix4.identity());
    }
    widget.onDoubleTapDown?.call(details);
  }

  Future<void> animateMatrix4(Matrix4 value) async {
    _animationMatrix4 = Matrix4Tween(
      begin: _controller.value,
      end: value,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    ));
    _animationController.duration = widget.duration;
    _animationMatrix4!.addListener(_changeControllerMatrix4);
    await _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: widget.minScale,
      maxScale: widget.maxScale,
      transformationController: _controller,
      onInteractionStart: _onInteractionStart,
      onInteractionUpdate: widget.onInteractionUpdate,
      onInteractionEnd: widget.onInteractionEnd,
      clipBehavior: widget.clipBehavior,
      constrained: widget.constrained,
      panEnabled: widget.panEnabled,
      alignPanAxis: widget.alignPanAxis,
      boundaryMargin: widget.boundaryMargin,
      scaleEnabled: widget.scaleEnabled,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onDoubleTap: () {},
        onDoubleTapDown: _onDoubleTapHandle,
        child: widget.child,
      ),
    );
  }
}
