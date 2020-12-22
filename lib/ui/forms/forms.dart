import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/date_extensions.dart';

import 'app_form_multi_select_dialog.dart';
import 'app_form_single_select_dialog.dart';

typedef FormFieldItemSetter<T> = void Function(T newItem);

class AppDropdownMenuItem<T> {
  final Key key;
  final String text;
  final T value;

  AppDropdownMenuItem({this.key, @required this.text, @required this.value});
}

const _defaultFieldPadding = const EdgeInsets.all(8.0);

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String helperText;
  final String hintText;
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
  final IconData suffixIconData;
  final bool obscureText;
  final Iterable<String> autofillHints;
  final TextInputAction textInputAction;

  const AppTextFormField({
    Key key,
    @required this.labelText,
    this.onSaved,
    this.helperText,
    this.hintText,
    this.iconData,
    this.validator,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.suffixText,
    this.onTap,
    this.initialValue,
    this.suffixIconData,
    this.padding = _defaultFieldPadding,
    this.autoFocus = false,
    this.disabled = false,
    this.obscureText = false,
    this.autofillHints,
    this.textInputAction,
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
          hintText: hintText,
          suffixIcon: suffixIconData != null ? Icon(suffixIconData) : null,
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
        autofillHints: autofillHints,
        obscureText: obscureText,
        onTap: onTap,
        textInputAction: textInputAction,
      ),
    );
  }
}

class AppSelectFormFieldItem<T> {
  final String text;
  final String description;
  final IconData icon;
  final T value;

  const AppSelectFormFieldItem({
    @required this.text,
    this.description,
    this.icon,
    @required this.value,
  });
}

class AppSelectionScreenFormField<T> extends StatefulWidget {
  final String labelText;
  final String helperText;
  final T initialSelection;
  final String Function(T item) itemToStringConverter;
  final Future<T> Function(BuildContext context) onTap;
  final IconData iconData;
  final FormFieldItemSetter<T> onChanged;
  final FormFieldItemSetter<T> onSaved;
  final FormFieldValidator<T> validator;

