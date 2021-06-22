import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/authentication/authentication_provider.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/app_future_builder.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class CountryScreen extends StatelessWidget {
  final _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.appLocalizations.chooseCountry)),
      body: AppFutureBuilder<CountryResponse>(
        future: _apiService.getCountries,
        builder: (context, response) {
          return CountryScreenBody(countryResponse: response);
        },
      ),
    );
  }
}

class CountryScreenBody extends StatefulWidget {
  final CountryResponse countryResponse;

  const CountryScreenBody({Key? key, required this.countryResponse})
      : super(key: key);

  @override
  _CountryScreenBodyState createState() => _CountryScreenBodyState();
}

class _CountryScreenBodyState extends State<CountryScreenBody> {
  final _apiService = ApiService();
  final _appPreferences = AppPreferences();
  final _authenticationProvider = AuthenticationProvider();

  Country? selectedCountry;

  @override
  void initState() {
    selectedCountry = widget.countryResponse.selectedCountry ??
        widget.countryResponse.suggestedCountry;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.supportedLocales
            .where((loc) => loc.languageCode == selectedCountry?.code)
            .firstOrNull() ??
        Locale(context.appLocalizations.localeName);

    return Localizations.override(
      context: context,
      locale: locale,
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: widget.countryResponse.countries.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final country = widget.countryResponse.countries[index];

                return BasicSection.single(
                  margin: EdgeInsets.zero,
                  child: AppRadioListTile<Country>(
                    title: Text(
                      _localizedCountryName(country, appLocalizations) ??
                          country.name,
                    ),
                    value: country,
                    subtitle: _countrySubtitle(country, appLocalizations),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    secondary: SizedBox(
                      width: 40,
                      height: 40,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Text(country.flagEmoji),
                      ),
                    ),
                    groupValue: selectedCountry,
                    onChanged: _onCountryChanged,
                  ),
                );
              },
            ),
          ),
          BasicSection(
            margin: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: AppElevatedButton(
                    onPressed: selectedCountry != null
                        ? () => _onCountrySelectionSaved(selectedCountry!)
                        : null,
                    label: Text(appLocalizations
                        .formMultiSelectDialogActionChoose
                        .toUpperCase()),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onCountryChanged(Country? country) {
    setState(() {
      selectedCountry = country;
    });
  }

  Future<void> _onCountrySelectionSaved(Country country) async {
    if (_authenticationProvider.isUserLoggedIn) {
      await _apiService.selectCountry(country.code);
    }
    await _appPreferences.setCountry(country);
    await _appPreferences.setLanguage(country);

    if (_authenticationProvider.isUserLoggedIn) {
      Navigator.pop(context);
    } else {
      await Navigator.pushReplacementNamed(
        context,
        Routes.routeStart,
      );
    }
  }

  String? _localizedCountryName(
      Country country, AppLocalizations appLocalizations) {
    switch (country.code) {
      case 'LT':
        return appLocalizations.lithuania;
      case 'DE':
        return appLocalizations.germany;
      default:
        return null;
    }
  }

  Text? _countrySubtitle(Country country, AppLocalizations appLocalizations) {
    final localizedName =
        _localizedCountryName(country, appLocalizations) ?? country.name;

    if (localizedName != country.name) {
      return Text(country.name);
    } else {
      return null;
    }
  }
}
