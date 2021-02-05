import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/ui/general/components.dart';

class FrequentlyAskedQuestionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).faqTitle)),
      body: FrequentlyAskedQuestionsScreenBody(),
    );
  }
}

class _FAQItemsGroup extends Equatable {
  final String name;
  final List<_FAQItem> items;

  const _FAQItemsGroup(this.name, this.items);

  @override
  List<Object> get props => [name, items];
}

class _FAQItem extends Equatable {
  final String question;
  final String answer;

  const _FAQItem(this.question, this.answer);

  @override
  List<Object> get props => [question, answer];
}

class FrequentlyAskedQuestionsScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final items = [
      _FAQItemsGroup(
        localizations.potassium,
        [
          _FAQItem(
            localizations.faqPotassiumQuestion1,
            localizations.faqPotassiumQuestion1Answer,
          ),
          _FAQItem(
            localizations.faqPotassiumQuestion2,
            localizations.faqPotassiumQuestion2Answer,
          ),
          _FAQItem(
            localizations.faqPotassiumQuestion3,
            localizations.faqPotassiumQuestion3Answer,
          ),
          _FAQItem(
            localizations.faqPotassiumQuestion4,
            localizations.faqPotassiumQuestion4Answer,
          ),
        ],
      ),
      _FAQItemsGroup(
        localizations.proteins,
        [
          _FAQItem(
            localizations.faqProteinsQuestion1,
            localizations.faqProteinsQuestion1Answer,
          ),
          _FAQItem(
            localizations.faqProteinsQuestion2,
            localizations.faqProteinsQuestion2Answer,
          ),
          _FAQItem(
            localizations.faqProteinsQuestion3,
            localizations.faqProteinsQuestion3Answer,
          ),
          _FAQItem(
            localizations.faqProteinsQuestion4,
            localizations.faqProteinsQuestion4Answer,
          ),
        ],
      ),
      _FAQItemsGroup(
        localizations.sodium,
        [
          _FAQItem(
            localizations.faqSodiumQuestion1,
            localizations.faqSodiumQuestion1Answer,
          ),
          _FAQItem(
            localizations.faqSodiumQuestion2,
            localizations.faqSodiumQuestion2Answer,
          ),
          _FAQItem(
            localizations.faqSodiumQuestion3,
            localizations.faqSodiumQuestion3Answer,
          ),
          _FAQItem(
            localizations.faqSodiumQuestion4,
            localizations.faqSodiumQuestion4Answer,
          ),
        ],
      ),
      _FAQItemsGroup(
        localizations.sodium,
        [
          _FAQItem(
            localizations.faqSodiumQuestion1,
            localizations.faqSodiumQuestion1Answer,
          ),
          _FAQItem(
            localizations.faqSodiumQuestion2,
            localizations.faqSodiumQuestion2Answer,
          ),
          _FAQItem(
            localizations.faqSodiumQuestion3,
            localizations.faqSodiumQuestion3Answer,
          ),
          _FAQItem(
            localizations.faqSodiumQuestion4,
            localizations.faqSodiumQuestion4Answer,
          ),
        ],
      ),
      _FAQItemsGroup(
        localizations.phosphorus,
        [
          _FAQItem(
            localizations.faqPhosphorusQuestion1,
            localizations.faqPhosphorusQuestion1Answer,
          ),
          _FAQItem(
            localizations.faqPhosphorusQuestion2,
            localizations.faqPhosphorusQuestion2Answer,
          ),
          _FAQItem(
            localizations.faqPhosphorusQuestion3,
            localizations.faqPhosphorusQuestion3Answer,
          ),
          _FAQItem(
            localizations.faqPhosphorusQuestion4,
            localizations.faqPhosphorusQuestion4Answer,
          ),
        ],
      ),
      _FAQItemsGroup(
        localizations.liquids,
        [
          _FAQItem(
            localizations.faqLiquidsQuestion1,
            localizations.faqLiquidsQuestion1Answer,
          ),
        ],
      ),
      _FAQItemsGroup(
        localizations.energy,
        [
          _FAQItem(
            localizations.faqEnergyQuestion1,
            localizations.faqEnergyQuestion1Answer,
          ),
        ],
      ),
    ];

    return Scrollbar(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildSection(context, items[index]);
        },
      ),
    );
  }

  Widget _buildSection(BuildContext context, _FAQItemsGroup group) {
    final textTheme = Theme.of(context).textTheme;

    return SmallSection(
      title: group.name.toUpperCase(),
      children: group.items.map((item) {
        return ExpansionTile(
          key: ObjectKey(item),
          title: Text(item.question),
          children: [
            AppListTile(
              subtitle: Text(
                item.answer,
                style: textTheme.subtitle1,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
