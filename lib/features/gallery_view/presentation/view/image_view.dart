import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery/features/gallery_view/domain/entities/image_entity.dart';

class ImageView extends StatelessWidget {
  final ImageEntity image;

  const ImageView({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          //color: Colors.blue,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                //color: Colors.red,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: image.largeImageUrl,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Hero(
                tag: image.id,
                child: CachedNetworkImage(
                  imageUrl: image.largeImageUrl,
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
