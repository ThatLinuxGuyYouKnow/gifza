import 'package:flutter/material.dart';

class HeaderTexts extends StatelessWidget {
  HeaderTexts({super.key});

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Semantic',
              style: TextStyle(
                  fontFamily: 'Vietnam',
                  fontSize: 64,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              'Studio',
              style: TextStyle(
                  fontFamily: 'Vietnam',
                  fontWeight: FontWeight.w700,
                  fontSize: 64,
                  color: Color.fromARGB(255, 215, 121, 255)),
            )
          ]),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Describe what you\'re looking for and find it across your assets',
              style: TextStyle(fontFamily: 'Vietnam', fontSize: 18),
            ),
          ])
        ],
      ),
    );
  }
}
