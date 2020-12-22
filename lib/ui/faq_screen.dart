import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/l10n/localizations.dart';

class FrequentlyAskedQuestionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dažniausiai užduodami klausimai"),
      ),
      body: FrequentlyAskedQuestionsScreenBody(),
    );
  }
}

class _FAQItemsGroup extends Equatable {
  final String name;
  final List<_FAQItem> items;

  _FAQItemsGroup(this.name, this.items);

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
            localizations.faq_potassium_question_1,
            localizations.faq_potassium_question_1_answer,
          ),
          _FAQItem(
            localizations.faq_potassium_question_2,
            localizations.faq_potassium_question_2_answer,
          ),
          _FAQItem(
            localizations.faq_potassium_question_3,
            localizations.faq_potassium_question_3_answer,
          ),
          _FAQItem(
            localizations.faq_potassium_question_4,
            localizations.faq_potassium_question_4_answer,
          ),
        ],
      ),
      _FAQItemsGroup(
        localizations.proteins,
        [
          _FAQItem(
            localizations.faq_proteins_question_1,
            localizations.faq_proteins_question_1_answer,
          ),
          _FAQItem(
            localizations.faq_proteins_question_2,
            localizations.faq_proteins_question_2_answer,
          ),
          _FAQItem(
            localizations.faq_proteins_question_3,
            localizations.faq_proteins_question_3_answer,
          ),
          _FAQItem(
            localizations.faq_proteins_question_4,
            localizations.faq_proteins_question_4_answer,
          ),
        ],
      ),
      _FAQItemsGroup(
        localizations.sodium,
        [
          _FAQItem(
            localizations.faq_sodium_question_1,
            localizations.faq_sodium_question_1_answer,
          ),
          _FAQItem(
            localizations.faq_sodium_question_2,
            localizations.faq_sodium_question_2_answer,
          ),
          _FAQItem(
            localizations.faq_sodium_question_3,
            localizations.faq_sodium_question_3_answer,
          ),
          _FAQItem(
            localizations.faq_sodium_question_4,
            localizations.faq_sodium_question_4_answer,
          ),
        ],
      ),
      _FAQItemsGroup(
        localizations.sodium,
        [
          _FAQItem(
            localizations.faq_sodium_question_1,
            localizations.faq_sodium_question_1_answer,
          ),
          _FAQItem(
            localizations.faq_sodium_question_2,
            localizations.faq_sodium_question_2_answer,
          ),
          _FAQItem(
            localizations.faq_sodium_question_3,
            localizations.faq_sodium_question_3_answer,
          ),
          _FAQItem(
            localizations.faq_sodium_question_4,
            localizations.faq_sodium_question_4_answer,
          ),
        ],
      ),
      _FAQItemsGroup(
        localizations.phosphorus,
        [
          _FAQItem(
            localizations.faq_phosphorus_question_1,
            localizations.faq_phosphorus_question_1_answer,
          ),
          _FAQItem(
            localizations.faq_phosphorus_question_2,
            localizations.faq_phosphorus_question_2_answer,
          ),
          _FAQItem(
            localizations.faq_phosphorus_question_3,
            localizations.faq_phosphorus_question_3_answer,
          ),
          _FAQItem(
            localizations.faq_phosphorus_question_4,
            localizations.faq_phosphorus_question_4_answer,
          ),
        ],
      ),
      _FAQItemsGroup(
        localizations.liquids,
        [
          _FAQItem(
            localizations.faq_liquids_question_1,
            localizations.faq_liquids_question_1_answer,
          ),
        ],
      ),
      _FAQItemsGroup(
        localizations.energy,
        [
          _FAQItem(
            localizations.faq_energy_question_1,
            localizations.faq_energy_question_1_answer,
          ),
        ],
      ),
    ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildSection(context, items[index]);
      },
    );
  }

  Widget _buildSection(BuildContext context, _FAQItemsGroup group) {
    final textTheme = Theme.of(context).textTheme;

    return SmallSection(
      title: group.name.toUpperCase(),
      headerPadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      showDividers: false,
      children: group.items.map((item) {
        return ExpansionTile(
          key: ObjectKey(item),
          title: Text(item.question),
          children: [
            AppListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
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
