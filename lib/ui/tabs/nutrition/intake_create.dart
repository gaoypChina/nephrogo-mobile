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
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/ui/general/progress_dialog.dart';
import 'package:nephrogo/ui/tabs/nutrition/product_search.dart';
import 'package:nephrogo_api_client/model/intake.dart';
import 'package:nephrogo_api_client/model/intake_request.dart';
import 'package:nephrogo_api_client/model/product.dart';

class IntakeCreateScreenArguments extends Equatable {
  final Product product;
  final Intake intake;

  IntakeCreateScreenArguments({this.product, this.intake})
      : assert(product != null || intake != null, "Pass intake or product");

  @override
  List<Object> get props => [product];
}

class IntakeCreateScreen extends StatefulWidget {
  final Intake intake;
  final Product initialProduct;

  const IntakeCreateScreen({Key key, this.initialProduct, this.intake})
      : super(key: key);

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

  AppLocalizations get _appLocalizations => AppLocalizations.of(context);

  DateTime _consumedAt;

  @override
  void initState() {
    super.initState();

    selectedProduct = widget.intake?.product ?? widget.initialProduct;
    amountG = widget.intake?.amountG;

    _consumedAt =
        widget.intake?.consumedAt?.toLocal() ?? DateTime.now().toLocal();
  }

  Future<Product> _showProductSearch() {
    return Navigator.pushNamed<Product>(
      context,
      Routes.ROUTE_PRODUCT_SEARCH,
      arguments: ProductSearchType.change,
    );
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
              icon: Icon(Icons.delete_forever),
              onPressed: () => deleteIntake(widget.intake.id),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => validateAndSaveIntake(context),
        label: Text(_appLocalizations.save.toUpperCase()),
        icon: Icon(Icons.save),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 64),
          children: <Widget>[
            SmallSection(
              title: _appLocalizations.mealCreationMealSectionTitle,
              showDividers: false,
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
                  initialValue: widget.intake?.amountG,
                  suffixText: "g",
                  validator: formValidators.and(
                    formValidators.nonNull(),
                    formValidators.numRangeValidator(1, 10000),
                  ),
                  iconData: Icons.kitchen,
                  onChanged: (g) {
                    setState(() {
                      amountG = g;
                    });
                  },
                  onSaved: (value) => _intakeBuilder.amountG = value,
                ),
              ],
            ),
            SmallSection(
              title: _appLocalizations.mealCreationDatetimeSectionTitle,
              showDividers: false,
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
                  onTimeChanged: (t) => _consumedAt = _consumedAt.applied(t),
                  onTimeSaved: (t) =>
                      _intakeBuilder.consumedAt = _consumedAt.toUtc(),
                ),
              ],
            ),
            _buildNutrientsSection(),
          ],
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
                child: Text(appLocalizations.dialogCancel.toUpperCase()),
                onPressed: () => Navigator.of(context).pop(false)),
            TextButton(
                child: Text(appLocalizations.delete.toUpperCase()),
                onPressed: () => Navigator.of(context).pop(true)),
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
        return Future.error(e, stackTrace);
      },
    );

    final intake = await ProgressDialog(context).showForFuture(savingFuture);

    Navigator.pop(context, intake);
  }

  Widget _buildNutrientTile(Nutrient nutrient) {
    String amountText = "-";
    if (selectedProduct != null && amountG != null && amountG > 0) {
      amountText = selectedProduct.getFormattedTotalAmount(nutrient, amountG);
    }

    return AppListTile(
      title: Text(nutrient.name(_appLocalizations)),
      trailing: Text(amountText),
      dense: true,
    );
  }

  Widget _buildNutrientsSection() {
    return SmallSection(
      title: _appLocalizations.total,
      children: [
        for (final nutrient in Nutrient.values) _buildNutrientTile(nutrient)
      ],
    );
  }
}
