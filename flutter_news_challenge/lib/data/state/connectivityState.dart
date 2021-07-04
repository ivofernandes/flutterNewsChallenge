import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class ConnectivityState {
  static const String UNKOWN = 'Unknown';
  String _connectionStatus = UNKOWN;

  bool isConnectivityChecked(){
    return _connectionStatus != UNKOWN;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await (Connectivity().checkConnectivity());
    } on PlatformException catch (e) {
      print(e.toString());
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        _connectionStatus = result.toString();
        break;
      default:
        _connectionStatus = 'Failed to get connectivity.';
        break;
    }
  }

  bool hasInternetConnection(){
    if (_connectionStatus == ConnectivityResult.wifi.toString() ||
        _connectionStatus == ConnectivityResult.mobile.toString()) {

      // Do an async recheck for next time
      initConnectivity();

      return true;
    } else {
      // Do an async recheck for next time
      initConnectivity();
      return false;
    }
  }

}
