import 'package:flutter/material.dart';
import 'package:helpers/helpers.dart';

class KeyboardVisibilityBuilder extends StatefulWidget {
  const KeyboardVisibilityBuilder({
    Key? key,
    this.child,
    required this.builder,
  }) : super(key: key);

  final Widget Function(
    BuildContext context,
    bool isKeyboardVisible,
    Widget? child,
  ) builder;

  final Widget? child;

  @override
  _KeyboardVisibilityBuilderState createState() =>
      _KeyboardVisibilityBuilderState();
}

class _KeyboardVisibilityBuilderState extends State<KeyboardVisibilityBuilder>
    with WidgetsBindingObserver {
  final WidgetsBinding _instance = WidgetsBinding.instance;
  bool _isKeyboardVisible = false;

  @override
  void didChangeMetrics() {
    final bottomInset = _instance.window.viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      _isKeyboardVisible = newValue;
      if (mounted) setState(() {});
    }
    super.didChangeMetrics();
  }

  @override
  void dispose() {
    _instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    _instance.addObserver(this);
    didChangeMetrics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        _isKeyboardVisible,
        widget.child,
      );
}

class DismissKeyboard extends StatelessWidget {
  ///Tapping on a Widget will apply the FocusScope to it and hide the keyboard.
  const DismissKeyboard({
    Key? key,
    this.child,
    this.behavior = HitTestBehavior.opaque,
  }) : super(key: key);

  final HitTestBehavior behavior;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Misc.dismissKeyboard(context),
      behavior: behavior,
      child: child,
    );
  }
}
