extension ListListMerging<T> on List<List<T>> {
  ///Do that:
  ///```dart
  /// //Input
  /// final output = [
  ///   [elementT, elementT],
  ///   [elementT, elementT, elementT, elementT],
  ///   [elementT, elementT, elementT],
  /// ].merge();
  ///
  ///
  /// //Printing result
  /// print(output);
  ///
  /// [
  ///   elementT,
  ///   elementT,
  ///   elementT,
  ///   elementT,
  ///   elementT,
  ///   elementT,
  ///   elementT,
  ///   elementT,
  ///   elementT,
  /// ]
  ///```
  List<T> merge() {
    return fold<List<T>>(
      [],
      (prev, element) => prev..addAll(element),
    );
  }

  ///Do that:
  ///```dart
  /// //Input
  /// final List<Widget> children = [
  ///   [SideBarMenuItem(), SideBarMenuItem, SideBarMenuItem()]
  ///   [SideBarMenuItem(), SideBarMenuItem()]
  /// ].fuse<Widget>(
  ///     (item) => SideBarMenuTile(item),
  ///     sepatarorBetweenItems: const Spacer(),
  ///     separatorBetweenLists: const BigSpacer()
  ///   );
  ///
  ///
  /// //Printing result
  /// print(children);
  ///
  /// [
  ///   SideBarMenuItem(),
  ///   const Spacer(),
  ///   SideBarMenuItem(),
  ///   const Spacer(),
  ///   SideBarMenuItem(),
  ///   const BigSpacer(),
  ///   SideBarMenuItem(),
  ///   const Spacer(),
  ///   SideBarMenuItem(),
  /// ]
  ///```
  List<E> fuse<E>(
    E Function(T e) element, {
    E? sepatarorBetweenItems,
    E? separatorBetweenLists,
  }) {
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
  ///Do that:
  ///```dart
  /// if (!contains(element)) add(element);
  ///```
  void addIfNotContains(T element) {
    if (!contains(element)) add(element);
  }

  ///Do that:
  ///```dart
  /// //Input
  /// final List<Widget> children = [
  ///   ProductModel(),
  ///   ProductModel(),
  ///   ProductModel(),
  ///   ProductModel(),
  /// ].fuse<Widget>((index, product) {
  ///   return ProductTile(product);
  /// }, const Spacer());
  ///
  ///
  /// //Printing result
  /// print(children);
  ///
  /// [
  ///   ProductTile(),
  ///   const Spacer(),
  ///   ProductTile(),
  ///   const Spacer(),
  ///   ProductTile(),
  ///   const Spacer(),
  ///   ProductTile(),
  /// ]
  ///```
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

  List<E> mapIndexed<E>(E Function(int index, T value) f) {
    final List<E> items = [];
    for (int i = 0; i < length; i++) {
      items.add(f(i, this[i]));
    }
    return items;
  }

  ///Do that:
  ///```dart
  /// //Input
  /// final output = [
  ///   ProductTile(),
  ///   ProductTile(),
  ///   ProductTile(),
  ///   ProductTile(),
  /// ].separete(const Spacer());
  ///
  ///
  /// //Printing result
  /// print(output);
  ///
  /// [
  ///   ProductTile(),
  ///   const Spacer(),
  ///   ProductTile(),
  ///   const Spacer(),
  ///   ProductTile(),
  ///   const Spacer(),
  ///   ProductTile(),
  /// ]
  ///```
  List<T> separete(T separator) {
    final List<T> items = [];
    for (int i = 0; i < length; i++) {
      items.addAll([this[i], if (i != length - 1) separator]);
    }
    return items;
  }
}
