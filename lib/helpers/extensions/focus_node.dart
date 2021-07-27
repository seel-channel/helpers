import 'package:flutter/cupertino.dart';

extension FocusNodeHelpersExtension on FocusNode {
  void changeFocus({bool? hasFocus}) {
    if (hasFocus ?? this.hasFocus) {
      unfocus();
    } else {
      requestFocus();
    }
  }
}
