import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:image_gallery/features/gallery_view/presentation/controller/image_controller.dart';
import 'package:image_gallery/features/gallery_view/presentation/view/image_view.dart';

import 'package:image_gallery/features/gallery_view/presentation/widgets/image_container_preview.dart';

class GalleryView extends StatelessWidget {
  static const double itemAspectRatio = 1.0;

  static const double minItemWidth = 120.0;

  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final numColumns = (screenWidth / minItemWidth).floor();
    final ImageController imageController = Get.find<ImageController>();
    final ScrollController _scrollController = ScrollController();

    // Load images when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log("fetching imagesss");
      imageController.fetchImages();
    });

    void _scrollListener() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        // Reached the bottom
        imageController.fetchImages(); // Call your API here
      }
    }

    _scrollController.addListener(_scrollListener);

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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MasonryGridView.count(
                      controller: _scrollController,
                      crossAxisCount: numColumns,
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
                    // child: GridView.builder(
                    //   controller: _scrollController,
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: numColumns,
                    //     crossAxisSpacing: 5,
                    //     mainAxisSpacing: 5,
                    //     childAspectRatio: 1,
                    //   ),
                    //   itemCount: images.length,
                    //   itemBuilder: (_, index) {
                    //     var image = images[index];
                    //     return ImageContainerPreview(
                    //       image: image,
                    //       onTap: () {
                    //         Navigator.of(context).push(
                    //           MaterialPageRoute(
                    //             builder: (_) => ImageView(
                    //               image: image,
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
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
