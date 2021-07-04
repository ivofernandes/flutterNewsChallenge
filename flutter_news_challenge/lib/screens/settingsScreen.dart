import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/data/state/appStateProvider.dart';
import 'package:flutter_news_challenge/data/state/settings/settingsThemeState.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppStateProvider appState =
        Provider.of<AppStateProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    String currentPlatform =
        Platform.operatingSystem.substring(0, 1).toUpperCase() +
            Platform.operatingSystem.substring(1);

    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentPlatform +
                      ' app admission test, provided by frontkom.com',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Text('App theme'),
                SizedBox(height: 0),
                Row(
                  children: SettingsThemeState.AVAILABLE_THEMES
                      .map((theme) => SizedBox(
                          height: 60,
                          width: (width - 20) / 3,
                          child: GestureDetector(
                            onTap: (){
                              appState.updateTheme(theme);
                              appState.refresh();
                            },
                            child: Container(
                              // This hack of zero opacity color is just for the container,
                              // that covers the button with defined by the parent sizedbox,
                              // to be really clickable
                              // ---->
                              color: Colors.green.withOpacity(0.0),
                              // <-----
                              child: Row(
                                children: [
                                  Radio(
                                      value: theme,
                                      groupValue: appState.getLayout(),
                                      onChanged: (newTheme) {
                                        appState.updateTheme(theme);
                                        appState.refresh();
                                      }),
                                  Text(theme),
                                ],
                              ),
                            ),
                          )))
                      .toList(),
                ),
              ],
            ),
          ),
          Text('Version 0.0.1',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.5),
                  ))
        ],
      ),
    );
  }
}
