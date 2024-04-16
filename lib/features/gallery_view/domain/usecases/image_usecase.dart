import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:image_gallery/core/error/failure.dart';
import 'package:image_gallery/features/gallery_view/domain/entities/image_entity.dart';
import 'package:image_gallery/features/gallery_view/domain/repositories/image_repository.dart';

class ImageUsecase {
  final ImageRepository repository = Get.find<ImageRepository>();

  Future<Either<Failure, List<ImageEntity>>> fetchImages(int page) async {
    return await repository.fetchImages(page);
  }
}
