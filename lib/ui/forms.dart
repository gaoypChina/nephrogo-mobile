import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDropdownMenuItem<T> {
  final Key key;
  final String text;
  final T value;

  AppDropdownMenuItem({this.key, @required this.text, @required this.value});
}

class AppDropdownButtonFormField<T> extends StatelessWidget {
  final String labelText;
  final String helperText;
  final IconData iconData;
  final FormFieldValidator<String> validator;

  final FormFieldSetter<T> onSaved;
  final ValueChanged<T> onChanged;

  final T value;

  final List<AppDropdownMenuItem> items;

  const AppDropdownButtonFormField({
    Key key,
    @required this.items,
    @required this.onChanged,
    this.labelText,
    this.helperText,
    this.iconData,
    this.validator,
    this.onSaved,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<T>> dropdownItems = items
        .map(
          (e) => DropdownMenuItem<T>(
            key: e.key,
            value: e.value,
            child: Text(
              e.text,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(),
          labelText: labelText,
          helperText: helperText,
          icon: iconData != null ? Icon(iconData) : null,
        ),
        isExpanded: true,
        value: value,
        onChanged: onChanged,
        onSaved: onSaved,
        items: dropdownItems,
      ),
    );
  }
}

class AppTextFormField extends StatelessWidget {
  final String labelText;
  final String helperText;
  final IconData iconData;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final String suffixText;

  const AppTextFormField({
    Key key,
    @required this.onSaved,
    @required this.labelText,
    this.helperText,
    this.iconData,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(),
          labelText: labelText,
          helperText: helperText,
          suffixText: suffixText,
          icon: iconData != null ? Icon(iconData) : null,
        ),
        validator: validator,
        onSaved: onSaved,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      ),
    );
  }
}

class AppIntegerFormField extends StatelessWidget {
  final String labelText;
  final String helperText;
  final IconData iconData;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<int> onSaved;
  final String suffixText;

  const AppIntegerFormField({
    Key key,
    @required this.onSaved,
    @required this.labelText,
    this.helperText,
    this.iconData,
    this.validator,
    this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      labelText: labelText,
      helperText: helperText,
      iconData: iconData,
      validator: validator,
      onSaved: onSaved != null ? _onSaved : null,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      suffixText: suffixText,
    );
  }

  _onSaved(String v) {
    int n = int.parse(v);

    this.onSaved(n);
  }
}
