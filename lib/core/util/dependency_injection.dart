import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery/features/gallery_view/data/datasource/image_datasource.dart';
import 'package:image_gallery/features/gallery_view/data/repositories/image_repository_impl.dart';
import 'package:image_gallery/features/gallery_view/domain/repositories/image_repository.dart';
import 'package:image_gallery/features/gallery_view/domain/usecases/image_usecase.dart';
import 'package:image_gallery/features/gallery_view/presentation/controller/image_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put(http.Client());
    Get.put<ImageDatasource>(ImageDatasourceImpl());
    Get.put<ImageRepository>(ImageRepositoryImpl());
    Get.put<ImageUsecase>(ImageUsecase());
    Get.put<ImageController>(ImageController());
  }
}
