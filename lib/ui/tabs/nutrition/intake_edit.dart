import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/app_form.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_components.dart';
import 'package:nephrogo/utils/form_utils.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class IntakeEditScreenArguments extends Equatable {
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;
  final Intake intake;

  const IntakeEditScreenArguments(
    this.intake,
    this.dailyNutrientNormsAndTotals,
  );

  @override
  List<Object> get props => [intake, dailyNutrientNormsAndTotals];
}

class IntakeEditScreen extends StatefulWidget {
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;
  final Intake intake;

  const IntakeEditScreen({
    super.key,
    required this.dailyNutrientNormsAndTotals,
    required this.intake,
  });

  @override
  _IntakeEditScreenState createState() => _IntakeEditScreenState();
}

class _IntakeEditScreenState extends State<IntakeEditScreen> {
  final _dateFormat = DateFormat.yMEd();

  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();
  final _intakeBuilder = IntakeRequestBuilder();

  late int amountG;
  late int? amountMl;

  late MealTypeEnum mealType;

  late DateTime _consumedAt;

  Product get product => widget.intake.product;

  bool get isAmountInMilliliters => product.densityGMl != null;

  @override
  void initState() {
    super.initState();

    mealType = widget.intake.mealType ?? MealTypeEnum.unknown;
    amountG = widget.intake.amountG;
    amountMl = widget.intake.amountMl;

    _intakeBuilder.productId = product.id;

    _consumedAt = widget.intake.consumedAt.toLocal();
  }

  @override
  Widget build(BuildContext context) {
    final title = product.name;

    final fakedIntake = product.fakeIntake(
      consumedAt: _consumedAt,
      amountG: amountG,
      amountMl: amountMl,
      mealType: mealType,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: _validateAndSaveIntake,
            child: Text(appLocalizations.update.toUpperCase()),
          ),
        ],
      ),
      body: AppForm(
        formKey: _formKey,
        save: _validateAndSaveIntake,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SmallSection(
                  title: product.name,
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      semanticLabel: appLocalizations.delete,
                    ),
                    onPressed: () => deleteIntake(widget.intake.id),
                  ),
                  children: [
                    AppIntegerFormField(
                      labelText: appLocalizations.mealCreationQuantity,
                      initialValue: isAmountInMilliliters
                          ? widget.intake.amountMl
                          : widget.intake.amountG,
                      suffixText: isAmountInMilliliters ? 'ml' : 'g',
                      validator: formValidators.and(
                        formValidators.nonNull(),
                        formValidators.numRangeValidator(1, 10000),
                      ),
                      icon: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: const Icon(
                          Icons.kitchen,
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (v) {
                        final amount = v ?? 0;
                        setState(() {
                          if (v != null && isAmountInMilliliters) {
                            amountMl = amount;
                            amountG = (amount * product.densityGMl!).round();
                          } else {
                            amountG = amount;
                            amountMl = null;
                          }
                        });
                      },
                      onSaved: (_) {
                        _intakeBuilder.amountG = amountG;
                        _intakeBuilder.amountMl = amountMl;
                      },
                    ),
                    IntakeExpandableTile(
                      fakedIntake,
                      widget.dailyNutrientNormsAndTotals,
                      initiallyExpanded: true,
                      allowLongClick: false,
                    ),
                  ],
                ),
                BasicSection(
                  children: [
                    AppDatePickerFormField(
                      initialDate: _consumedAt.toDate(),
                      selectedDate: _consumedAt.toDate(),
                      firstDate: Constants.earliestDate,
                      lastDate: DateTime.now().toDate(),
                      validator: formValidators.nonNull(),
                      dateFormat: _dateFormat,
                      prefixIcon: const Icon(Icons.calendar_today),
                      onDateChanged: (date) {
                        _consumedAt = _consumedAt.appliedDate(date);
                      },
                      onDateSaved: (dt) =>
                          _intakeBuilder.consumedAt = _consumedAt.toUtc(),
                      labelText: appLocalizations.date,
                    ),
                    MealTypeSelectionFormField(
                      initialMealType: mealType,
                      onChanged: (v) => mealType = v!,
                      onSaved: (v) => _intakeBuilder.mealType = mealType = v!,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deleteIntake(int id) async {
    final isDeleted = await showDeleteDialog(
      context: context,
      onDelete: () => _apiService.deleteIntake(id),
    );

    if (isDeleted) {
      Navigator.pop(context);
    }
  }

  Future<Intake> _updateIntake() {
    return _apiService.updateIntake(widget.intake.id, _intakeBuilder.build());
  }

  Future<bool> _validateAndSaveIntake() {
    return FormUtils.validateAndSave(
      context: context,
      formKey: _formKey,
      futureBuilder: _updateIntake,
    );
  }
}
