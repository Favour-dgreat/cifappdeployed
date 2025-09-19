import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _passwordsignin = prefs?.getString('ff_passwordsignin') ?? _passwordsignin;
    });
    _safeInit(() {
      _FullName = prefs?.getString('ff_FullName') ?? _FullName;
    });
    _safeInit(() {
      _emailaddress = prefs?.getString('ff_emailaddress') ?? _emailaddress;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  SharedPreferences? prefs;

  String _passwordsignin = '';
  String get passwordsignin => _passwordsignin;
  set passwordsignin(String value) {
    _passwordsignin = value;
    prefs?.setString('ff_passwordsignin', value);
  }

  String _FullName = '';
  String get FullName => _FullName;
  set FullName(String value) {
    _FullName = value;
    prefs?.setString('ff_FullName', value);
  }

  String _emailaddress = '';
  String get emailaddress => _emailaddress;
  set emailaddress(String value) {
    _emailaddress = value;
    prefs?.setString('ff_emailaddress', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
