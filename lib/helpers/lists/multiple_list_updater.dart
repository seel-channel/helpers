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

  void replaceOrAdd(ReplaceValidator<T> validator, T value) {
    if (!replaceWhere(validator, (e) => value)) add(value);
  }

  void add(T value) {
    for (final item in elements) {
      item.add(value);
    }
  }

  void clear() {
    for (final element in elements) {
      element.clear();
    }
  }

  bool replaceWhere(
      ReplaceValidator<T> validator, ReplaceValue<T> replaceValue) {
    bool hasReplaced = false;
    for (final item in elements) {
      if (item.replaceWhere(validator, replaceValue)) hasReplaced = true;
    }
    return hasReplaced;
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
