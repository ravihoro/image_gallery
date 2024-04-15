import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery/model/image_model.dart';

class ImageContainerPreview extends StatelessWidget {
  final Hit image;
  final void Function() onTap;

  const ImageContainerPreview({
    required this.image,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Hero(
          tag: image.id,
          child: CachedNetworkImage(
            fit: BoxFit.fitWidth,
            imageUrl: image.previewUrl,
            placeholder: (context, url) => Container(
              color: Colors.grey[200],
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
