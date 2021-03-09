import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo_api_client/model/general_recommendation.dart';
import 'package:nephrogo_api_client/model/general_recommendation_category.dart';
import 'package:nephrogo_api_client/model/general_recommendation_response.dart';
import 'package:nephrogo_api_client/model/general_recommendation_subcategory.dart';

import 'general/app_future_builder.dart';
import 'general/components.dart';
import 'general/dialogs.dart';

class GeneralRecommendationsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder<GeneralRecommendationResponse>(
      future: ApiService().getGeneralRecommendations(),
      builder: (context, response) {
        final categories = response.categories.toList();

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: BasicSection.single(
                child: MaterialBanner(
                  leading: const CircleAvatar(child: Icon(Icons.announcement)),
                  content: const Text(
                      'TODO: Kažkoks disclaimeris, kad tai bendrojo pobūdžio '
                      'rekomendacijos ir būtina pasitarti su gydytoju'),
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

                  return Column(
                    children: [
                      if (index != 0) const Divider(height: 1),
                      _GeneralRecommendationListTile(
                        name: category.name,
                        onTap: () => Navigator.of(context).pushNamed(
                          Routes.routeGeneralRecommendationsCategory,
                          arguments:
                              GeneralRecommendationCategoryScreenArguments(
                            category,
                          ),
                        ),
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
      message: context.appLocalizations.recommendationsSources,
    );
  }
}

class GeneralRecommendationCategoryScreenArguments {
  final GeneralRecommendationCategory category;

  GeneralRecommendationCategoryScreenArguments(this.category);
}

class GeneralRecommendationCategoryScreen extends StatelessWidget {
  final GeneralRecommendationCategory category;

  const GeneralRecommendationCategoryScreen({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subcategories = category.subcategories.toList();

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: ListView.separated(
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          final subcategory = subcategories[index];

          return _GeneralRecommendationListTile(
            name: subcategory.name,
            onTap: () => Navigator.of(context).pushNamed(
              Routes.routeGeneralRecommendationsSubcategory,
              arguments: GeneralRecommendationSubcategoryScreenArguments(
                subcategory,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(height: 1),
      ),
    );
  }
}

class GeneralRecommendationSubcategoryScreenArguments {
  final GeneralRecommendationSubcategory subcategory;

  GeneralRecommendationSubcategoryScreenArguments(this.subcategory);
}

class GeneralRecommendationSubcategoryScreen extends StatelessWidget {
  final GeneralRecommendationSubcategory subcategory;

  const GeneralRecommendationSubcategoryScreen({
    Key key,
    @required this.subcategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recommendations = subcategory.recommendations.toList();

    return Scaffold(
      appBar: AppBar(title: Text(subcategory.name)),
      body: ListView.separated(
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final recommendation = recommendations[index];

          return _GeneralRecommendationListTile(
            name: recommendation.name,
            onTap: () => Navigator.of(context).pushNamed(
              Routes.routeGeneralRecommendation,
              arguments: GeneralRecommendationScreenArguments(
                recommendation,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(height: 1),
      ),
    );
  }
}

class GeneralRecommendationScreenArguments {
  final GeneralRecommendation recommendation;

  GeneralRecommendationScreenArguments(this.recommendation);
}

class GeneralRecommendationScreen extends StatelessWidget {
  final GeneralRecommendation recommendation;

  const GeneralRecommendationScreen({Key key, @required this.recommendation})
      : assert(recommendation != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.appLocalizations.generalRecommendations),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          HtmlWidget(
            _recommendationHtmlBody(),
            webView: true,
            webViewMediaPlaybackAlwaysAllow: true,
            textStyle:
                Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }

  String _recommendationHtmlBody() {
    return '<h1>${recommendation.name}</h1>${recommendation.body}';
  }
}

class _GeneralRecommendationListTile extends StatelessWidget {
  final String name;
  final GestureTapCallback onTap;

  const _GeneralRecommendationListTile({
    Key key,
    @required this.name,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicSection.single(
      margin: EdgeInsets.zero,
      child: AppListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(name),
        onTap: onTap,
      ),
    );
  }
}
