import 'dart:core';

// https://stackoverflow.com/questions/54990716/flutter-get-iteration-index-from-list-map
extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int i, E e) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}

extension NumericIterable<E extends num> on Iterable<E> {
  E sum() {
    return reduce((a, b) => a + b);
  }
}
