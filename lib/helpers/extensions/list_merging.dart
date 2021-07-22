extension ListListMerging<T> on List<List<T>> {
  List<T> merge() {
    return fold<List<T>>(
      [],
      (prev, element) => prev..addAll(element),
    );
  }

  List<E> fuse<E>(E Function(T e) element,
      {E? sepatarorBetweenItems, E? separatorBetweenLists}) {
    final List<E> items = [];
    for (int i = 0; i < length; i++) {
      items.addAll([
        ...this[i].fuse((index, e) => element(e), sepatarorBetweenItems),
        if (i != length - 1 && separatorBetweenLists != null)
          separatorBetweenLists
      ]);
    }
    return items;
  }
}

extension ListMerging<T> on List<T> {
  void addIfNotContains(T element) {
    if (!contains(element)) add(element);
  }

  List<E> fuse<E>(E Function(int index, T e) element, [E? separator]) {
    final List<E> items = [];
    for (int i = 0; i < length; i++) {
      items.addAll([
        element(i, this[i]),
        if (i != length - 1 && separator != null) separator
      ]);
    }
    return items;
  }

  List<T> separete(T separator) {
    final List<T> items = [];
    for (int i = 0; i < length; i++) {
      items.addAll([this[i], if (i != length - 1) separator]);
    }
    return items;
  }
}
