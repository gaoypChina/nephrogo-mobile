import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/authentication/authentication_provider.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/app_future_builder.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class CountryScreen extends StatelessWidget {
  final _apiService = ApiService();
  final _authenticationProvider = AuthenticationProvider();

  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder<CountryResponse>(
      future: _apiService.getCountries,
      builder: (context, response) {
        return _CountryScreen(
          countries: response.countries.toList(),
          initialCountrySelection:
              response.selectedCountry ?? response.suggestedCountry,
        );
      },
      loadingAndErrorWrapper: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.appLocalizations.chooseCountry),
            actions: [
              if (!_authenticationProvider.isUserLoggedIn)
                IconButton(
                  icon: const Icon(Icons.contact_support_outlined),
                  tooltip: context.appLocalizations.support,
                  onPressed: () => showContactDialog(context),
                ),
            ],
          ),
          body: child,
        );
      },
    );
  }
}

class _CountryScreen extends StatefulWidget {
  final List<Country> countries;
  final Country? initialCountrySelection;

  const _CountryScreen({
    Key? key,
    required this.countries,
    required this.initialCountrySelection,
  }) : super(key: key);

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<_CountryScreen> {
  final _apiService = ApiService();
  final _appPreferences = AppPreferences();
  final _authenticationProvider = AuthenticationProvider();
  late List<Country> soredCountries;

  Country? selectedCountry;

  @override
  void initState() {
    selectedCountry = widget.initialCountrySelection;
    soredCountries = widget.countries
        .orderBy((c) => c == selectedCountry ? -1 : c.order ?? 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = selectedCountry?.supportedLocale ??
        Locale(context.appLocalizations.localeName);

    return Localizations.override(
      context: context,
      locale: locale,
      child: LayoutBuilder(
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(context.appLocalizations.chooseCountry),
              actions: [
                if (!_authenticationProvider.isUserLoggedIn)
                  IconButton(
                    icon: const Icon(Icons.contact_support_outlined),
                    tooltip: context.appLocalizations.support,
                    onPressed: () => showContactDialog(context),
                  ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: Scrollbar(
                    child: ListView.separated(
                      itemCount: soredCountries.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final country = soredCountries[index];

                        return BasicSection.single(
                          margin: EdgeInsets.zero,
                          child: AppRadioListTile<Country>(
                            title: Text(
                              country.localizedName(context.appLocalizations) ??
                                  country.name,
                            ),
                            value: country,
                            subtitle: Text(country.name),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                            secondary: SizedBox(
                              width: 40,
                              height: 40,
                              child: FittedBox(
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
                          label: Text(
                            context.appLocalizations
                                .formMultiSelectDialogActionChoose
                                .toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
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
}
