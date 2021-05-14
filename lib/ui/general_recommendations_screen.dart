import 'dart:collection';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_url_launcher/fwfh_url_launcher.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/utils/utils.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

import 'general/app_future_builder.dart';
import 'general/components.dart';
import 'general/dialogs.dart';

class GeneralRecommendationsTab extends StatefulWidget {
  @override
  _GeneralRecommendationsTabState createState() =>
      _GeneralRecommendationsTabState();
}

class _GeneralRecommendationsTabState extends State<GeneralRecommendationsTab> {
  Set<int> _readRecommendationIds = <int>{};

  final _recommendationsResponseMemoizer =
      AsyncMemoizer<GeneralRecommendationsResponse>();

  @override
  void initState() {
    super.initState();

    _recommendationsResponseMemoizer.runOnce(() {
      return ApiService().getGeneralRecommendations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder<GeneralRecommendationsResponse>(
      future: () => _recommendationsResponseMemoizer.future,
      builder: (context, response) {
        final categories = response.categories.toList();

        if (_readRecommendationIds.isEmpty) {
          _readRecommendationIds =
              HashSet<int>.from(response.readRecommendationIds);
        }

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: BasicSection.single(
                child: MaterialBanner(
                  leading: const CircleAvatar(child: Icon(Icons.info_outline)),
                  content: Text(
                    context.appLocalizations.generalRecommendationsDisclaimer,
                  ),
                  forceActionsBelow: true,
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => _openSources(context),
                      child:
                          Text(context.appLocalizations.sources.toUpperCase()),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final category = categories[index];

                  final totalUnreadRecommendations = category
                      .totalUnreadRecommendations(_readRecommendationIds);

                  return Column(
                    children: [
                      if (index != 0) const Divider(height: 1),
                      _GeneralRecommendationListTile(
                        name: category.name,
                        totalUnreadRecommendations: totalUnreadRecommendations,
                        onTap: () async {
                          final ids =
                              await Navigator.of(context).pushNamed<Set<int>>(
                            Routes.routeGeneralRecommendationsCategory,
                            arguments:
                                GeneralRecommendationCategoryScreenArguments(
                                    category, _readRecommendationIds),
                          );

                          if (ids == null) {
                            throw ArgumentError.value(
                              ids,
                              'readRecommendationIds',
                              'Please return readRecommendationIds from route',
                            );
                          }

                          setState(() {
                            _readRecommendationIds = ids;
                          });
                        },
                      ),
                    ],
                  );
                },
                childCount: categories.length,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openSources(BuildContext context) {
    return showAppDialog(
      context: context,
      title: context.appLocalizations.sources,
      content: Linkify(
        text: context.appLocalizations.recommendationsSources,
        onOpen: (link) => launchURL(link.url),
      ),
    );
  }
}

class GeneralRecommendationCategoryScreenArguments {
  final GeneralRecommendationCategory category;
  final Set<int> readRecommendationIds;

  GeneralRecommendationCategoryScreenArguments(
    this.category,
    this.readRecommendationIds,
  );
}

class GeneralRecommendationCategoryScreen extends StatefulWidget {
  final GeneralRecommendationCategory category;

  final Set<int> readRecommendationIds;

  const GeneralRecommendationCategoryScreen({
    Key? key,
    required this.category,
    required this.readRecommendationIds,
  }) : super(key: key);

  @override
  _GeneralRecommendationCategoryScreenState createState() =>
      _GeneralRecommendationCategoryScreenState();
}

class _GeneralRecommendationCategoryScreenState
    extends State<GeneralRecommendationCategoryScreen> {
  late Set<int> readRecommendationIds;

  @override
  void initState() {
    super.initState();

    readRecommendationIds = widget.readRecommendationIds;
  }

  @override
  Widget build(BuildContext context) {
    final subcategories = widget.category.subcategories.toList();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, readRecommendationIds);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.category.name)),
        body: Scrollbar(
          isAlwaysShown: true,
          child: ListView.separated(
            itemCount: subcategories.length,
            itemBuilder: (context, index) {
              final subcategory = subcategories[index];
              final totalUnreadRecommendations =
                  subcategory.totalUnreadRecommendations(readRecommendationIds);

              return _GeneralRecommendationListTile(
                totalUnreadRecommendations: totalUnreadRecommendations,
                name: subcategory.name,
                onTap: () async {
                  final ids = await Navigator.of(context).pushNamed<Set<int>>(
                    Routes.routeGeneralRecommendationsSubcategory,
                    arguments: GeneralRecommendationSubcategoryScreenArguments(
                      subcategory,
                      readRecommendationIds,
                    ),
                  );

                  if (ids == null) {
                    throw ArgumentError.value(
                      ids,
                      'readRecommendationIds',
                      'Please return readRecommendationIds from route',
                    );
                  }

                  setState(() {
                    readRecommendationIds = ids;
                  });
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 1),
          ),
        ),
      ),
    );
  }
}

class GeneralRecommendationSubcategoryScreenArguments {
  final GeneralRecommendationSubcategory subcategory;
  final Set<int> readRecommendationIds;

  GeneralRecommendationSubcategoryScreenArguments(
    this.subcategory,
    this.readRecommendationIds,
  );
}

class GeneralRecommendationSubcategoryScreen extends StatefulWidget {
  final GeneralRecommendationSubcategory subcategory;
  final Set<int> readRecommendationIds;

  const GeneralRecommendationSubcategoryScreen({
    Key? key,
    required this.subcategory,
    required this.readRecommendationIds,
  }) : super(key: key);

  @override
  _GeneralRecommendationSubcategoryScreenState createState() =>
      _GeneralRecommendationSubcategoryScreenState();
}

class _GeneralRecommendationSubcategoryScreenState
    extends State<GeneralRecommendationSubcategoryScreen> {
  late Set<int> readRecommendationIds;

  @override
  void initState() {
    super.initState();

    readRecommendationIds = widget.readRecommendationIds;
  }

  @override
  Widget build(BuildContext context) {
    final recommendations = widget.subcategory.recommendations.toList();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, readRecommendationIds);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.subcategory.name)),
        body: Scrollbar(
          isAlwaysShown: true,
          child: ListView.separated(
            itemCount: recommendations.length,
            itemBuilder: (context, index) {
              final recommendation = recommendations[index];
              final isNotRead = recommendation.isNotRead(readRecommendationIds);

              return _GeneralRecommendationListTile(
                name: recommendation.name,
                totalUnreadRecommendations: isNotRead ? 1 : 0,
                singleRecommendationIcon: Icons.help_outline,
                onTap: () async {
                  await Navigator.of(context).pushNamed(
                    Routes.routeGeneralRecommendation,
                    arguments: GeneralRecommendationScreenArguments(
                      recommendation,
                      widget.subcategory,
                    ),
                  );

                  setState(() {
                    readRecommendationIds = readRecommendationIds
                      ..add(recommendation.id);
                  });
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 1),
          ),
        ),
      ),
    );
  }
}

