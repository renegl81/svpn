import 'package:flutter/foundation.dart';

class ConnectionProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String _city = '';
  String _country = '';
  String _friendlyName = '';
  bool _authenticated = false;
  bool _loading = false;

  String get city => _city;

  String get country => _country;

  String get friendlyName => _friendlyName;

  bool get authenticated => _authenticated;

  bool get loading => _loading;

  void setCity(city) {
    _city = city;
    notifyListeners();
  }

  void setCountry(country) {
    _country = country;
    notifyListeners();
  }

  void setFriendlyName(friendlyName) {
    _friendlyName = friendlyName;
    notifyListeners();
  }

  void setAuthenticated(value) {
    _authenticated = value;
    notifyListeners();
  }

  void setLoading(loading) {
    _loading = loading;
    notifyListeners();
  }

  void resetState() {
    _country = '';
    _city = '';
    _friendlyName = '';
    _authenticated = false;
    notifyListeners();
  }
}
