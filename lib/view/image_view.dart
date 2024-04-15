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
          children: [
            Hero(
              tag: image.id,
              child: CachedNetworkImage(
                imageUrl: image.largeImageUrl,
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
    );
  }
}
