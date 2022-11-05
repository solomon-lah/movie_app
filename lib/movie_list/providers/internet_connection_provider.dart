import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionProvider {
  final Connectivity _connectivity = Connectivity();
  late StreamController<ConnectivityResult> streamController =
      StreamController();
  InternetConnectionProvider() {
    _connectivity.onConnectivityChanged.listen((event) {
      streamController.add(event);
    });
  }
}
