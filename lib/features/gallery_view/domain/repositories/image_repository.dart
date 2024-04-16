import 'package:dartz/dartz.dart';
import 'package:image_gallery/core/error/failure.dart';
import 'package:image_gallery/features/gallery_view/domain/entities/image_entity.dart';

abstract class ImageRepository {
  Future<Either<Failure, List<ImageEntity>>> fetchImages(int page);
}
