extension IntExtensionHelper on int {
  void forEach(void Function(int) f) {
    for (var i = 0; i < this; i++) {
      f(i);
    }
  }
}
