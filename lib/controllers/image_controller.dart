import 'package:get/get.dart';
import 'package:image_gallery/core/util/http_service.dart';
import 'package:image_gallery/model/image_model.dart';

class ImageController extends GetxController {
  final HttpService httpService = Get.find();

  var isLoading = false.obs;

  var showBottomLoader = false.obs;

  RxInt currentPage = 1.obs;

  List<Hit> images = <Hit>[].obs;

  void setIsLoading(bool value) {
    if (currentPage.value == 1) {
      isLoading.value = value;
    } else {
      showBottomLoader.value = value;
    }
  }

  void fetchImages() async {
    setIsLoading(true);
    await httpService.getImages(page: currentPage.value).then(
          (either) => either.fold(
            (l) {
              setIsLoading(false);
              Get.snackbar("Error", l.errorMessage);
            },
            (r) {
              setIsLoading(false);
              images.addAll(r);
              currentPage.value++;
            },
          ),
        );
  }
}
