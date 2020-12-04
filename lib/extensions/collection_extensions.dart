import 'dart:core';
import 'dart:math' as math;

extension IndexedIterable<E> on Iterable<E> {
  // https://stackoverflow.com/questions/54990716/flutter-get-iteration-index-from-list-map
  Iterable<T> mapIndexed<T>(T Function(int i, E e) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }

  // https://stackoverflow.com/questions/54029370/flutter-dart-how-to-groupby-list-of-maps
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));

  // https://stackoverflow.com/questions/58446296/get-the-first-element-of-list-if-it-exists-in-dart
  E firstOrNull() {
    return this == null || this.isEmpty ? null : this.first;
  }
}

extension ListExtensions<E> on List<E> {
  List<E> shift(int n) {
    if (this.isEmpty) return this;
    var i = n % this.length;
    return this.sublist(i)..addAll(this.sublist(0, i));
  }
}

extension NumericIterable<E extends num> on Iterable<E> {
  E get sum => reduce((a, b) => a + b);

  E get max => reduce(math.max);
}