class GeneralRecommendationScreenArguments {
  final GeneralRecommendation recommendation;
  final GeneralRecommendationSubcategory subcategory;

  GeneralRecommendationScreenArguments(this.recommendation, this.subcategory);
}

class GeneralRecommendationScreen extends StatefulWidget {
  final GeneralRecommendation recommendation;
  final GeneralRecommendationSubcategory subcategory;

  const GeneralRecommendationScreen({
    Key? key,
    required this.recommendation,
    required this.subcategory,
  }) : super(key: key);

  @override
  _GeneralRecommendationScreenState createState() =>
      _GeneralRecommendationScreenState();
}

class _GeneralRecommendationScreenState
    extends State<GeneralRecommendationScreen> {
  final _apiService = ApiService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => _markRecommendationAsRead(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subcategory.name),
      ),
      body: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: BasicSection.single(
            innerPadding: const EdgeInsets.all(16),
            margin: EdgeInsets.zero,
            child: HtmlWidget(
              widget.recommendation.body,
              factoryBuilder: () => _HtmlWidgetFactory(),
              baseUrl: Uri.parse(Constants.apiUrl),
              textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _markRecommendationAsRead() {
    return _apiService
        .markGeneralRecommendationAsRead(widget.recommendation.id);
  }
}

class _GeneralRecommendationListTile extends StatelessWidget {
  final String name;
  final int totalUnreadRecommendations;
  final GestureTapCallback onTap;
  final IconData? singleRecommendationIcon;

  const _GeneralRecommendationListTile({
    Key? key,
    required this.name,
    required this.totalUnreadRecommendations,
    required this.onTap,
    this.singleRecommendationIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicSection.single(
      margin: EdgeInsets.zero,
      child: AppListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: _getLeading(),
        title: Text(name),
        onTap: onTap,
      ),
    );
  }

  Widget _getLeading() {
    if (totalUnreadRecommendations == 0) {
      return const CircleAvatar(
        child: Icon(Icons.done, color: Colors.white),
      );
    } else if (singleRecommendationIcon != null &&
        totalUnreadRecommendations == 1) {
      return CircleAvatar(
        backgroundColor: Colors.orange,
        child: Icon(singleRecommendationIcon, color: Colors.white),
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.orange,
        child: Text(
          totalUnreadRecommendations.toString(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
    }
  }
}

class _HtmlWidgetFactory extends WidgetFactory with UrlLauncherFactory {}
