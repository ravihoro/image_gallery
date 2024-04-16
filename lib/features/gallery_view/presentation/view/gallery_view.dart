import 'dart:developer';
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
    // TODO: implement initState
    super.initState();
    imageController.fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final numColumns = (screenWidth / minItemWidth).floor();

    void _scrollListener() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        // Reached the bottom
        imageController.fetchImages(); // Call your API here
      }
    }

    _scrollController.addListener(_scrollListener);

    int _getColumnsCount(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;

      // Determine device type based on screen width
      if (screenWidth < 600) {
        // Phone
        minItemWidth = 120;
        return 2; // Adjust this according to your preference
      } else {
        minItemWidth = 300;
        return (screenWidth / minItemWidth).floor();
      }
      // else if (screenWidth < 1200) {
      //   // Tablet
      //   return 4; // Adjust this according to your preference
      // } else {
      //   // Desktop
      //   return 6; // Adjust this according to your preference
      // }
    }

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
