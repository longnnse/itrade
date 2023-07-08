import 'package:flutter/foundation.dart';
import 'package:i_trade/src/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  static late SharedPreferences prefs;

  static innitAppSetting() async {
    prefs = await SharedPreferences.getInstance();
  }

  ///get dynamic
  static T getValue<T>(KeyAppSetting key) {
    try {
      return prefs.get(key.toString()) as T;
    } catch (error) {
      rethrow;
    }
  }

  ///set dynamic
  static setValue<T>(KeyAppSetting key, dynamic value) {
    try {
      if (value != null) {
        switch (T) {
          case int:
            prefs.setInt(key.toString(), value);
            break;
          case String:
            prefs.setString(key.toString(), value);
            break;
          case double:
            prefs.setDouble(key.toString(), value);
            break;
          case bool:
            prefs.setBool(key.toString(), value);
            break;
          default:
            prefs.setString(key.toString(), value);
            break;
        }
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> saveSharePrefByUser(UserEntity userModel, String accessToken) async {
    try {
      clearAllSharePref();
      await Future.delayed(const Duration(milliseconds: 100));

      AppSettings.setValue<String>(
          KeyAppSetting.userId, userModel.userId ?? "");
      AppSettings.setValue<String>(
          KeyAppSetting.email, userModel.email ?? "");
      AppSettings.setValue<String>(
          KeyAppSetting.fullName, userModel.fullName ?? "");
      AppSettings.setValue<String>(
          KeyAppSetting.userName, userModel.userName ?? "");
      AppSettings.setValue<String>(
          KeyAppSetting.phoneNumber, userModel.phoneNumber ?? "");
      AppSettings.setValue<String>(
          KeyAppSetting.token, accessToken ?? "");
      AppSettings.setValue<int>(
          KeyAppSetting.exp, userModel.exp ?? 0);
      AppSettings.setValue<String>(
          KeyAppSetting.iss, userModel.iss ?? "");
      AppSettings.setValue<String>(
          KeyAppSetting.aud, userModel.aud ?? "");
      AppSettings.setValue<bool>(
          KeyAppSetting.isDangNhap, true);
    } catch (e) {
      if (kDebugMode) {
        print("Lỗi saveSharePref: $e");
      }
    }
  }

  static void clearAllSharePref() {
    setValue<String>(KeyAppSetting.userId, "");
    setValue<String>(KeyAppSetting.email, "");
    setValue<String>(KeyAppSetting.fullName, "");
    setValue<String>(KeyAppSetting.userName, "");
    setValue<String>(KeyAppSetting.phoneNumber, "");
    setValue<String>(KeyAppSetting.token, "");
    setValue<int>(KeyAppSetting.exp, 0);
    setValue<String>(KeyAppSetting.iss, "");
    setValue<String>(KeyAppSetting.aud, "");
    setValue<bool>(KeyAppSetting.isDangNhap, false);
  }
}

enum KeyAppSetting {
  /// type: String
  userId,

  /// type: String
  email,

  /// type: String
  fullName,

  /// type: String
  userName,

  /// type: String
  phoneNumber,

  /// type: int
  exp,

  /// type: String
  iss,

  /// type: String
  aud,

  /// type: String
  urlImage,

  /// type: String
  token,

  /// type: bool
  isDangNhap,

  /// type: bool
  isDangXuat,

  /// type: int
  /// Khi tăng số lên sẽ thực hiện tự đăng xuất với update version
  /// intVersionDangXuat = 1
  intVersionDangXuat
}
