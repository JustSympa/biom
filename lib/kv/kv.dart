import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _KVNames {
  static const String defaultKey = "default";
  static const String skipInstructions = "settings.skipInstructions";
  static const String language = "settings.language";
  static const String refreshToken = "user.refToken";
}

class _KVS {
  late SharedPreferences provider;
  _KVS();
  Future<void> init() async {
    provider = await SharedPreferences.getInstance();
    final defaultConfig = provider.getBool(_KVNames.defaultKey);
    if(defaultConfig == null || defaultConfig == false) {
      provider.setBool(_KVNames.defaultKey, true);
      provider.setBool(_KVNames.skipInstructions, false);
      provider.setString(_KVNames.language, WidgetsBinding.instance.platformDispatcher.locale.languageCode.substring(0, 2));
    }
  }

  String get language => provider.getString(_KVNames.language) ?? '';
  set language(String language) => provider.setString(_KVNames.language, language);
  bool get skipInstructions => provider.getBool(_KVNames.skipInstructions) ?? false;
  set skipInstructions(bool skip) => provider.setBool(_KVNames.skipInstructions, skip);
  bool get hasUser => provider.getString(_KVNames.refreshToken) != null;
  String? get refreshToken => provider.getString(_KVNames.refreshToken);
  set refreshToken(String refreshToken) => provider.setString(_KVNames.refreshToken, refreshToken);
}

// ignore: non_constant_identifier_names
final KVS = _KVS();