import 'package:flutter/material.dart';
import 'package:flutter_news_challenge/data/state/appStateProvider.dart';

class NavigationScreen extends StatelessWidget {
  final AppStateProvider _appState;

  const NavigationScreen(this._appState);

  void _onItemTapped(int index) {
    this._appState.updateScreen(index);
    this._appState.refresh();
  }

  @override
  Widget build(BuildContext context) {

    if(this._appState.isConnectivityChecked()) {
      this._appState.loadNews(context, this._appState.hasInternetConnection())
          .then((gotValues) {
        // Repaint the app if the store changed on loading news
        if (gotValues) {
          this._appState.refresh();
        }
      });
    }

    return Scaffold(
        body: this._appState.getCurrentScreen(),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'News',
              ),BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],

            currentIndex: this._appState.getCurrentScreenIndex(),
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped
        ));
  }
}
