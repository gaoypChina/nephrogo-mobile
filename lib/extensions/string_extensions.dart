import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }

    return '${this[0].toUpperCase()}${substring(1)}';
  }

  // https://github.com/flutter/flutter/issues/18761
  String get overflow => Characters(this)
      .replaceAll(Characters(''), Characters('\u{200B}'))
      .toString();
}
