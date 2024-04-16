import 'package:get/get.dart';
import 'package:image_gallery/features/gallery_view/domain/entities/image_entity.dart';
import 'package:image_gallery/features/gallery_view/domain/usecases/image_usecase.dart';

class ImageController extends GetxController {
  final ImageUsecase usecase = Get.find<ImageUsecase>();

  var isLoading = false.obs;

  var showBottomLoader = false.obs;

  RxInt currentPage = 1.obs;

  List<ImageEntity> images = <ImageEntity>[].obs;

  void setIsLoading(bool value) {
    if (currentPage.value == 1) {
      isLoading.value = value;
    } else {
      showBottomLoader.value = value;
    }
  }

  void fetchImages() async {
    setIsLoading(true);
    await usecase.fetchImages(currentPage.value).then(
          (either) => either.fold(
            (l) {
              setIsLoading(false);
              Get.snackbar(
                "Error",
                l.errorMessage,
                snackPosition: SnackPosition.BOTTOM,
              );
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
