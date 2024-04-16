import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:image_gallery/core/error/exception.dart';
import 'package:image_gallery/core/error/failure.dart';
import 'package:image_gallery/features/gallery_view/data/datasource/image_datasource.dart';
import 'package:image_gallery/features/gallery_view/domain/entities/image_entity.dart';
import 'package:image_gallery/features/gallery_view/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageDatasource datasource = Get.find<ImageDatasource>();

  @override
  Future<Either<Failure, List<ImageEntity>>> fetchImages(int page) async {
    try {
      var images = await datasource.fetchImages(page);
      return Right(images);
    } on ServerException {
      return const Left(ServerFailure());
    } catch (e) {
      return const Left(GenericFailure());
    }
  }
}
