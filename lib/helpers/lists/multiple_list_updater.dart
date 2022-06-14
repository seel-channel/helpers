import 'package:helpers/helpers.dart';

class MultipleListUpdater<T> {
  MultipleListUpdater(List<List<T>> elements)
      : _elements = elements,
        _builder = null;

  MultipleListUpdater.lazy(List<List<T>> Function() builder)
      : _builder = builder,
        _elements = null;

  final List<List<T>> Function()? _builder;

  final List<List<T>>? _elements;

  List<List<T>> get elements => _elements ?? _builder!();

  void add(T value) {
    for (final item in elements) {
      item.add(value);
    }
  }

  void replaceWhere(
      ReplaceValidator<T> validator, ReplaceValue<T> replaceValue) {
    for (final item in elements) {
      item.replaceWhere(validator, replaceValue);
    }
  }

  void remove(T value) {
    for (final item in elements) {
      item.remove(value);
    }
  }

  void removeWhere(ReplaceValidator<T> validator) {
    for (final item in elements) {
      item.removeWhere(validator);
    }
  }
}
