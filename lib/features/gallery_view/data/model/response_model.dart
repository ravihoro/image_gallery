import 'package:image_gallery/features/gallery_view/data/model/image_model.dart';
import 'package:image_gallery/features/gallery_view/domain/entities/response_entity.dart';

class ResponseModel extends ResponseEntity {
  const ResponseModel({
    required super.total,
    required super.totalHits,
    required super.images,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        total: json["total"],
        totalHits: json["totalHits"],
        images: List<ImageModel>.from(
          json["hits"].map(
            (x) => ImageModel.fromJson(x),
          ),
        ),
      );
}
