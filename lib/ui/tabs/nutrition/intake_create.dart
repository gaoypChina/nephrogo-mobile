import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/ui/general/progress_dialog.dart';
import 'package:nephrogo/ui/tabs/nutrition/product_search.dart';
import 'package:nephrogo_api_client/model/daily_nutrient_norms_with_totals.dart';
import 'package:nephrogo_api_client/model/intake.dart';
import 'package:nephrogo_api_client/model/intake_request.dart';
import 'package:nephrogo_api_client/model/meal_type_enum.dart';
import 'package:nephrogo_api_client/model/product.dart';

import 'nutrition_components.dart';

class IntakeCreateScreenArguments extends Equatable {
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;
  final Product product;
  final Intake intake;

  const IntakeCreateScreenArguments({
    @required this.dailyNutrientNormsAndTotals,
    this.product,
    this.intake,
  })  : assert(dailyNutrientNormsAndTotals != null),
        assert(product != null || intake != null, 'Pass intake or product');

  @override
  List<Object> get props => [product, dailyNutrientNormsAndTotals];
}

class IntakeCreateScreen extends StatefulWidget {
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;
  final Intake intake;
  final Product initialProduct;

  const IntakeCreateScreen({
    Key key,
    @required this.dailyNutrientNormsAndTotals,
    this.initialProduct,
    this.intake,
  })  : assert(dailyNutrientNormsAndTotals != null),
        assert(
            initialProduct != null || intake != null, 'Pass intake or product'),
        super(key: key);

  @override
  _IntakeCreateScreenState createState() => _IntakeCreateScreenState();
}

class _IntakeSectionOption {
  Intake fakeIntake;
  FocusNode focusNode;

  _IntakeSectionOption(this.fakeIntake, this.focusNode);
}

class _IntakeCreateScreenState extends State<IntakeCreateScreen> {
  static final _dateFormatDep = DateFormat.yMEd();
  final _dateFormat = DateFormat("EEEE, MMMM d");

  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();
  final _intakeBuilder = IntakeRequestBuilder();

  List<_IntakeSectionOption> _intakeSectionsOptions;

  AppLocalizations get _appLocalizations => AppLocalizations.of(context);

  DateTime _consumedAt;

  @override
  void initState() {
    super.initState();

    _consumedAt = DateTime.now();

    final fakedIntake = widget.initialProduct.fakeIntake(
      consumedAt: _consumedAt,
    );

    _intakeSectionsOptions = [_IntakeSectionOption(fakedIntake, FocusNode())];

    print(
        "_IntakeCreateScreenState initState ${_intakeSectionsOptions.length}");
    for (final options in _intakeSectionsOptions) {
      final intake = options.fakeIntake;
      print("${intake.product.name} ${intake.amountG} ${intake.amountMl}");
    }
  }

  Future<Product> _showProductSearch() async {
    final excludeProductIds =
        _intakeSectionsOptions.map((e) => e.fakeIntake.product.id).toList();

    final product = await Navigator.pushNamed<Product>(
      context,
      Routes.routeProductSearch,
      arguments: ProductSearchScreenArguments(
        ProductSearchType.change,
        excludeProductsIds: excludeProductIds,
      ),
    );

    if (product != null) {
      final fakedIntake = product.fakeIntake(consumedAt: _consumedAt.toLocal());

      final intakeSectionOptions =
          _IntakeSectionOption(fakedIntake, FocusNode());

      setState(() => _intakeSectionsOptions.insert(0, intakeSectionOptions));

      intakeSectionOptions.focusNode.requestFocus();
    }

    return product;
  }

  bool _isAddNewProductButtonActive() {
    return !_intakeSectionsOptions.any((e) => e.fakeIntake.amountG == 0);
  }

