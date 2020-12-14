import 'package:flutter/material.dart';

class FormValidators {
  static final _nonEmptyText = "Laukelis yra privalomas.";

  static FormFieldValidator<T> and<T>(
    FormFieldValidator<T> validator1,
    FormFieldValidator<T> validator2,
  ) {
    return (value) {
      return validator1(value) ?? validator2(value);
    };
  }

  static FormFieldValidator<T> or<T>(
    FormFieldValidator<T> validator1,
    FormFieldValidator<T> validator2,
  ) {
    return (value) {
      final v1Text = validator1(value);
      if (v1Text == null) {
        return null;
      }

      final v2Text = validator2(value);
      if (v2Text == null) {
        return null;
      }

      return v1Text;
    };
  }

  static FormFieldValidator<T> nonNull<T>() {
    return (value) {
      if (value == null) {
        return _nonEmptyText;
      }
      return null;
    };
  }

  static FormFieldValidator<String> get nonEmptyValidator {
    return (value) {
      if (value == null || value.isEmpty) {
        return _nonEmptyText;
      }
      return null;
    };
  }

  static FormFieldValidator<String> lengthValidator(int min) {
    final _lengthValidator = (String value) {
      if (value.length < min) {
        return "Minimalus ilgis $min simboliai.";
      }
      return null;
    };

    return and(nonNull<String>(), _lengthValidator);
  }

  static FormFieldValidator<T> numRangeValidator<T extends num>(T min, T max) {
    final _nonNullNumValidator = (T value) {
      if (min > value) {
        return "Reikšmė negali būti mažesnė nei $min";
      }
      if (max < value) {
        return "Reikšmė negali būti didesnė nei $max";
      }
      return null;
    };

    return and(nonNull<T>(), _nonNullNumValidator);
  }
}
