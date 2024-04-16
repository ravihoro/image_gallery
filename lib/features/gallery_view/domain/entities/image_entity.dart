import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final int id;
  final String pageUrl;
  final String type;
  final String tags;
  final String previewUrl;
  final int previewWidth;
  final int previewHeight;
  final String webformatUrl;
  final int webformatWidth;
  final int webformatHeight;
  final String largeImageUrl;
  final int imageWidth;
  final int imageHeight;
  final int imageSize;
  final int views;
  final int downloads;
  final int collections;
  final int likes;
  final int comments;
  final int userId;
  final String user;
  final String userImageUrl;

  const ImageEntity({
    required this.id,
    required this.pageUrl,
    required this.type,
    required this.tags,
    required this.previewUrl,
    required this.previewWidth,
    required this.previewHeight,
    required this.webformatUrl,
    required this.webformatWidth,
    required this.webformatHeight,
    required this.largeImageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageSize,
    required this.views,
    required this.downloads,
    required this.collections,
    required this.likes,
    required this.comments,
    required this.userId,
    required this.user,
    required this.userImageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        pageUrl,
        type,
        tags,
        previewUrl,
        previewWidth,
        previewHeight,
        webformatUrl,
        webformatWidth,
        webformatHeight,
        largeImageUrl,
        imageWidth,
        imageHeight,
        imageSize,
        views,
        downloads,
        collections,
        likes,
        comments,
        userId,
        user,
        userImageUrl,
      ];
}
