import 'dart:core';

import 'package:collection/collection.dart' as collection;

extension IndexedIterable<E> on Iterable<E> {
  //https://stackoverflow.com/questions/53547997/sort-a-list-of-objects-in-flutter-dart-by-property-value
  List<E> orderBy(Comparable Function(E e) key, {bool reverse = false}) {
    // TODO replace using collection function
    if (reverse) {
      return toList()..sort((a, b) => key(b).compareTo(key(a)));
    }
    return toList()..sort((a, b) => key(a).compareTo(key(b)));
  }

  Map<T, List<E>> groupBy<T>(T Function(E) key) {
    return collection.groupBy(this, key);
  }

  // https://stackoverflow.com/questions/58446296/get-the-first-element-of-list-if-it-exists-in-dart
  E? firstOrNull() {
    return isEmpty ? null : first;
  }

  E? lastOrNull() {
    return isEmpty ? null : last;
  }

  num sumBy(num Function(E e) func) {
    return map(func).sum;
  }

  // TODO null operator is possibly not needed
  E? maxBy<T>(T Function(E e) func) {
    // ignore: null_check_on_nullable_type_parameter
    return collection.maxBy<E, T>(this, (e) => func(e!));
  }

  E? get max => collection.maxBy(this, (e) => e);
}
