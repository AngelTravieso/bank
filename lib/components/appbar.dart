import 'package:flutter/material.dart';

class Appbar extends StatefulWidget {
  const Appbar({Key? key}) : super(key: key);

  @override
  _AppbarState createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          Text(
            'Inicio',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          // Row(
          //   children: [
          //     IconButton(
          //       icon: SvgPicture.asset('assets/svg/analytics-icon.svg'),
          //       onPressed: null,
          //     ),
          //     IconButton(
          //       icon: SvgPicture.asset('assets/svg/search-icon.svg'),
          //       onPressed: null,
          //     ),
          //     IconButton(
          //       icon: SvgPicture.asset('assets/svg/more-icon.svg'),
          //       onPressed: null,
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
