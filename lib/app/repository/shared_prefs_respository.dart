import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static SharedPreferences prefs;
  static SharedPrefsRepository _instanceRespository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRespository ??= SharedPrefsRepository._();
    return _instanceRespository;
  }
}
