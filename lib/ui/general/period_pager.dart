import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/utils/date_utils.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

typedef PagerBodyBuilder = Widget Function(
  BuildContext context,
  Widget header,
  Date from,
  Date to,
);

typedef OnPageChanged = void Function(
  Date from,
  Date to,
);

enum PeriodPagerType {
  daily,
  weekly,
  monthly,
}

class PeriodPager extends StatelessWidget {
  final PeriodPagerType pagerType;

  final Date earliestDate;
  final Date initialDate;

  final PagerBodyBuilder bodyBuilder;

  const PeriodPager({
    Key? key,
    required this.pagerType,
    required this.earliestDate,
    required this.initialDate,
    required this.bodyBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (pagerType) {
      case PeriodPagerType.daily:
        return DailyPager(
          earliestDate: earliestDate,
          initialDate: initialDate,
          bodyBuilder: bodyBuilder,
        );
      case PeriodPagerType.weekly:
        return WeeklyPager(
          earliestDate: earliestDate,
          initialDate: initialDate,
          bodyBuilder: bodyBuilder,
        );
      case PeriodPagerType.monthly:
        return MonthlyPager(
          earliestDate: earliestDate,
          initialDate: initialDate,
          bodyBuilder: bodyBuilder,
        );
    }
  }
}

class DailyPager extends StatelessWidget {
  final _dayFormatter = DateFormat('EEEE, MMMM d');

  final OnPageChanged? onPageChanged;

  final Date earliestDate;
  final Date initialDate;

  final PagerBodyBuilder bodyBuilder;

  DailyPager({
    Key? key,
    required this.earliestDate,
    required this.initialDate,
    required this.bodyBuilder,
    this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().toDate();
    final dates = DateHelper.generateDates(earliestDate, today).toList();

    final initialFromDateIndex = dates.indexOf(initialDate);
    assert(initialFromDateIndex != -1);

    return _PeriodPager(
      bodyBuilder: bodyBuilder,
      headerTextBuilder: _buildHeaderText,
      allFromDates: dates,
      initialFromDate: dates[initialFromDateIndex],
      dateFromToDateTo: _dateFromToDateTo,
      onPageChanged: onPageChanged,
    );
  }

  Date _dateFromToDateTo(Date from) => from;

  Widget _buildHeaderText(BuildContext context, Date from, Date to) {
    return Text(_dayFormatter.formatDate(from).capitalizeFirst());
  }
}

class WeeklyPager extends StatelessWidget {
  final dateFormatter = DateFormat.MMMMd();
  final _monthFormatter = DateFormat('MMMM ');

  final Date earliestDate;
  final Date initialDate;

  final PagerBodyBuilder bodyBuilder;

  WeeklyPager({
    Key? key,
    required this.earliestDate,
    required this.initialDate,
    required this.bodyBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().toDate();
    final dates = DateHelper.generateWeekDates(earliestDate, today).toList();

    final initialFromDateIndex = dates.indexOf(initialDate.firstDayOfWeek());
    assert(initialFromDateIndex != -1);

    return _PeriodPager(
      bodyBuilder: bodyBuilder,
      headerTextBuilder: _buildHeaderText,
      allFromDates: dates,
      initialFromDate: dates[initialFromDateIndex],
      dateFromToDateTo: _dateFromToDateTo,
    );
  }

  Date _dateFromToDateTo(Date from) {
    return from.lastDayOfWeek();
  }

  Widget _buildHeaderText(BuildContext context, Date from, Date to) {
    if (from.month == to.month) {
      final formattedFrom = _monthFormatter.formatDate(from).capitalizeFirst();
      return Text('$formattedFrom${from.day} – ${to.day}');
    }

    return Text(
      '${dateFormatter.formatDate(from).capitalizeFirst()} – '
      '${dateFormatter.formatDate(to).capitalizeFirst()}',
    );
  }
}

class MonthlyPager extends StatelessWidget {
  final monthFormatter = DateFormat.yMMMM();

  final Date earliestDate;
  final Date initialDate;

  final PagerBodyBuilder bodyBuilder;

  MonthlyPager({
    Key? key,
    required this.earliestDate,
    required this.initialDate,
    required this.bodyBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().toDate();
    final dates = DateHelper.generateMonthDates(earliestDate, today).toList();

    final initialFromDateIndex =
        dates.indexOf(Date(initialDate.year, initialDate.month, 1));

    assert(initialFromDateIndex != -1);

    return _PeriodPager(
      bodyBuilder: bodyBuilder,
      headerTextBuilder: _buildHeaderText,
      allFromDates: dates,
      initialFromDate: dates[initialFromDateIndex],
      dateFromToDateTo: _dateFromToDateTo,
    );
  }

  Date _dateFromToDateTo(Date from) {
    return DateHelper.getLastDayOfCurrentMonth(from);
  }

  Widget _buildHeaderText(BuildContext context, Date from, Date to) {
    return Text(monthFormatter.formatDate(from).capitalizeFirst());
  }
}

class _PeriodPager extends StatefulWidget {
  final List<Date> allFromDates;
  final Date initialFromDate;

  final Date Function(Date from) dateFromToDateTo;

  final OnPageChanged? onPageChanged;
  final PagerBodyBuilder bodyBuilder;
  final Widget Function(
    BuildContext context,
    Date from,
    Date to,
  ) headerTextBuilder;

  const _PeriodPager({
    Key? key,
    required this.allFromDates,
    required this.initialFromDate,
    required this.bodyBuilder,
    required this.headerTextBuilder,
    required this.dateFromToDateTo,
    this.onPageChanged,
  }) : super(key: key);

  @override
  _PeriodPagerState createState() => _PeriodPagerState();
}

class _PeriodPagerState extends State<_PeriodPager> {
  static const _animationDuration = Duration(milliseconds: 400);

  late List<Date> _dates;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _dates = widget.allFromDates.orderBy((e) => e, reverse: true).toList();

    final initialIndex = _dates.indexOf(widget.initialFromDate);
    assert(initialIndex != -1);

    _pageController = PageController(
      initialPage: initialIndex,
      viewportFraction: 0.99999,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      reverse: true,
      itemCount: _dates.length,
      onPageChanged: widget.onPageChanged != null
          ? (index) {
              final from = _dates[index];
              final to = widget.dateFromToDateTo(from);

              widget.onPageChanged!(from, to);
            }
          : null,
      itemBuilder: (context, index) {
        final from = _dates[index];
        final to = widget.dateFromToDateTo(from);

        final header = _buildDateSelectionSection(index, from, to);

        return widget.bodyBuilder(context, header, from, to);
      },
    );
  }

  bool hasNextDateRange(int index) => index > 0;

  bool hasPreviousDateRange(int index) => index + 1 < _dates.length;

  Future<void> advanceToNextDateRange() {
    return _pageController.previousPage(
      duration: _animationDuration,
      curve: Curves.ease,
    );
  }

  Future<void> advanceToPreviousDateRange() {
    return _pageController.nextPage(
      duration: _animationDuration,
      curve: Curves.ease,
    );
  }

  Widget _buildDateSelectionSection(int index, Date from, Date to) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 32,
          icon: const Icon(
            Icons.navigate_before,
          ),
          onPressed:
              hasPreviousDateRange(index) ? advanceToPreviousDateRange : null,
        ),
        Expanded(
          child: DefaultTextStyle.merge(
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
            child: widget.headerTextBuilder(context, from, to),
          ),
        ),
        IconButton(
          iconSize: 32,
          icon: const Icon(Icons.navigate_next),
          onPressed: hasNextDateRange(index) ? advanceToNextDateRange : null,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }
}