  const AppSelectionScreenFormField({
    Key key,
    @required this.onTap,
    @required this.itemToStringConverter,
    this.labelText,
    this.helperText,
    this.initialSelection,
    this.iconData,
    this.onChanged,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  _AppSelectionScreenFormFieldState createState() =>
      _AppSelectionScreenFormFieldState<T>();
}

class _AppSelectionScreenFormFieldState<T>
    extends State<AppSelectionScreenFormField<T>> {
  TextEditingController _textEditingController = TextEditingController();
  T _selectedItem;

  @override
  void initState() {
    super.initState();

    if (widget.initialSelection != null) {
      _setItem(widget.initialSelection, initial: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      labelText: widget.labelText,
      controller: _textEditingController,
      helperText: widget.helperText,
      iconData: widget.iconData,
      disabled: true,
      onTap: () => _onTap(context),
      suffixIconData: Icons.chevron_right,
      onSaved: _onSaved,
      validator: _validator,
    );
  }

  String _validator(String value) {
    if (widget.validator != null) {
      return widget.validator(_selectedItem);
    }
    return null;
  }

  _onSaved(String s) {
    if (widget.onSaved != null) {
      widget.onSaved(_selectedItem);
    }
  }

  Future _onTap(BuildContext context) async {
    final selectedItem = await widget.onTap(context);

    if (selectedItem != null) {
      _setItem(selectedItem);
    }
  }

  _setItem(T item, {initial: false}) {
    _selectedItem = item;
    _textEditingController.text = widget.itemToStringConverter(_selectedItem);

    if (!initial && widget.onChanged != null) {
      widget.onChanged(item);
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }
}

class AppSelectFormField<T> extends StatefulWidget {
  final List<AppSelectFormFieldItem<T>> items;
  final String labelText;
  final String dialogHelpText;
  final String helperText;
  final IconData iconData;
  final FormFieldValidator<AppSelectFormFieldItem<T>> validator;
  final FormFieldSetter<AppSelectFormFieldItem<T>> onChanged;
  final FormFieldSetter<AppSelectFormFieldItem<T>> onSaved;
  final T initialValue;

  const AppSelectFormField({
    Key key,
    @required this.items,
    this.labelText,
    this.helperText,
    this.iconData,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.dialogHelpText,
  }) : super(key: key);

  @override
  _AppSelectFormFieldState<T> createState() => _AppSelectFormFieldState<T>();
}

class _AppSelectFormFieldState<T> extends State<AppSelectFormField<T>> {
  AppSelectFormFieldItem<T> selectedItem;

  @override
  Widget build(BuildContext context) {
    selectedItem = _getInitialSelection();

    return AppSelectionScreenFormField<AppSelectFormFieldItem<T>>(
      onTap: onTap,
      itemToStringConverter: (item) => item.text,
      labelText: widget.labelText,
      helperText: widget.helperText,
      iconData: widget.iconData,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      validator: widget.validator,
      initialSelection: selectedItem,
    );
  }

  AppSelectFormFieldItem<T> _getInitialSelection() {
    if (widget.initialValue == null) {
      return null;
    }

    final initialSelection =
        widget.items.firstWhere((e) => e.value == widget.initialValue);
    if (initialSelection == null) {
      throw ArgumentError.value("initialValue",
          "Unable to find initial value in AppSelectFormField items");
    }

    return initialSelection;
  }

  Future<AppSelectFormFieldItem<T>> onTap(BuildContext context) async {
    final item = await showDialog<AppSelectFormFieldItem<T>>(
        context: context,
        builder: (BuildContext context) {
          return AppFormSingleSelectDialog<T>(
            items: widget.items,
            selectedValue: selectedItem?.value,
            title: widget.labelText,
            helpText: widget.dialogHelpText,
          );
        });

    selectedItem = item ?? selectedItem;

    return item;
  }
}

class AppMultipleSelectFormField<T> extends StatefulWidget {
  final List<AppSelectFormFieldItem<T>> items;
  final String labelText;
  final String helperText;
  final IconData iconData;
  final FormFieldSetter<List<AppSelectFormFieldItem<T>>> onChanged;
  final FormFieldSetter<List<AppSelectFormFieldItem<T>>> onSaved;

  const AppMultipleSelectFormField({
    Key key,
    @required this.items,
    this.labelText,
    this.helperText,
    this.iconData,
    this.onChanged,
    this.onSaved,
  }) : super(key: key);

  @override
  _AppMultipleSelectFormFieldState<T> createState() =>
      _AppMultipleSelectFormFieldState<T>();
}

class _AppMultipleSelectFormFieldState<T>
    extends State<AppMultipleSelectFormField<T>> {
  List<AppSelectFormFieldItem<T>> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return AppSelectionScreenFormField<List<AppSelectFormFieldItem<T>>>(
      onTap: onTap,
      itemToStringConverter: (items) => items.map((e) => e.text).join(", "),
      labelText: widget.labelText,
      helperText: widget.helperText,
      iconData: widget.iconData,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
    );
  }

  Future<List<AppSelectFormFieldItem<T>>> onTap(BuildContext context) async {
    final items = await showDialog<List<AppSelectFormFieldItem<T>>>(
        context: context,
        builder: (BuildContext context) {
          return AppFormMultipleSelectDialog<T>(
            title: widget.labelText,
            items: widget.items,
            selectedItems: _selectedItems,
          );
        });

    _selectedItems = items ?? _selectedItems;

    return items;
  }
}

class AppDatePickerFormField extends StatefulWidget {
  final DateTime initialDate;
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;

  final String labelText;
  final String helperText;
  final IconData iconData;
  final FormFieldValidator<DateTime> validator;
  final FormFieldSetter<DateTime> onDateSaved;
  final FormFieldSetter<DateTime> onDateChanged;
  final DateFormat dateFormat;
  final DatePickerEntryMode initialEntryMode;
  final DatePickerMode initialDatePickerMode;

  const AppDatePickerFormField({
    Key key,
    @required this.initialDate,
    @required this.firstDate,
    @required this.lastDate,
    this.selectedDate,
    this.onDateSaved,
    this.onDateChanged,
    this.dateFormat,
    this.labelText,
    this.helperText,
    this.iconData,
    this.validator,
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.initialDatePickerMode = DatePickerMode.day,
  }) : super(key: key);

  @override
  _AppDatePickerFormFieldState createState() => _AppDatePickerFormFieldState();
}

class _AppDatePickerFormFieldState extends State<AppDatePickerFormField> {
  static final DateFormat _defaultDateFormat = DateFormat.yMd();

  // TODO this is a bug with platform translation. Incorrect format is shown. Set to correct one.
  static const _fieldHintText = "yyyy-mm-dd";

  DateTime selectedDateTime;

  @override
  void initState() {
    super.initState();

    selectedDateTime = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return AppSelectionScreenFormField<DateTime>(
      onTap: _onTap,
      itemToStringConverter: (date) {
        return (widget.dateFormat ?? _defaultDateFormat).format(date);
      },
      labelText: widget.labelText,
      helperText: widget.helperText,
      iconData: widget.iconData,
      onSaved: widget.onDateSaved,
      onChanged: widget.onDateChanged,
      initialSelection: selectedDateTime,
      validator: widget.validator,
    );
  }

  Future<DateTime> _onTap(BuildContext context) async {
    final dateTime = await showDatePicker(
      context: context,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      initialDate: widget.initialDate,
      initialDatePickerMode: widget.initialDatePickerMode,
      initialEntryMode: widget.initialEntryMode,
      fieldHintText: _fieldHintText,
    );

    selectedDateTime = dateTime ?? selectedDateTime;

    return dateTime;
  }
}

class AppTimePickerFormField extends StatefulWidget {
  final TimeOfDay initialTime;
  final String labelText;
  final String helperText;
  final IconData iconData;
  final FormFieldSetter<TimeOfDay> onTimeSaved;
  final FormFieldSetter<TimeOfDay> onTimeChanged;

  const AppTimePickerFormField({
    Key key,
    @required this.initialTime,
    this.onTimeSaved,
    this.onTimeChanged,
    this.labelText,
    this.helperText,
    this.iconData,
  }) : super(key: key);

  @override
  _AppTimePickerFormFieldState createState() => _AppTimePickerFormFieldState();
}

class _AppTimePickerFormFieldState extends State<AppTimePickerFormField> {
  static final DateFormat _defaultDateFormat = DateFormat.Hm();

  TimeOfDay _selectedTimeOfDay;

  @override
  Widget build(BuildContext context) {
    _selectedTimeOfDay = widget.initialTime;

    return AppSelectionScreenFormField<TimeOfDay>(
      onTap: _onTap,
      itemToStringConverter: (newlySelectedTimeOfDay) {
        final newDateTime = DateTime.now().applied(newlySelectedTimeOfDay);

        return _defaultDateFormat.format(newDateTime);
      },
      labelText: widget.labelText,
      helperText: widget.helperText,
      iconData: widget.iconData,
      onSaved: widget.onTimeSaved,
      onChanged: widget.onTimeChanged,
      initialSelection: widget.initialTime,
    );
  }

  Future<TimeOfDay> _onTap(BuildContext _) async {
    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: widget.initialTime ?? TimeOfDay.now(),
    );

    _selectedTimeOfDay = timeOfDay ?? _selectedTimeOfDay;

    return timeOfDay;
  }
}

class AppIntegerFormField extends StatelessWidget {
  final String labelText;
  final String helperText;
  final String hintText;
  final IconData iconData;
  final FormFieldValidator<int> validator;
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
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      labelText: labelText,
      helperText: helperText,
      hintText: hintText,
      iconData: iconData,
      validator: _validator,
      onSaved: onSaved != null ? _onSaved : null,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      suffixText: suffixText,
    );
  }

  String _validator(String text) {
    if (validator == null) {
      return null;
    }

    return validator(int.tryParse(text));
  }

  _onSaved(String v) {
    int n = v != null ? int.parse(v) : null;

    this.onSaved(n);
  }
}

class AppDoubleInputField extends StatelessWidget {
  static final floatRegexPattern =
      RegExp(r'^((0|([1-9][0-9]{0,3}))(\.|,)?\d*)$');

  final String labelText;
  final String helperText;
  final String hintText;
  final IconData iconData;
  final FormFieldValidator<double> validator;
  final FormFieldSetter<double> onSaved;
  final String suffixText;

  const AppDoubleInputField({
    Key key,
    @required this.onSaved,
    @required this.labelText,
    this.hintText,
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
      validator: _validator,
      hintText: hintText,
      onSaved: onSaved != null ? _onSaved : null,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(floatRegexPattern)],
      suffixText: suffixText,
    );
  }

  String _validator(String text) {
    if (validator == null) {
      return null;
    }

    return validator(double.tryParse(text));
  }

  _onSaved(String v) {
    final n = v != null ? double.parse(v) : null;

    this.onSaved(n);
  }
}
