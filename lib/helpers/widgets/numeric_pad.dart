import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

const List<List<NumericPadNumber>> kNumericPadNumbers = [
  [NumericPadNumber.one, NumericPadNumber.two, NumericPadNumber.three],
  [NumericPadNumber.four, NumericPadNumber.five, NumericPadNumber.six],
  [NumericPadNumber.seven, NumericPadNumber.eight, NumericPadNumber.nine]
];

class NumericPadNumber {
  const NumericPadNumber({required this.title, this.child});

  final String title;
  final Widget? child;

  static const NumericPadNumber none = NumericPadNumber(title: "");
  static const NumericPadNumber dot = NumericPadNumber(title: ".");
  static const NumericPadNumber zero = NumericPadNumber(title: "0");
  static const NumericPadNumber one = NumericPadNumber(title: "1");
  static const NumericPadNumber two = NumericPadNumber(title: "2");
  static const NumericPadNumber three = NumericPadNumber(title: "3");
  static const NumericPadNumber four = NumericPadNumber(title: "4");
  static const NumericPadNumber five = NumericPadNumber(title: "5");
  static const NumericPadNumber six = NumericPadNumber(title: "6");
  static const NumericPadNumber seven = NumericPadNumber(title: "7");
  static const NumericPadNumber eight = NumericPadNumber(title: "8");
  static const NumericPadNumber nine = NumericPadNumber(title: "9");
}

class NumericPadStyle {
  const NumericPadStyle({
    this.style,
    this.buttonWidth = 48,
    this.buttonHeight = 48,
    this.buttonPadding,
    this.buttonShape = BoxShape.circle,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  final TextStyle? style;
  final double? buttonWidth, buttonHeight;
  final EdgeInsetsGeometry? buttonPadding;
  final MainAxisAlignment mainAxisAlignment;
  final BoxShape buttonShape;
}

class NumericPad extends StatefulWidget {
  const NumericPad({
    Key? key,
    required this.onButtonTap,
    this.style = const NumericPadStyle(),
    this.numbers = const [
      ...kNumericPadNumbers,
      [NumericPadNumber.dot, NumericPadNumber.zero, NumericPadNumber.none],
    ],
  }) : super(key: key);

  final NumericPadStyle style;

  /// Callback when an item is pressed
  final void Function(String text) onButtonTap;

  final List<List<NumericPadNumber>> numbers;

  @override
  State<StatefulWidget> createState() => _NumericPadState();
}

class _NumericPadState extends State<NumericPad> {
  @override
  Widget build(BuildContext context) {
    return _NumericInheritedWidget(
      style: widget.style,
      onTap: widget.onButtonTap,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        for (final list in widget.numbers)
          Row(
            mainAxisAlignment: widget.style.mainAxisAlignment,
            children: list.map<Widget>((e) => _NumericButton(e)).toList(),
          ),
      ]),
    );
  }
}

class _NumericInheritedWidget extends InheritedWidget {
  const _NumericInheritedWidget({
    Key? key,
    required this.onTap,
    required this.style,
    required Widget child,
  }) : super(key: key, child: child);

  final NumericPadStyle style;
  final void Function(String text) onTap;

  static _NumericInheritedWidget of(BuildContext context) {
    final _NumericInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_NumericInheritedWidget>();
    assert(result != null, 'No _NumericInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_NumericInheritedWidget old) =>
      style != old.style || onTap != old.onTap;
}

class _NumericButton extends StatelessWidget {
  const _NumericButton(this.number, {Key? key}) : super(key: key);

  final NumericPadNumber number;

  @override
  Widget build(BuildContext context) {
    final _NumericInheritedWidget _numeric =
        _NumericInheritedWidget.of(context);

    return SplashTap(
      onTap:
          number.title.isNotEmpty ? () => _numeric.onTap(number.title) : null,
      shape: _numeric.style.buttonShape,
      child: Container(
        alignment: Alignment.center,
        width: _numeric.style.buttonWidth,
        height: _numeric.style.buttonHeight,
        padding: _numeric.style.buttonPadding,
        child: number.child ??
            Text(
              number.title,
              style: _numeric.style.style ??
                  context.textTheme.bodyText1 ??
                  const TextStyle(),
            ),
      ),
    );
  }
}
