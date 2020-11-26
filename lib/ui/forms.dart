import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppDropdownMenuItem<T> {
  final Key key;
  final String text;
  final T value;

  AppDropdownMenuItem({this.key, @required this.text, @required this.value});
}

const _defaultFieldPadding = const EdgeInsets.all(8.0);

class AppDropdownButtonFormField<T> extends StatelessWidget {
  final String labelText;
  final String helperText;
  final IconData iconData;
  final FormFieldValidator<String> validator;

  final FormFieldSetter<T> onSaved;
  final ValueChanged<T> onChanged;

  final T value;
  final EdgeInsets padding;

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
    this.padding = _defaultFieldPadding,
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
      padding: padding,
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
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
  final TextEditingController controller;
  final String labelText;
  final String helperText;
  final String initialValue;
  final IconData iconData;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final String suffixText;
  final GestureTapCallback onTap;
  final EdgeInsets padding;
  final bool disabled;
  final bool autoFocus;

  const AppTextFormField({
    Key key,
    @required this.onSaved,
    @required this.labelText,
    this.helperText,
    this.iconData,
    this.validator,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.suffixText,
    this.onTap,
    this.initialValue,
    this.padding = _defaultFieldPadding,
    this.autoFocus = false,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          helperText: helperText,
          suffixText: suffixText,
          icon: iconData != null ? Icon(iconData) : null,
        ),
        validator: validator,
        onSaved: onSaved,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        controller: controller,
        initialValue: initialValue,
        readOnly: disabled,
        autofocus: autoFocus,
        enableInteractiveSelection: !disabled,
        onTap: onTap,
      ),
    );
  }
}

class AppInputDatePickerFormField extends StatelessWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  final String labelText;
  final IconData iconData;
  final ValueChanged<DateTime> onDateSaved;
  final DateFormat dateFormat;
  final EdgeInsets padding;

  const AppInputDatePickerFormField({
    Key key,
    @required this.initialDate,
    @required this.firstDate,
    @required this.lastDate,
    this.dateFormat,
    this.labelText,
    this.iconData,
    this.onDateSaved,
    this.padding = _defaultFieldPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InputDatePickerFormField(
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        fieldLabelText: labelText,
        // fieldHintText: "yyyy/mm/dd",
        onDateSaved: onDateSaved,
      ),
    );
  }
}

typedef ValueToStringConverter<T> = String Function(T v);

class AppSelectionFormField<T> extends StatefulWidget {
  final String labelText;
  final String helperText;
  final IconData iconData;
  final FormFieldValidator<String> validator;
  final void Function(T newValue) onSaved;
  final autoFocus;

  final T initialValue;
  final Future<T> Function() onTap;
  final ValueToStringConverter<T> valueToTextConverter;

  const AppSelectionFormField({
    Key key,
    @required this.onTap,
    @required this.valueToTextConverter,
    this.labelText,
    this.helperText,
    this.iconData,
    this.validator,
    this.onSaved,
    this.initialValue,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  _AppSelectionFormFieldState<T> createState() =>
      _AppSelectionFormFieldState<T>();
}

class _AppSelectionFormFieldState<T> extends State<AppSelectionFormField> {
  T _selectedValue;

  @override
  Widget build(BuildContext context) {
    _setValueIfNonNull(widget.initialValue);

    return AppTextFormField(
      labelText: widget.labelText,
      initialValue: convertValueToText(widget.initialValue),
      helperText: widget.helperText,
      iconData: widget.iconData,
      validator: widget.validator,
      disabled: true,
      autoFocus: widget.autoFocus,
      onTap: _onTap,
      onSaved: _onSaved,
    );
  }

  String convertValueToText(T value) {
    if (value == null) {
      return "";
    }
    return widget.valueToTextConverter(value);
  }

  _setValueIfNonNull(T value) {
    if (value != null) {
      setState(() {
        _selectedValue = value;
      });
    }
  }

  _onTap() async {
    final value = await widget.onTap();

    _setValueIfNonNull(value);
  }

  _onSaved(String v) {
    widget.onSaved(_selectedValue);
  }
}

class AppDatePickerFormField extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  final String labelText;
  final String helperText;
  final IconData iconData;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<DateTime> onSaved;
  final DateFormat dateFormat;

  const AppDatePickerFormField({
    Key key,
    @required this.initialDate,
    @required this.firstDate,
    @required this.lastDate,
    this.dateFormat,
    this.labelText,
    this.helperText,
    this.iconData,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  _AppDatePickerFormFieldState createState() => _AppDatePickerFormFieldState();
}

class _AppDatePickerFormFieldState extends State<AppDatePickerFormField> {
  static final DateFormat _defaultDateFormat = DateFormat.yMd();

  DateTime _selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return AppSelectionFormField<DateTime>(
      onTap: _onTap,
      valueToTextConverter: _dateTimeToTextConverter,
      // initialValue: _selectedDateTime ?? widget.initialDate,
      labelText: widget.labelText,
      helperText: widget.helperText,
      iconData: widget.iconData,
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }

  Future<DateTime> _onTap() async {
    return await showDatePicker(
      context: context,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      initialDate: widget.initialDate,
    );
  }

  String _dateTimeToTextConverter(DateTime dateTime) {
    final dateFormat = widget.dateFormat ?? _defaultDateFormat;

    return dateFormat.format(_selectedDateTime);
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
