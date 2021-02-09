import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/date_extensions.dart';
import 'package:nephrogo/extensions/string_extensions.dart';

class WeeklyPager<T> extends StatefulWidget {
  final ValueNotifier<T> valueChangeNotifier;
  final Widget Function(DateTime from, DateTime to, T value) bodyBuilder;
  final DateTime Function() earliestDate;

  const WeeklyPager({
    Key key,
    @required this.valueChangeNotifier,
    @required this.bodyBuilder,
    @required this.earliestDate,
  }) : super(key: key);

  @override
  _WeeklyPagerState<T> createState() => _WeeklyPagerState<T>();
}

class _WeeklyPagerState<T> extends State<WeeklyPager<T>> {
  static const _animationDuration = Duration(milliseconds: 400);
  static final dateFormatter = DateFormat.MMMMd();

  final _pageController = PageController();

  final DateTime now = DateTime.now();

  DateTime initialWeekStart;
  DateTime initialWeekEnd;

  DateTime currentWeekStart;
  DateTime currentWeekEnd;
  T value;

  @override
  void initState() {
    super.initState();

    value = widget.valueChangeNotifier.value;

    final weekStartEnd = now.startAndEndOfWeek();

    currentWeekStart = initialWeekStart = weekStartEnd.item1;
    currentWeekEnd = initialWeekEnd = weekStartEnd.item2;

    widget.valueChangeNotifier.addListener(onIndicatorChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Material(
            elevation: 1,
            child: _buildDateSelectionSection(),
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: changeWeek,
            reverse: true,
            itemBuilder: (context, index) {
              final from = calculateWeekStart(index);
              final to = calculateWeekEnd(index);
              return widget.bodyBuilder(from, to, value);
            },
          ),
        ),
      ],
    );
  }

  void onIndicatorChanged() {
    setState(() {
      value = widget.valueChangeNotifier.value;
    });
  }

  void changeWeek(int index) {
    setState(() {
      currentWeekStart = calculateWeekStart(index);
      currentWeekEnd = calculateWeekEnd(index);
    });
  }

  DateTime calculateWeekStart(int n) {
    final changeDuration = Duration(days: 7 * n);

    return initialWeekStart.subtract(changeDuration);
  }

  DateTime calculateWeekEnd(int n) {
    final changeDuration = Duration(days: 7 * n);

    return initialWeekEnd.subtract(changeDuration);
  }

  bool hasNextDateRange() => currentWeekEnd.isBefore(now);

  bool hasPreviousDateRange() {
    final earliestDate = widget.earliestDate();

    if (earliestDate == null) {
      return true;
    }

    return !earliestDate.add(const Duration(days: 7)).isAfter(currentWeekEnd);
  }

  void advanceToNextDateRange() {
    _pageController.previousPage(
        duration: _animationDuration, curve: Curves.ease);
  }

  void advanceToPreviousDateRange() {
    _pageController.nextPage(duration: _animationDuration, curve: Curves.ease);
  }

  String _getDateRangeFormatted() {
    return '${dateFormatter.format(currentWeekStart).capitalizeFirst()} – '
        '${dateFormatter.format(currentWeekEnd).capitalizeFirst()}';
  }

  Widget _buildDateSelectionSection() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed:
                  hasPreviousDateRange() ? advanceToPreviousDateRange : null,
            ),
            Expanded(
              child: Center(
                child: Text(
                  _getDateRangeFormatted(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              onPressed: hasNextDateRange() ? advanceToNextDateRange : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    widget.valueChangeNotifier.removeListener(onIndicatorChanged);

    super.dispose();
  }
}
