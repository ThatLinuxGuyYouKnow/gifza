import 'package:flutter/material.dart';
import 'package:gifza/providers/screenProvider.dart';

import 'package:provider/provider.dart';

class GifzaAppBar extends StatelessWidget {
  GifzaAppBar({super.key});

  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final screenState = Provider.of<ScreenProvider>(context, listen: true);
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: scheme.primary.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 2,
              offset: Offset(0, 4))
        ]),
        child: AppBar(
          toolbarHeight: 80,
          surfaceTintColor: Colors.transparent,
          backgroundColor: scheme.surface,
          elevation: 2,
          title: Row(children: [Text('Gifza', style: textTheme.titleMedium)]),
          actions: [
            screenState.currentScreen == AppScreen.home
                ? IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      screenState.routeToScreen(screen: AppScreen.settings);
                    },
                  )
                : Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: scheme.primary,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          screenState.routeToScreen(screen: AppScreen.home);
                        },
                        style: ButtonStyle(),
                        child: Text(
                          'Back To Home',
                          style: TextStyle(
                              color: scheme.primary, fontFamily: 'Vietnam'),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      )
                    ],
                  )
          ],
        ));
  }
}
