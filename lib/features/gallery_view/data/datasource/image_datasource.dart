import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery/core/error/exception.dart';
import 'package:image_gallery/core/util/strings.dart';
import 'package:image_gallery/features/gallery_view/data/model/response_model.dart';
import 'package:image_gallery/features/gallery_view/domain/entities/image_entity.dart';

abstract class ImageDatasource {
  Future<List<ImageEntity>> fetchImages(int page);
}

class ImageDatasourceImpl implements ImageDatasource {
  final http.Client httpClient = Get.find<http.Client>();

  @override
  Future<List<ImageEntity>> fetchImages(int page) async {
    final http.Response response = await httpClient.get(
      Uri.parse(
        "${StringConstants.url}?key=${StringConstants.key}&image_type=${StringConstants.imageType}&per_page=20&page=$page",
      ),
    );
    if (response.statusCode == 200) {
      var model = ResponseModel.fromJson(jsonDecode(response.body));
      return model.images;
    } else {
      throw ServerException();
    }
  }
}
