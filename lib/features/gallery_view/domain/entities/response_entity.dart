import 'package:equatable/equatable.dart';
import 'package:image_gallery/features/gallery_view/domain/entities/image_entity.dart';

class ResponseEntity extends Equatable {
  final int total;
  final int totalHits;
  final List<ImageEntity> images;

  const ResponseEntity({
    required this.total,
    required this.totalHits,
    required this.images,
  });

  @override
  List<Object?> get props => [
        total,
        totalHits,
        images,
      ];
}
