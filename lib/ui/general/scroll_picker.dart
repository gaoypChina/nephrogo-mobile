import 'package:flutter/material.dart';

// Code from https://github.com/codegrue/flutter_material_pickers
// Unable to add this library due to additional permission for file picker and
// image catalog permission
/// This helper widget manages the scrollable content inside a picker widget.
class ScrollPicker extends StatefulWidget {
  const ScrollPicker({
    Key? key,
    required this.items,
    this.initialValue,
    required this.onChanged,
    this.showDivider = true,
  }) : super(key: key);

  // Events
  final ValueChanged<String> onChanged;

  // Variables
  final List<String> items;
  final String? initialValue;
  final bool showDivider;

  @override
  _ScrollPickerState createState() =>
      _ScrollPickerState(initialValue); // ignore: no_logic_in_create_state
}

class _ScrollPickerState extends State<ScrollPicker> {
  _ScrollPickerState(this.selectedValue);

  // Constants
  static const double itemHeight = 50.0;

  // Variables
  late double widgetHeight;
  late int numberOfVisibleItems;
  late int numberOfPaddingRows;
  late double visibleItemsHeight;
  late double offset;

  String? selectedValue;

  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    final int initialItem =
        (selectedValue == null) ? 0 : widget.items.indexOf(selectedValue!);
    scrollController = FixedExtentScrollController(initialItem: initialItem);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle? defaultStyle = themeData.textTheme.bodyText2;
    final TextStyle? selectedStyle =
        themeData.textTheme.headline5?.copyWith(color: themeData.accentColor);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        widgetHeight = constraints.maxHeight;

        return Stack(
          children: <Widget>[
            GestureDetector(
              onTapUp: _itemTapped,
              child: ListWheelScrollView.useDelegate(
                childDelegate: ListWheelChildBuilderDelegate(
                    builder: (BuildContext context, int index) {
                  if (index < 0 || index > widget.items.length - 1) {
                    return null;
                  }

                  final value = widget.items[index];

                  final TextStyle? itemStyle =
                      (value == selectedValue) ? selectedStyle : defaultStyle;

                  return Center(
                    child: Text(value, style: itemStyle),
                  );
                }),
                controller: scrollController,
                itemExtent: itemHeight,
                onSelectedItemChanged: _onSelectedItemChanged,
                physics: const FixedExtentScrollPhysics(),
              ),
            ),
            Center(child: widget.showDivider ? const Divider() : Container()),
            Center(
              child: Container(
                height: itemHeight,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: themeData.accentColor),
                    bottom: BorderSide(color: themeData.accentColor),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void _itemTapped(TapUpDetails details) {
    final Offset position = details.localPosition;
    final double center = widgetHeight / 2;
    final double changeBy = position.dy - center;
    final double newPosition = scrollController.offset + changeBy;

    // animate to and center on the selected item
    scrollController.animateTo(newPosition,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void _onSelectedItemChanged(int index) {
    final String newValue = widget.items[index];
    if (newValue != selectedValue) {
      selectedValue = newValue;
      widget.onChanged(newValue);
    }
  }
}
