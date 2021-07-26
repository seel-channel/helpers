import 'package:flutter/material.dart';

class DoubleColumn extends StatelessWidget {
  ///It's create a double column with a space beetween.
  ///```dart
  /// return Row(children: [
  ///   Column(children: leftColumn),
  ///   SizedBox(width: spaceBeetween),
  ///   Column(children: rightColumn),
  /// ]);
  ///```
  const DoubleColumn({
    Key? key,
    this.leftColumn,
    this.rightColumn,
    this.spaceBeetween = 20,
    this.columnSize = MainAxisSize.min,
  }) : super(key: key);

  final double spaceBeetween;
  final MainAxisSize columnSize;
  final List<Widget>? leftColumn;
  final List<Widget>? rightColumn;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: columnSize,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: leftColumn!,
        ),
        SizedBox(width: spaceBeetween),
        Column(
          mainAxisSize: columnSize,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rightColumn!,
        ),
      ],
    );
  }
}

class RemoveScrollGlow extends StatelessWidget {
  ///Eliminate the Splash Effect or Glow Effect when reaching
  ///the limit of a PageView, ScrollView, ListView, etc.
  const RemoveScrollGlow({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowGlow();
        return;
      } as bool Function(OverscrollIndicatorNotification)?,
      child: child,
    );
  }
}

class DismissKeyboard extends StatelessWidget {
  ///Tapping on a Widget will apply the FocusScope to it and hide the keyboard.
  const DismissKeyboard({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) focus.requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}

class SizeBuilder extends StatefulWidget {
  ///```dart
  /////EXAMPLE:
  /// SizeBuilder(builder: (width, height) {
  ///    Size layout = Size(width, height);
  ///    return Container(
  ///       width: width,
  ///       height: height,
  ///       color: Colors.red,
  ///    );
  ///  });
  ///
  ///
  /////RETURN THAT:
  ///return LayoutBuilder(builder: (_, constraints) {
  ///   return widget.builder(constraints.maxWidth, constraints.maxHeight);
  ///});
  ///```
  const SizeBuilder({Key? key, this.builder}) : super(key: key);

  ///Argument `(double width, double height)`
  final Widget Function(double width, double height)? builder;

  @override
  _SizeBuilderState createState() => _SizeBuilderState();
}

class _SizeBuilderState extends State<SizeBuilder> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return widget.builder!(constraints.maxWidth, constraints.maxHeight);
    });
  }
}

//--------//
//EXPANDED//
//--------//
class ExpandedSpacer extends StatelessWidget {
  ///```dart
  ///return Expanded(child: SizedBox())
  ///```
  const ExpandedSpacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: SizedBox());
  }
}

class ExpandedTap extends StatelessWidget {
  ///```dart
  ///return Expanded(
  ///   child: GestureDetector(
  ///     onTap: onTap,
  ///     child: child,
  ///   ),
  ///);
  ///```
  const ExpandedTap({Key? key, this.onTap, this.child}) : super(key: key);

  final Widget? child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: child,
      ),
    );
  }
}

class ExpandedAlign extends StatelessWidget {
  ///```dart
  ///return Expanded(
  ///   child: Align(alignment: alignment, child: child),
  ///);
  ///```
  const ExpandedAlign({
    Key? key,
    this.alignment = Alignment.centerRight,
    this.child,
  }) : super(key: key);
  final Alignment alignment;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(alignment: alignment, child: child),
    );
  }
}

class SafeAreaColor extends StatelessWidget {
  ///```dart
  ///  return Container(
  ///    color: color,
  ///    child: SafeArea(
  ///      child: Container(
  ///        height: height,
  ///        child: child,
  ///      ),
  ///    ),
  ///  );
  /// ```
  const SafeAreaColor(
      {Key? key,
      this.child,
      this.color = Colors.white,
      this.height,
      this.width = double.infinity})
      : super(key: key);

  final Color color;
  final Widget? child;
  final double width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: width,
      child: SafeArea(
        child: SizedBox(
          height: height,
          child: child,
        ),
      ),
    );
  }
}

///---//
///TAP//
///---//
class OpaqueTap extends StatelessWidget {
  ///```dart
  ///return GestureDetector(
  ///  onTap: onTap,
  ///  child: child,
  ///  behavior: HitTestBehavior.opaque,
  ///);
  ///```
  const OpaqueTap({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  final void Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}

class SplashTap extends StatelessWidget {
  const SplashTap({
    Key? key,
    required this.onTap,
    required this.child,
    this.color,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  final Color? color;

  final Widget child;

  final BoxShape shape;

  ///Creates an ink well.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(color: color, shape: shape),
        child: InkWell(
          onTap: onTap,
          customBorder: shape == BoxShape.circle ? const CircleBorder() : null,
          child: child,
        ),
      ),
    );
  }
}

class SplashButton extends StatelessWidget {
  const SplashButton({
    Key? key,
    required this.onTap,
    required this.child,
    this.color = Colors.blue,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    this.boxShadow,
    this.shape = BoxShape.rectangle,
  })  : padding = padding ?? const EdgeInsets.all(20.0),
        borderRadius =
            borderRadius ?? const BorderRadius.all(Radius.circular(20.0)),
        super(key: key);

  final Color color;
  final Widget child;
  final BoxShape shape;

  ///Creates an ink well.
  final void Function() onTap;

  ///The border radius of the rounded corners.
  ///Values are clamped so that horizontal and vertical radii sums do not exceed width/height.
  ///
  ///Default:
  /// ```dart
  ///const BorderRadius.all(Radius.circular(20.0))
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

  ///A list of shadows cast by this box behind the box.
  ///
  ///The shadow follows the [shape] of the box.
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: shape,
        borderRadius: shape != BoxShape.circle ? borderRadius : null,
        boxShadow: boxShadow,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: SplashTap(
          onTap: onTap,
          color: color,
          shape: shape,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

class TileDesigned extends StatelessWidget {
  const TileDesigned({
    Key? key,
    this.onTap,
    this.prefix,
    this.child,
    this.suffix,
    this.background = Colors.transparent,
    this.padding = const EdgeInsets.all(20.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(20.0)),
  }) : super(key: key);

  final Color background;

  ///You can wrap it in an Expanded.
  final Widget? prefix, suffix, child;

  ///Creates an ink well.
  final void Function()? onTap;

  ///The border radius of the rounded corners.
  ///Values are clamped so that horizontal and vertical radii sums do not exceed width/height.
  ///
  ///Default:
  /// ```dart
  ///const BorderRadius.all(Radius.circular(20.0))
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
      child: SplashTap(
        onTap: onTap,
        color: background,
        child: Container(
          padding: padding,
          child: Row(children: [
            if (prefix != null) prefix!,
            if (child != null) child!,
            if (suffix != null) suffix!
          ]),
        ),
      ),
    );
  }
}
