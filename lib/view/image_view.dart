import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery/model/image_model.dart';

class ImageView extends StatelessWidget {
  final Hit image;

  const ImageView({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: CachedNetworkImage(
                    imageUrl: image.largeImageUrl,
                    fit: BoxFit.fitHeight,
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
          ],
        ),
      ),
    );
  }
}
