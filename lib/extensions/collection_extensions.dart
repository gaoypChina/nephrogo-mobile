import 'dart:core';

import 'package:collection/collection.dart' as collection;

extension IndexedIterable<E> on Iterable<E> {
  //https://stackoverflow.com/questions/53547997/sort-a-list-of-objects-in-flutter-dart-by-property-value
  List<E> sortedBy(Comparable Function(E e) key, {bool reverse = false}) {
    if (reverse) {
      return toList()..sort((a, b) => key(b).compareTo(key(a)));
    }
    return toList()..sort((a, b) => key(a).compareTo(key(b)));
  }

  Map<T, List<E>> groupBy<T>(T Function(E) key) {
    return collection.groupBy(this, key);
  }

  // https://stackoverflow.com/questions/58446296/get-the-first-element-of-list-if-it-exists-in-dart
  E firstOrNull() {
    return this == null || isEmpty ? null : first;
  }

  E lastOrNull() {
    return this == null || isEmpty ? null : last;
  }
}

extension ListExtensions<E> on List<E> {
  List<E> shift(int n) {
    if (isEmpty) return this;
    final i = n % length;
    return sublist(i)..addAll(sublist(0, i));
  }
}

extension NumericIterable<E extends num> on Iterable<E> {
  // E get max => maxBy((v) => v);
}
