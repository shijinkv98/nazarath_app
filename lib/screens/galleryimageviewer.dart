import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
class GalleryImageViewer extends StatefulWidget {
  GalleryImageViewer({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder loadingBuilder;
  final BoxDecoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<String> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState(currentIndex: initialIndex);
  }
}
class _GalleryPhotoViewWrapperState extends State<GalleryImageViewer> {
  int currentIndex = 0;
  _GalleryPhotoViewWrapperState({this.currentIndex});
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: _buildItem,
                  itemCount: widget.galleryItems.length,
                  loadingBuilder: widget.loadingBuilder,
                  backgroundDecoration: widget.backgroundDecoration,
                  pageController: widget.pageController,
                  onPageChanged: onPageChanged,
                  scrollDirection: widget.scrollDirection,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage('$productThumbUrl$item'),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
    );
  }
  void decrementIndex() {
    currentIndex--;
    if(currentIndex<0)
      currentIndex=widget.galleryItems.length-1;
    onPageChanged(currentIndex);
  }
  void incrementIndex() {
    currentIndex++;
    if(currentIndex>widget.galleryItems.length-1)
      currentIndex=0;
    onPageChanged(currentIndex);


  }
}
