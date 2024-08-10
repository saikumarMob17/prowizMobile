import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageUtils {
  static final GetStorage storageBox = GetStorage();

  static String getAccessToken() {
    String? accessToken = storageBox.read("accessToken");

    if (accessToken == null) throw Exception("Access toke is not available");

    return accessToken;
  }
}
