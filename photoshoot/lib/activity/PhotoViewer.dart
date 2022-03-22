import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatefulWidget{

  var photoURL, photoID, accessToken;

  PhotoViewer(this.photoURL, this.photoID, this.accessToken, {Key? key}) : super(key: key);

  @override
  State<PhotoViewer> createState() => PhotoViewerState();
}

class PhotoViewerState extends State<PhotoViewer>{

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('call');
            },
            icon: const Icon(Icons.favorite_border_outlined),
          ),
          IconButton(
            onPressed: () {
              print('more');
            },
            icon: const Icon(Icons.download_sharp),
          ),
          IconButton(
            onPressed: () {
              print('more');
            },
            icon: const Icon(Icons.share_sharp),
          ),
          IconButton(
            onPressed: () {
              print('more');
            },
            icon: const Icon(Icons.play_circle_outline_sharp),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: PhotoView(
        imageProvider: NetworkImage(widget.photoURL),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2,
        enableRotation: true,
        backgroundDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
      ),
    );
  }
}