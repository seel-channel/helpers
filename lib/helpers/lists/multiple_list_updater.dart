import 'package:helpers/helpers.dart';

class MultipleListUpdater<T, L extends List<List<T>>> {
  MultipleListUpdater(L elements)
      : _elements = elements,
        _builder = null;

  MultipleListUpdater.lazy(L Function() builder)
      : _builder = builder,
        _elements = null;

  final L Function()? _builder;

  final L? _elements;

  L get elements => _elements ?? _builder!();

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
