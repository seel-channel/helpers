import 'package:flutter/widgets.dart';

extension TextEditingControllerHelperExtension on TextEditingController {
  void toSelectionEnd() {
    selection = TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
