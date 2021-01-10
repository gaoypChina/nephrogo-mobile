import 'package:flutter/material.dart';
import 'package:nephrogo/l10n/localizations.dart';

class FormValidators {
  final AppLocalizations appLocalizations;

  FormValidators(BuildContext context)
      : appLocalizations = AppLocalizations.of(context);

  FormFieldValidator<T> and<T>(
    FormFieldValidator<T> validator1,
    FormFieldValidator<T> validator2,
  ) {
    return (value) {
      return validator1(value) ?? validator2(value);
    };
  }

  FormFieldValidator<T> or<T>(
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

  FormFieldValidator<T> nonNull<T>() {
    return (value) {
      if (value == null) {
        return appLocalizations.formValidatorNonEmptyText;
      }
      return null;
    };
  }

  FormFieldValidator<String> get nonEmptyValidator {
    return (value) {
      if (value == null || value.isEmpty) {
        return appLocalizations.formValidatorNonEmptyText;
      }
      return null;
    };
  }

  FormFieldValidator<String> lengthValidator(int min) {
    final _lengthValidator = (String value) {
      if (value.length < min) {
        return appLocalizations.formValidatorMinLength(min.toString());
      }
      return null;
    };

    return and(nonNull<String>(), _lengthValidator);
  }

  FormFieldValidator<T> numRangeValidator<T extends num>(T min, T max) {
    final _nonNullNumValidator = (T value) {
      if (min > value) {
        return appLocalizations.formValidatorMinValue(min.toString());
      }
      if (max < value) {
        return appLocalizations.formValidatorMaxValue(max.toString());
      }
      return null;
    };

    return and(nonNull<T>(), _nonNullNumValidator);
  }
}
