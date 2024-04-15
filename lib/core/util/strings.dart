import 'package:flutter_dotenv/flutter_dotenv.dart';

class StringConstants {
  static String url = "https://pixabay.com/api/";
  static String key = dotenv.get("key");
  static String imageType = "all";
}
