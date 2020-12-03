import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/DateExtensions.dart';

import 'app_form_select_screen.dart';

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
  final suffixIconData;

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
        onTap: onTap,
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
    );
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
  final String helperText;
  final IconData iconData;
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
    final item = await Navigator.push(
      context,
      MaterialPageRoute<AppSelectFormFieldItem<T>>(
        builder: (BuildContext context) {
          return AppFromSelectScreen<T>(
            data: AppFromSelectScreenData<T>(
              title: widget.labelText,
              items: widget.items,
              selectedValue: selectedItem?.value,
            ),
          );
        },
      ),
    );

    selectedItem = item ?? selectedItem;

    return item;
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
  final FormFieldValidator<String> validator;
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
  Widget build(BuildContext context) {
    selectedDateTime = widget.selectedDate;

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
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      labelText: labelText,
      helperText: helperText,
      hintText: hintText,
      iconData: iconData,
      validator: validator,
      onSaved: onSaved != null ? _onSaved : null,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      suffixText: suffixText,
    );
  }

  _onSaved(String v) {
    int n = v != null ? int.parse(v) : null;

    this.onSaved(n);
  }
}

class AppFloatInputField extends StatelessWidget {
  final String labelText;
  final String helperText;
  final String hintText;
  final IconData iconData;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<double> onSaved;
  final String suffixText;

  const AppFloatInputField({
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
      validator: validator,
      hintText: hintText,
      onSaved: onSaved != null ? _onSaved : null,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'(\d+\.?\d*)|(\.\d+)'))
      ],
      suffixText: suffixText,
    );
  }

  _onSaved(String v) {
    final n = v != null ? double.parse(v) : null;

    this.onSaved(n);
  }
}
