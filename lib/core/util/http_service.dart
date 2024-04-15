import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery/core/error/exception.dart';
import 'package:image_gallery/core/error/failure.dart';
import 'package:image_gallery/core/util/strings.dart';
import 'package:image_gallery/model/image_model.dart';
import 'package:dartz/dartz.dart';

class HttpService {
  final http.Client httpClient = Get.find();

  Future<Either<Failure, List<Hit>>> getImages({int page = 1}) async {
    try {
      final http.Response response = await httpClient.get(
        Uri.parse(
          "${StringConstants.url}?key=${StringConstants.key}&image_type=${StringConstants.imageType}&per_page=20&page=$page&orientation=vertical",
        ),
      );
      if (response.statusCode == 200) {
        var model = ImageModel.fromJson(jsonDecode(response.body));
        return Right(model.hits);
      } else {
        throw ServerException();
      }
    } on ServerException {
      return const Left(ServerFailure());
    } catch (e) {
      return const Left(GenericFailure());
    }
  }
}
