import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
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
import 'package:nephrogo_api_client/model/product.dart';
import 'package:nephrogo_api_client/model/product_kind_enum.dart';

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

class _IntakeCreateScreenState extends State<IntakeCreateScreen> {
  static final _dateFormat = DateFormat.yMEd();

  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();
  final _intakeBuilder = IntakeRequestBuilder();

  Product selectedProduct;
  int amountG;
  int amountMl;

  AppLocalizations get _appLocalizations => AppLocalizations.of(context);

  bool get _isDrinkSelected =>
      selectedProduct.productKind == ProductKindEnum.drink;

  DateTime _consumedAt;

  @override
  void initState() {
    super.initState();

    selectedProduct = widget.intake?.product ?? widget.initialProduct;
    amountG = widget.intake?.amountG;
    amountMl = widget.intake?.amountMl;

    _consumedAt =
        widget.intake?.consumedAt?.toLocal() ?? DateTime.now().toLocal();
  }

  Future<Product> _showProductSearch() {
    return Navigator.pushNamed<Product>(
      context,
      Routes.routeProductSearch,
      arguments: ProductSearchType.change,
    );
  }

  bool isAmountInMilliliters() {
    // For backward capability
    if (widget.intake != null &&
        widget.intake.product.id == selectedProduct.id &&
        selectedProduct.densityGMl != null) {
      return widget.intake.amountMl != null;
    }

    return selectedProduct.densityGMl != null;
  }

  @override
  Widget build(BuildContext context) {
    final formValidators = FormValidators(context);
    final title = widget.intake == null
        ? _appLocalizations.mealCreationTitle
        : _appLocalizations.mealUpdateTitle;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          if (widget.intake != null)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              tooltip: _appLocalizations.delete,
              onPressed: () => deleteIntake(widget.intake.id),
            ),
        ],
      ),
      bottomNavigationBar: BasicSection.single(
        AppElevatedButton(
          onPressed: () => validateAndSaveIntake(context),
          text: appLocalizations.save.toUpperCase(),
        ),
        padding: EdgeInsets.zero,
        innerPadding: const EdgeInsets.all(8),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SmallSection(
                  title: _appLocalizations.mealCreationMealSectionTitle,
                  children: [
                    AppSelectionScreenFormField<Product>(
                      labelText: _appLocalizations.mealCreationProduct,
                      initialSelection: selectedProduct,
                      iconData: Icons.restaurant_outlined,
                      itemToStringConverter: (p) => p.name,
                      onTap: (context) => _showProductSearch(),
                      validator: formValidators.nonNull(),
                      onChanged: (p) {
                        setState(() {
                          selectedProduct = p;
                        });
                      },
                      onSaved: (p) => _intakeBuilder.productId = p.id,
                    ),
                    AppIntegerFormField(
                      labelText: _appLocalizations.mealCreationQuantity,
                      initialValue: isAmountInMilliliters()
                          ? widget.intake?.amountMl
                          : widget.intake?.amountG,
                      suffixText: isAmountInMilliliters() ? 'ml' : 'g',
                      validator: formValidators.and(
                        formValidators.nonNull(),
                        formValidators.numRangeValidator(1, 10000),
                      ),
                      iconData: Icons.kitchen,
                      onChanged: (v) {
                        setState(() {
                          if (v != null && isAmountInMilliliters()) {
                            amountMl = v;
                            amountG = (v * selectedProduct.densityGMl).round();
                          } else {
                            amountG = v;
                            amountMl = null;
                          }
                        });
                      },
                      onSaved: (_) {
                        _intakeBuilder.amountG = amountG;
                        _intakeBuilder.amountMl = amountMl;
                      },
                    ),
                  ],
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
                      dateFormat: _dateFormat,
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
                          _intakeBuilder.consumedAt = _consumedAt.toUtc(),
                      labelText: _appLocalizations.mealCreationDate,
                    ),
                    AppTimePickerFormField(
                      labelText: _appLocalizations.mealCreationTime,
                      iconData: Icons.access_time,
                      initialTime: TimeOfDay(
                        hour: _consumedAt.hour,
                        minute: _consumedAt.minute,
                      ),
                      onTimeChanged: (t) =>
                          _consumedAt = _consumedAt.applied(t),
                      onTimeSaved: (t) =>
                          _intakeBuilder.consumedAt = _consumedAt.toUtc(),
                    ),
                  ],
                ),
                _buildNutrientsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future deleteIntake(int id) async {
    final appLocalizations = AppLocalizations.of(context);

    final delete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(appLocalizations.delete),
          content: Text(appLocalizations.deleteConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(appLocalizations.dialogCancel.toUpperCase()),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(appLocalizations.delete.toUpperCase()),
            ),
          ],
        );
      },
    );

    if (delete) {
      final deletingFuture = _apiService.deleteIntake(id);
      await ProgressDialog(context).showForFuture(deletingFuture);
      Navigator.pop(context);
    }
  }

  Future<Intake> saveIntake(int id, IntakeRequest intakeRequest) {
    if (id != null) {
      return _apiService.updateIntake(id, intakeRequest);
    } else {
      return _apiService.createIntake(intakeRequest);
    }
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

    final savingFuture =
        saveIntake(widget.intake?.id, _intakeBuilder.build()).catchError(
      (e, stackTrace) async {
        await showAppDialog(
          context: context,
          title: _appLocalizations.error,
          message: _appLocalizations.serverErrorDescription,
        );
      },
    );

    final intake = await ProgressDialog(context).showForFuture(savingFuture);

    if (intake != null) {
      Navigator.pop(context, intake);
    }
  }

  Widget _buildNutrientsSection() {
    var intake = widget.intake;

    if (amountG != null) {
      intake = selectedProduct.fakeIntake(
        amountG: amountG,
        amountMl: amountMl,
        consumedAt: _consumedAt,
      );
    }

    return SmallSection(
      showDividers: true,
      title: _isDrinkSelected
          ? _appLocalizations.totalInThisDrink
          : _appLocalizations.totalInThisMeal,
      children: [
        for (final nutrient in Nutrient.values)
          IntakeNutrientTile(
            intake,
            nutrient,
            widget.dailyNutrientNormsAndTotals,
          )
      ],
    );
  }
}
