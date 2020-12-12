import 'package:flutter/material.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/extensions/collection_extensions.dart';

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

class _FAQItem {
  final String question;
  final String answer;

  const _FAQItem(this.question, this.answer);
}

class FrequentlyAskedQuestionsScreenBody extends StatefulWidget {
  @override
  _FrequentlyAskedQuestionsScreenBodyState createState() =>
      _FrequentlyAskedQuestionsScreenBodyState();
}

class _FrequentlyAskedQuestionsScreenBodyState
    extends State<FrequentlyAskedQuestionsScreenBody> {
  final items = [
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
  ];

  int expandedIndex;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.symmetric(vertical: 6),
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            expandedIndex = isExpanded ? null : index;
          });
        },
        children: items.mapIndexed((i, item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return AppListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(
                  item.question,
                  style: textTheme.subtitle1.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AppListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                subtitle: Text(
                  item.answer,
                  style: textTheme.subtitle1,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            canTapOnHeader: true,
            isExpanded: i == expandedIndex,
          );
        }).toList(),
      ),
    );
    // throw BasicSection(
    //   header:
    // );
  }
}
