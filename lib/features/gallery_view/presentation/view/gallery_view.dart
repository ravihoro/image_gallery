import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:image_gallery/features/gallery_view/presentation/controller/image_controller.dart';
import 'package:image_gallery/features/gallery_view/presentation/view/image_view.dart';

import 'package:image_gallery/features/gallery_view/presentation/widgets/image_container_preview.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  final ImageController imageController = Get.find<ImageController>();
  final ScrollController _scrollController = ScrollController();
  double minItemWidth = 120.0;

  @override
  void initState() {
    super.initState();
    imageController.fetchImages();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      imageController.fetchImages();
    }
  }

  int _getColumnsCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      minItemWidth = 120;
      return 2;
    } else {
      minItemWidth = 300;
      return (screenWidth / minItemWidth).floor();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Gallery"),
      ),
      body: Obx(
        () {
          final isLoading = imageController.isLoading.value;
          final showBottomLoader = imageController.showBottomLoader.value;
          final images = imageController.images;
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                images.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text('Failed to load images'),
                        ),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MasonryGridView.count(
                            controller: _scrollController,
                            crossAxisCount: _getColumnsCount(context),
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            itemCount: images.length,
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              var image = images[index];

                              return ImageContainerPreview(
                                image: image,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ImageView(
                                        image: image,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                showBottomLoader
                    ? const CircularProgressIndicator()
                    : Container(),
              ],
            );
          }
        },
      ),
    );
  }
}
