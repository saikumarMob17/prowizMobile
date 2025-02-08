import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prowiz/utils/strings.dart';

class StorageUtils {
  static final GetStorage storageBox = GetStorage();

  static String getAccessToken() {
    String? accessToken = storageBox.read(Constants.accessToken);

    if (accessToken == null) throw Exception("Access toke is not available");

    return accessToken;
  }

  static String email() {
    String? email = storageBox.read(Constants.email);

    if (email == null) throw Exception("Email is not available");
    return email;
  }

  static bool getLoggedIn() {
    bool isLoggedIn = storageBox.read(Constants.isLoggedIn) ?? false;

    return isLoggedIn;
  }


  static bool loginType() {

    bool isLoggedInType = storageBox.read(Constants.loginType) ?? false;

    return isLoggedInType;

  }
}
