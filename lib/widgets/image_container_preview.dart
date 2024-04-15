import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery/core/util/helper_functions.dart';
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
    var textStyle = const TextStyle(
      fontSize: 12,
    );
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Hero(
              tag: image.id,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: image.previewUrl,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(
              Icons.favorite_border_outlined,
              size: 12,
            ),
            const SizedBox(
              width: 1,
            ),
            Text(
              getFormattedNumber(image.likes),
              style: textStyle,
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.remove_red_eye_outlined,
              size: 12,
            ),
            const SizedBox(
              width: 1,
            ),
            Text(
              getFormattedNumber(image.views),
              style: textStyle,
            ),
          ],
        ),
      ],
    );
  }
}
