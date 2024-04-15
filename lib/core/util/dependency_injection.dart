import 'package:get/get.dart';
import 'package:image_gallery/controllers/image_controller.dart';
import 'package:image_gallery/core/util/http_service.dart';
import 'package:http/http.dart' as http;

class DependencyInjection {
  static void init() {
    Get.put(http.Client());
    final HttpService httpService = HttpService();
    Get.put(httpService);
    Get.put(ImageController());
  }
}
