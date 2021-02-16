import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/app_future_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/model/general_recommendation_category.dart';
import 'package:nephrogo_api_client/model/general_recommendations_response.dart';

import 'general/dialogs.dart';

class GeneralRecommendationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.generalRecommendations)),
      body: AppFutureBuilder<GeneralRecommendationsResponse>(
        future: ApiService().getGeneralRecommendations(),
        builder: (context, response) {
          final categories = response.categories.toList();

          return ListView.separated(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return AppListTile(
                title: Text(category.name),
                onTap: () => Navigator.of(context).pushNamed(
                  Routes.routeGeneralRecommendationsCategory,
                  arguments: GeneralRecommendationsCategoryScreenArguments(
                    category,
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 1),
          );
        },
      ),
    );
  }
}

class GeneralRecommendationsCategoryScreenArguments {
  final GeneralRecommendationCategory category;

  GeneralRecommendationsCategoryScreenArguments(this.category);
}

class GeneralRecommendationsCategoryScreen extends StatelessWidget {
  final GeneralRecommendationCategory category;

  const GeneralRecommendationsCategoryScreen({Key key, @required this.category})
      : assert(category != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final recommendations = category.recommendations.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        actions: [
          TextButton(
            onPressed: () => _openSources(context),
            child: Text(
              appLocalizations.sources.toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final recommendation = recommendations[index];

          return AppExpansionTile(
            key: PageStorageKey(recommendation),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                recommendation.question,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    recommendation.answer,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 1),
      ),
    );
  }

  Future<void> _openSources(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return showAppDialog(
      context: context,
      title: appLocalizations.sources,
      message: appLocalizations.recommendationsSources,
    );
  }
}
