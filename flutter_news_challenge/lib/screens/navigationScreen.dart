import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/data/state/appStateProvider.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatelessWidget {
  AppStateProvider? _appState;

  void _onItemTapped(int index) {
    this._appState!.updateScreen(index);
    this._appState!.refresh();
  }

  @override
  Widget build(BuildContext context) {
    this._appState = Provider.of<AppStateProvider>(context, listen: false);

    return Scaffold(
        body: Center(
          child: this._appState!.getCurrentScreen(),
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'News',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],

            currentIndex: this._appState!.getCurrentScreenIndex(),
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped
        ));
  }
}
