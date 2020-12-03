import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/DateExtensions.dart';

import 'forms/app_form_select_screen.dart';

class AppDropdownMenuItem<T> {
  final Key key;
  final String text;
  final T value;

  AppDropdownMenuItem({this.key, @required this.text, @required this.value});
}

const _defaultFieldPadding = const EdgeInsets.all(8.0);

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
    this.onChanged,
    this.initialValue,
    this.onSaved,
  }) : super(key: key);

  @override
  _AppSelectFormFieldState createState() => _AppSelectFormFieldState<T>();
}

class _AppSelectFormFieldState<T> extends State<AppSelectFormField<T>> {
  TextEditingController _textEditingController = TextEditingController();
  AppSelectFormFieldItem _selectedItem;

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null) {
      _selectedItem =
          widget.items.firstWhere((e) => e.value == widget.initialValue);

      if (_selectedItem == null) {
        throw ArgumentError.value("initialValue",
            "Unable to find initial value in AppSelectFormField items");
      }
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
      onTap: () => onTap(context),
      suffixIconData: Icons.chevron_right,
      onSaved: _onSaved,
    );
  }

  _onSaved(String s) {
    if (widget.onSaved != null) {
      widget.onSaved(_selectedItem);
    }
  }

  Future<void> onTap(BuildContext context) async {
    AppSelectFormFieldItem<T> item = await Navigator.push(
      context,
      MaterialPageRoute<AppSelectFormFieldItem<T>>(
        builder: (BuildContext context) {
          return AppFromSelectScreen<T>(
            data: AppFromSelectScreenData<T>(
              title: widget.labelText,
              items: widget.items,
              selectedValue: _selectedItem?.value,
            ),
          );
        },
      ),
    );

    if (item != null) {
      _textEditingController.text = item.text;
      _selectedItem = item;

      if (widget.onChanged != null) {
        widget.onChanged(item);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();

    _textEditingController.dispose();
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
  final suffixIconData;

  const AppTextFormField({
    Key key,
    @required this.labelText,
    this.onSaved,
    this.helperText,
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

class AppSelectionFormField<T> extends StatelessWidget {
  final String labelText;
  final String helperText;
  final IconData iconData;
  final FormFieldValidator<String> validator;
  final autoFocus;

  final FormFieldSetter<String> onSaved;
  final String initialText;
  final GestureTapCallback onTap;
  final TextEditingController textEditingController;
  final IconData suffixIcon;

  const AppSelectionFormField({
    Key key,
    @required this.onTap,
    @required this.textEditingController,
    this.labelText,
    this.helperText,
    this.iconData,
    this.validator,
    this.initialText,
    this.onSaved,
    this.suffixIcon,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      labelText: labelText,
      controller: textEditingController,
      helperText: helperText,
      iconData: iconData,
      validator: validator,
      disabled: true,
      autoFocus: autoFocus,
      onTap: onTap,
      suffixIconData: suffixIcon,
    );
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
  final FormFieldSetter<DateTime> onDateSaved;
  final DateFormat dateFormat;
  final bool showInitialValue;
  final DatePickerEntryMode initialEntryMode;
  final DatePickerMode initialDatePickerMode;
  final IconData suffixIcon;

  const AppDatePickerFormField({
    Key key,
    @required this.initialDate,
    @required this.firstDate,
    @required this.lastDate,
    @required this.onDateSaved,
    this.dateFormat,
    this.labelText,
    this.helperText,
    this.iconData,
    this.validator,
    this.suffixIcon,
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.initialDatePickerMode = DatePickerMode.day,
    this.showInitialValue = false,
  }) : super(key: key);

  @override
  _AppDatePickerFormFieldState createState() => _AppDatePickerFormFieldState();
}

class _AppDatePickerFormFieldState extends State<AppDatePickerFormField> {
  static final DateFormat _defaultDateFormat = DateFormat.yMd();

  // TODO this is a bug with platform translation. Incorrect format is shown. Set to correct one.
  static const _fieldHintText = "yyyy-mm-dd";

  DateFormat _dateFormat;
  TextEditingController _textEditingController = TextEditingController();

  DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();

    _dateFormat = widget.dateFormat ?? _defaultDateFormat;

    if (widget.showInitialValue) {
      _setNewDateTime(widget.initialDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppSelectionFormField(
      onTap: _onTap,
      textEditingController: _textEditingController,
      labelText: widget.labelText,
      helperText: widget.helperText,
      iconData: widget.iconData,
      validator: widget.validator,
      suffixIcon: widget.suffixIcon,
      onSaved: _onSaved,
    );
  }

  _onSaved(String s) {
    widget.onDateSaved(_selectedDateTime);
  }

  _onTap() async {
    final dateTime = await showDatePicker(
      context: context,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      initialDate: widget.initialDate,
      initialDatePickerMode: widget.initialDatePickerMode,
      initialEntryMode: widget.initialEntryMode,
      fieldHintText: _fieldHintText,
    );

    _setNewDateTime(dateTime);
  }

  _setNewDateTime(DateTime newlySelectedDateTime) {
    if (newlySelectedDateTime != null) {
      _selectedDateTime = newlySelectedDateTime;
      _textEditingController.text = _dateFormat.format(newlySelectedDateTime);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _textEditingController.dispose();
  }
}

class AppTimePickerFormField extends StatefulWidget {
  final TimeOfDay initialTime;

  final String labelText;
  final String helperText;
  final IconData iconData;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<TimeOfDay> onTimeSaved;
  final bool showInitialValue;
  final IconData suffixIcon;

  const AppTimePickerFormField({
    Key key,
    @required this.initialTime,
    @required this.onTimeSaved,
    this.labelText,
    this.helperText,
    this.iconData,
    this.validator,
    this.suffixIcon,
    this.showInitialValue = false,
  }) : super(key: key);

  @override
  _AppTimePickerFormFieldState createState() => _AppTimePickerFormFieldState();
}

class _AppTimePickerFormFieldState extends State<AppTimePickerFormField> {
  static final DateFormat _defaultDateFormat = DateFormat.Hm();

  TextEditingController _textEditingController = TextEditingController();

  TimeOfDay _selectedTimeOfDay;

  @override
  void initState() {
    super.initState();

    if (widget.showInitialValue) {
      _setNewTimeOfDay(widget.initialTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppSelectionFormField(
      onTap: _onTap,
      textEditingController: _textEditingController,
      labelText: widget.labelText,
      helperText: widget.helperText,
      iconData: widget.iconData,
      validator: widget.validator,
      suffixIcon: widget.suffixIcon,
      onSaved: _onSaved,
    );
  }

  _onSaved(String s) {
    widget.onTimeSaved(_selectedTimeOfDay);
  }

  _onTap() async {
    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: widget.initialTime,
    );

    _setNewTimeOfDay(timeOfDay);
  }

  _setNewTimeOfDay(TimeOfDay newlySelectedTimeOfDay) {
    if (newlySelectedTimeOfDay != null) {
      _selectedTimeOfDay = newlySelectedTimeOfDay;
      _textEditingController.text = _defaultDateFormat
          .format(DateTime.now().applied(newlySelectedTimeOfDay));
    }
  }

  @override
  void dispose() {
    super.dispose();

    _textEditingController.dispose();
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
    int n = v != null ? int.parse(v) : null;

    this.onSaved(n);
  }
}
