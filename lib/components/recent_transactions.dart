import 'package:flutter/material.dart';

import '../utilities/theme_styles.dart';
import '../widgets/transaction_card.dart';

class RecentTransactions extends StatefulWidget {
  const RecentTransactions({Key? key}) : super(key: key);

  @override
  _RecentTransactionsState createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 16.0,
              top: 32.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transacciones Recientes',
                    style: ThemeStyles.primaryTitle),
                Text('Ver Todo', style: ThemeStyles.seeAll),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: const <Widget>[
                TransactionCard(
                  color: Colors.black,
                  letter: 'F',
                  title: 'Johan Canzanese',
                  subTitle: 'LibrePago',
                  price: '- 5.720,30 €',
                ),
                TransactionCard(
                  color: Color(0xfffe695d),
                  letter: 'D',
                  title: 'Domink Schmidit',
                  subTitle: 'UbiiPagos',
                  price: '- 620,30 €',
                ),
                TransactionCard(
                  color: Color(0xff103289),
                  letter: 'E',
                  title: 'Evolt.io',
                  subTitle: 'VePagos',
                  price: '- 59,99 €',
                ),
                TransactionCard(
                  color: Colors.greenAccent,
                  letter: 'F',
                  title: 'Fintory GmbH',
                  subTitle: 'Finance Landing Page',
                  price: '- 5.720,30 €',
                ),
                TransactionCard(
                  color: Colors.amberAccent,
                  letter: 'E',
                  title: 'Evolt.io',
                  subTitle: 'Evolt UI Kit',
                  price: '- 59,99 €',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
