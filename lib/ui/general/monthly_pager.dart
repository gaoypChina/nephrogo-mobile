import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/utils/date_utils.dart';

class MonthlyPager<T> extends StatefulWidget {
  final Widget Function(BuildContext context, Date from, Date to) bodyBuilder;
  final Date earliestDate;
  final Date initialDate;

  const MonthlyPager({
    Key key,
    @required this.earliestDate,
    @required this.initialDate,
    @required this.bodyBuilder,
  })  : assert(earliestDate != null),
        assert(initialDate != null),
        assert(bodyBuilder != null),
        super(key: key);

  @override
  _MonthlyPagerState<T> createState() => _MonthlyPagerState<T>();
}

class _MonthlyPagerState<T> extends State<MonthlyPager<T>> {
  static const _animationDuration = Duration(milliseconds: 400);

  static final monthFormatter = DateFormat.yMMMM();

  List<Date> _months;

  PageController _pageController;

  ValueNotifier<int> _currentPositionNotifier;

  @override
  void initState() {
    super.initState();

    _months = DateUtils.generateMonthDates(widget.earliestDate, DateTime.now())
        .toList()
        .reversed
        .toList();

    final initialIndex = getInitialIndex();

    _currentPositionNotifier = ValueNotifier(initialIndex);

    _pageController = PageController(
      initialPage: initialIndex,
      viewportFraction: 0.99999,
    );
  }

  int getInitialIndex() {
    return _months
        .indexOf(Date(widget.initialDate.year, widget.initialDate.month, 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Material(
            elevation: 1,
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPositionNotifier,
              builder: (context, index, v) {
                return _buildDateSelectionSection(_months[index]);
              },
            ),
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            reverse: true,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) => _currentPositionNotifier.value = index,
            itemCount: _months.length,
            itemBuilder: (context, index) {
              final from = _months[index];
              final to = DateUtils.getLastDateOfCurrentMonth(from);

              return widget.bodyBuilder(context, from, to);
            },
          ),
        ),
      ],
    );
  }

  bool hasNextDateRange() => _currentPositionNotifier.value != 0;

  bool hasPreviousDateRange() =>
      _currentPositionNotifier.value + 1 < _months.length;

  Future<void> advanceToNextDateRange() {
    return _pageController.previousPage(
        duration: _animationDuration, curve: Curves.ease);
  }

  Future<void> advanceToPreviousDateRange() {
    return _pageController.nextPage(
        duration: _animationDuration, curve: Curves.ease);
  }

  String _getDateRangeFormatted(Date date) {
    return monthFormatter.format(date).capitalizeFirst();
  }

  Widget _buildDateSelectionSection(Date date) {
    return Container(
      color: Theme.of(context).dialogBackgroundColor,
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
                  _getDateRangeFormatted(date),
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
    _currentPositionNotifier.dispose();
    _pageController.dispose();

    super.dispose();
  }
}
