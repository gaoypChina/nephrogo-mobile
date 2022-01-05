import 'package:async/async.dart';
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
import 'package:nephrogo/ui/onboarding/onboarding_step.dart';
import 'package:nephrogo/ui/user_profile/user_profile_steps.dart';
import 'package:nephrogo/utils/utils.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

enum UserProfileNextScreenType {
  close,
  homeScreen,
}

class UserProfileScreen extends StatefulWidget {
  final UserProfileNextScreenType nextScreenType;

  const UserProfileScreen({Key? key, required this.nextScreenType})
      : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _apiService = ApiService();

  final _userProfileMemoizer =
      AsyncMemoizer<NullableApiResponse<UserProfileV2>>();

  @override
  void initState() {
    super.initState();

    _userProfileMemoizer.runOnce(() {
      return _apiService.getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder<NullableApiResponse<UserProfileV2>>(
      future: () => _userProfileMemoizer.future,
      builder: (context, data) {
        return _UserProfileScreenBody(
          userProfile: data.data,
          nextScreenType: widget.nextScreenType,
        );
      },
      loadingAndErrorWrapper: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(appLocalizations.userProfileScreenTitle),
            centerTitle: true,
          ),
          body: child,
        );
      },
    );
  }
}

class _UserProfileScreenBody extends StatefulWidget {
  final UserProfileV2? userProfile;
  final UserProfileNextScreenType nextScreenType;

  const _UserProfileScreenBody({
    Key? key,
    required this.userProfile,
    required this.nextScreenType,
  }) : super(key: key);

  @override
  _UserProfileScreenBodyState createState() => _UserProfileScreenBodyState();
}

class _UserProfileScreenBodyState extends State<_UserProfileScreenBody> {
  final _controller = PageController();

  final _apiService = ApiService();
  final _appPreferences = AppPreferences();
  final _authenticationProvider = AuthenticationProvider();

  late UserProfileV2RequestBuilder _userProfileBuilder;
  late DailyHealthStatusRequestBuilder _healthStatusBuilder;

  int page = 0;

  final List<UserProfileStep> _steps = [
    GenderStep(),
    ChronicKidneyDiseaseAgeStep(),
    ChronicKidneyDiseaseStageStep(),
    DialysisStep(),
    DiabetesStep(),
    HeightStep(),
    BirthdayStep(),
    WeightStep(),
  ];

  int get _totalSteps => _steps.length + 1;

  bool get isDone => page + 1 == _totalSteps;

  @override
  void initState() {
    super.initState();

    _userProfileBuilder =
        widget.userProfile?.toRequestBuilder() ?? UserProfileV2RequestBuilder();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: _getAppBar(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _totalSteps,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return OnboardingStepComponent(
                      assetName: 'assets/onboarding/3.png',
                      title: appLocalizations.userProfileExplanationTitle,
                      description: appLocalizations.userProfileExplanation,
                      fontColor: null,
                      imageColor: Theme.of(context).textTheme.bodyText1!.color,
                    );
                  }
                  return _steps[index - 1].build(
                    context,
                    _userProfileBuilder,
                    _healthStatusBuilder,
                    setState,
                  );
                },
                onPageChanged: (int p) {
                  setState(() => page = p);
                },
              ),
            ),
            BasicSection.single(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: AppElevatedButton(
                    onPressed: () => _advancePageOrFinish(),
                    label: isDone
                        ? Text(appLocalizations.save.toUpperCase())
                        : Text(appLocalizations.further.toUpperCase()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    if (page == 0) {
      return AppBar(
        leading: const CloseButton(),
        title: Text(appLocalizations.userProfileScreenTitle),
        centerTitle: true,
        actions: [
          if (widget.nextScreenType == UserProfileNextScreenType.homeScreen)
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: context.appLocalizations.logout,
              onPressed: () => _signOut(),
            ),
        ],
      );
    } else {
      return AppBar(
        leading: BackButton(onPressed: _previousStep),
        title: Text('$page / ${_totalSteps - 1}'),
        centerTitle: true,
        actions: [
          if (widget.nextScreenType == UserProfileNextScreenType.homeScreen)
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: context.appLocalizations.logout,
              onPressed: () => _signOut(),
            ),
        ],
      );
    }
  }

  Future _signOut() async {
    await _authenticationProvider.signOut();

    await Navigator.pushReplacementNamed(
      context,
      Routes.routeStart,
    );
  }

  Future<void> _advancePageOrFinish() async {
    if (page != 0) {
      if (!_steps[page - 1].validate(
        _userProfileBuilder,
        _healthStatusBuilder,
      )) {
        return showAppDialog(
          context: context,
          title: context.appLocalizations.error,
          content: Text(context.appLocalizations.formErrorDescription),
        );
      }
    }

    if (page + 1 == _totalSteps) {
      await _validateAndSaveUserProfile();
    } else {
      await _animateToPage(page + 1);
    }
  }

  Future<bool> _previousStep() async {
    if (page == 0) {
      return false;
    }
    return _animateToPage(page - 1);
  }

  Future<bool> _onWillPop() async {
    final hasPrevious = await _previousStep();

    return !hasPrevious;
  }

  Future<bool> _animateToPage(int page) {
    return _controller
        .animateToPage(
          page,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        )
        .then((_) => true);
  }

  Future<UserProfileV2> _saveUserProfileToApi() async {
    final userProfileRequest = _userProfileBuilder.build();
    final healthStatusPartialRequest = _healthStatusBuilder.build();

    final userProfile =
        _apiService.createOrUpdateUserProfile(userProfileRequest);

    await _apiService
        .partialUpdateDailyHealthStatus(healthStatusPartialRequest);

    return userProfile;
  }

  Future<bool> _validateAndSaveUserProfile() async {
    final notValid = _steps.any(
      (s) => !s.validate(
        _userProfileBuilder,
        _healthStatusBuilder,
      ),
    );

    if (notValid) {
      await showAppErrorDialog(
        context: context,
        message: appLocalizations.formErrorDescription,
      );

      return false;
    }

    return ApiUtils.saveToApi(
      context: context,
      futureBuilder: () => _saveUserProfileToApi(),
      onSuccess: _onSavedSuccess,
    );
  }

  Future<void> _onSavedSuccess() async {
    await _appPreferences.setProfileCreated();

    await _appPreferences.setDialysisType(_userProfileBuilder.dialysis);

    await _navigateToAnotherScreen();
  }

  Future _navigateToAnotherScreen() async {
    switch (widget.nextScreenType) {
      case UserProfileNextScreenType.close:
        Navigator.pop(context);
        break;
      case UserProfileNextScreenType.homeScreen:
        return Navigator.pushReplacementNamed(
          context,
          Routes.routeHome,
        );
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
