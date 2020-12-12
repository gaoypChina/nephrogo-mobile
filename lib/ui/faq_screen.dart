import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nephrolog/ui/general/components.dart';

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
  final items = [
    _FAQItemsGroup(
      "KALIS",
      [
        _FAQItem(
            "Kaip atpažinti kalio perteklių?",
            "Retėja pulsas, tinsta liežuvis, veidas, lūpos, jaučiamas raumenų "
                "silpnumas, metalo skonis burnoje, nerimas spazminiai pilvo "
                "skausmai."),
        _FAQItem("Kaip atpažinti kalio trūkumą?",
            "Jaučiamas nuovargis, silpnumas, širdies ritmo sutrikimas."),
        _FAQItem(
            "Kaip sumažinti kalio kiekį maiste?",
            "- Smulkiai supjaustytus produktus virkite dideliame kiekyje (santykis 1:5-10) vandens.\n"
                "- Prieš gaminant, mirkykite daržoves 2-4 val. vanenyje arba bent gerai perplaukite po tekančiu šiltu vandeniu."),
      ],
    ),
    _FAQItemsGroup(
      "BALTYMAI",
      [
        _FAQItem("Kaip atpažinti baltymų perteklių?",
            "Pykinimas, apetito netekimas, silpnumas, skonio pokyčiai."),
        _FAQItem("Kaip atpažinti kalio trūkumą?",
            "Jaučiamas nuovargis, silpnumas, širdies ritmo sutrikimas."),
        _FAQItem(
            "Kaip sumažinti kalio kiekį maiste?",
            "- Smulkiai supjaustytus produktus virkite dideliame kiekyje (santykis 1:5-10) vandens.\n"
                "- Prieš gaminant, mirkykite daržoves 2-4 val. vanenyje arba bent gerai perplaukite po tekančiu šiltu vandeniu."),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 64),
      children: items.map((g) => _buildSection(context, g)).toList(),
    );
  }

  Widget _buildSection(BuildContext context, _FAQItemsGroup group) {
    final textTheme = Theme.of(context).textTheme;

    return SmallSection(
      title: group.name,
      headerPadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      showDividers: false,
      children: group.items.map((item) {
        return ExpansionTile(
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
