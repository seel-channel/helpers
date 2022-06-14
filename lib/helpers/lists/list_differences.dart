import 'package:flutter/foundation.dart';
import 'package:helpers/helpers.dart';

class ListDifference<T> {
  ListDifference({
    List<T> initialValues = const [],
    List<T> currentValues = const [],
    this.containsValidator,
  }) {
    final List<T> _initial = initialValues.removeDuplicates();
    final List<T> _current = currentValues.removeDuplicates();

    if (!listEquals(_initial, _current)) {
      if (_initial.isEmpty) {
        added.addAll(_current);
      } else {
        for (final item in _initial) {
          if (!_validator(_current, item)) removed.add(item);
        }
        for (final item in _current) {
          if (!_validator(_initial, item)) added.add(item);
        }
      }
      equals.addAll(currentValues.where((e) => _validator(initialValues, e)));
    } else {
      equals.addAll(_current);
    }
  }

  bool _validator(List<T> elements, T item) {
    return containsValidator?.call(elements, item) ?? elements.contains(item);
  }

  final bool Function(List<T> elements, T e)? containsValidator;
  final List<T> added = [];
  final List<T> removed = [];
  final List<T> equals = [];

  @override
  String toString() =>
      "ListDifference(added: $added, removed: $removed, equals: $equals)";
}
