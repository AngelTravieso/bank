import 'package:flutter/material.dart';

import '../utilities/theme_color.dart';
import '../utilities/theme_styles.dart';
import '../widgets/credit_card.dart';

class CardsList extends StatefulWidget {
  const CardsList({Key? key}) : super(key: key);

  @override
  _CardsListState createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  List cardList = [
    const CreditCard(),
    const CreditCard(),
    const CreditCard(),
    const CreditCard(),
    const CreditCard(),
  ];

  int _currentCard = 0;

  final PageController _pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentCard = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 32.0, left: 15.0, right: 15.0, bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tus Tarjetas', style: ThemeStyles.primaryTitle),
              Text('Ver Todo', style: ThemeStyles.seeAll),
            ],
          ),
        ),
        SizedBox(
          height: 246.0,
          child: PageView.builder(
            itemCount: cardList.length,
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) => const CreditCard(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < cardList.length; i++)
                if (_currentCard == i)
                  const DotIndicator(isActive: true)
                else
                  const DotIndicator(isActive: false)
            ],
          ),
        )
      ],
    );
  }
}

class DotIndicator extends StatefulWidget {
  final bool isActive;
  const DotIndicator({Key? key, required this.isActive}) : super(key: key);
  @override
  _DotIndicatorState createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: widget.isActive ? ThemeColors.black : ThemeColors.grey,
        ),
      ),
    );
  }
}
