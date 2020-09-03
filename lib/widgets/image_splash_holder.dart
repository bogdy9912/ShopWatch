import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSplashHolder extends StatefulWidget {
  final Function(File pickedImage) _imagePickFn;

  ImageSplashHolder(this._imagePickFn);
  @override
  _ImageSplashHolderState createState() => _ImageSplashHolderState();
}

class _ImageSplashHolderState extends State<ImageSplashHolder> {
  File _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 150,
      maxWidth: 100,
      imageQuality: 100,
    );
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget._imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          //border: Border.all(width: 1),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                spreadRadius: 1,
                offset: Offset(0, 3)),
          ]),
      child: _pickedImage == null
          ? Center(
              child: IconButton(
              icon: Icon(Icons.add_circle_outline),
              color: Colors.grey,
              onPressed: _pickImage,
            ))
          : FittedBox(child: Image.file(_pickedImage)),
    );
  }
}
