import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/screens/navigationScreen.dart';
import 'package:provider/provider.dart';

import 'data/state/appStateProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        create: (_) => AppStateProvider(context),
        child: Consumer<AppStateProvider>(
            builder: (context, appState, child) {
              ThemeData theme = appState.getTheme();

              return MaterialApp(
                  theme: theme,
                  debugShowCheckedModeBanner: false,
                  title: "Flutter News Challenge",
                  home: SafeArea(
                    child: Scaffold(
                        body: NavigationScreen()
                    ),
                  )
              );
            })
    );

  }
}