  @override
  Widget build(BuildContext context) {
    print("_IntakeCreateScreenState build ${_intakeSectionsOptions.length}");
    for (final options in _intakeSectionsOptions) {
      final intake = options.fakeIntake;
      print("${intake.product.name} ${intake.amountG} ${intake.amountMl}");
    }

    final formValidators = FormValidators(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_dateFormat.format(_consumedAt).capitalizeFirst()),
      ),
      bottomNavigationBar: BasicSection.single(
        AppElevatedButton(
          onPressed: () => validateAndSaveIntake(context),
          text: appLocalizations.save.toUpperCase(),
        ),
        padding: EdgeInsets.zero,
        innerPadding: const EdgeInsets.all(16),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: ListView(
            children: <Widget>[
              BasicSection.single(
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: OutlinedButton.icon(
                      onPressed: _isAddNewProductButtonActive()
                          ? _showProductSearch
                          : null,
                      icon: const Icon(Icons.add_circle),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          "Papildomas valgis".toUpperCase(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              for (final options in _intakeSectionsOptions)
                _IntakeEditSection(
                  key: ObjectKey(options.fakeIntake.product),
                  focusNode: options.focusNode,
                  initialFakedIntake: options.fakeIntake,
                  dailyNutrientNormsAndTotals:
                      widget.dailyNutrientNormsAndTotals,
                  onChanged: _onIntakeChanged,
                  onDelete: _onIntakeDeleted,
                ),
              SmallSection(
                title: _appLocalizations.mealCreationDatetimeSectionTitle,
                children: [
                  AppDatePickerFormField(
                    initialDate: _consumedAt,
                    selectedDate: _consumedAt,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                    validator: formValidators.nonNull(),
                    dateFormat: _dateFormatDep,
                    iconData: Icons.calendar_today,
                    onDateChanged: (dt) {
                      final ldt = dt.toLocal();
                      _consumedAt = DateTime(
                        ldt.year,
                        ldt.month,
                        ldt.day,
                        _consumedAt.hour,
                        _consumedAt.minute,
                      );
                    },
                    onDateSaved: (dt) =>
                        _intakeBuilder.consumedAt = dt.toLocal(),
                    labelText: _appLocalizations.mealCreationDate,
                  ),
                  AppTimePickerFormField(
                    labelText: _appLocalizations.mealCreationTime,
                    iconData: Icons.access_time,
                    initialTime: TimeOfDay(
                      hour: _consumedAt.hour,
                      minute: _consumedAt.minute,
                    ),
                    onTimeChanged: (t) => _consumedAt = _consumedAt.applied(t),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getIntakeIndex(Intake fakedIntake) {
    final index = _intakeSectionsOptions.indexWhere(
      (options) => options.fakeIntake.product.id == fakedIntake.product.id,
    );

    assert(index != -1, "Unable to find intake between intakes for creation");

    return index;
  }

  void _onIntakeChanged(Intake fakedIntake) {
    final index = _getIntakeIndex(fakedIntake);

    setState(() {
      _intakeSectionsOptions[index].fakeIntake = fakedIntake;
    });
  }

  void _onIntakeDeleted(Intake fakedIntake) {
    final index = _getIntakeIndex(fakedIntake);

    setState(() {
      _intakeSectionsOptions.removeAt(index);
    });
  }

  Iterable<IntakeRequest> _prepareIntakeRequests() sync* {
    for (final options in _intakeSectionsOptions) {
      final fakedIntake = options.fakeIntake;

      final builder = IntakeRequestBuilder();
      builder.amountG = fakedIntake.amountG;
      builder.amountMl = fakedIntake.amountMl;
      builder.productId = fakedIntake.product.id;
      builder.consumedAt = _consumedAt.toUtc();
      builder.mealType = MealTypeEnum.unknown;

      yield builder.build();
    }
  }

  Future<List<Intake>> saveIntakes() async {
    final List<Intake> intakes = [];

    for (final request in _prepareIntakeRequests()) {
      final intake = await saveIntake(request);
      intakes.add(intake);
    }

    return intakes;
  }

  Future<Intake> saveIntake(IntakeRequest intakeRequest) {
    return _apiService.createIntake(intakeRequest);
  }

  Future validateAndSaveIntake(BuildContext context) async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState.validate()) {
      await showAppDialog(
        context: context,
        title: _appLocalizations.error,
        message: _appLocalizations.formErrorDescription,
      );

      return false;
    }
    _formKey.currentState.save();

    final savingFuture = saveIntakes().catchError(
      (e, stackTrace) async {
        await showAppDialog(
          context: context,
          title: _appLocalizations.error,
          message: _appLocalizations.serverErrorDescription,
        );
      },
    );

    final intakes = await ProgressDialog(context).showForFuture(savingFuture);

    if (intakes != null) {
      Navigator.pop(context);
    }
  }
}

class _IntakeEditSection extends StatefulWidget {
  final FocusNode focusNode;
  final Intake initialFakedIntake;
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;
  final void Function(Intake fakedIntaked) onChanged;
  final void Function(Intake fakedIntaked) onDelete;

  const _IntakeEditSection({
    Key key,
    @required this.initialFakedIntake,
    @required this.dailyNutrientNormsAndTotals,
    @required this.onChanged,
    @required this.onDelete,
    @required this.focusNode,
  })  : assert(initialFakedIntake != null),
        assert(dailyNutrientNormsAndTotals != null),
        assert(onChanged != null),
        assert(onDelete != null),
        super(key: key);

  @override
  _IntakeEditSectionState createState() => _IntakeEditSectionState();
}

class _IntakeEditSectionState extends State<_IntakeEditSection> {
  Intake intake;

  bool get isAmountInMilliliters => intake.product.densityGMl != null;

  DateTime get _consumedAt => intake.consumedAt;

  Product get _product => intake.product;

  @override
  void initState() {
    super.initState();

    intake = widget.initialFakedIntake;

    print(
        "_IntakeEditSectionState initState ${intake.product.name} ${intake.amountG} ${intake.amountMl}");
  }

  @override
  Widget build(BuildContext context) {
    final formValidators = FormValidators(context);

    final amount = isAmountInMilliliters ? intake.amountMl : intake.amountG;

    print(
        "_IntakeEditSectionState build ${intake.product.name} ${intake.amountMl} ${intake.amountG}");

    return SmallSection(
      title: _product.name,
      trailing: IconButton(
        icon: Icon(
          Icons.delete_outline,
          semanticLabel: appLocalizations.delete,
        ),
        onPressed: () => widget.onDelete(intake),
      ),
      children: [
        AppIntegerFormField(
          focusNode: widget.focusNode,
          labelText: appLocalizations.mealCreationQuantity,
          initialValue: amount != 0 ? amount : null,
          suffixText: isAmountInMilliliters ? 'ml' : 'g',
          autoFocus: intake.amountG == 0,
          validator: formValidators.and(
            formValidators.nonNull(),
            formValidators.numRangeValidator(1, 10000),
          ),
          iconData: Icons.kitchen,
          onChanged: _onChanged,
          onSaved: (_) {
            print("OnSavedIntake");
          },
        ),
        IntakeExpandableTile(
          intake,
          widget.dailyNutrientNormsAndTotals,
        ),
      ],
    );
  }

  void _onChanged(int amount) {
    int amountG;
    int amountMl;

    if (amount != null && isAmountInMilliliters) {
      amountMl = amount;
      amountG = (amount * _product.densityGMl).round();
    } else {
      amountG = amount ?? 0;
      amountMl = null;
    }

    setState(() {
      intake = _product.fakeIntake(
        consumedAt: _consumedAt,
        amountG: amountG,
        amountMl: amountMl,
      );
    });

    widget.onChanged(intake);
  }
}
