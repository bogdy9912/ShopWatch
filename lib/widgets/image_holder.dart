import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageHolder extends StatefulWidget {
  final _isEdit;
  final Function(File pickedImage) _imagePickFn;

  ImageHolder(this._isEdit, this._imagePickFn);
  @override
  _ImageHolderState createState() => _ImageHolderState();
}

class _ImageHolderState extends State<ImageHolder> {
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
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                spreadRadius: 1,
                offset: Offset(0, 3)),
          ]),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10,
          ),
          Text(
            widget._isEdit
                ? 'Image uploaded'
                : _pickedImage == null ? 'Upload image' : 'Image uploaded',
            style: TextStyle(
              color: widget._isEdit
                  ? Colors.teal
                  : _pickedImage == null ? Colors.black : Colors.teal,
              fontWeight: widget._isEdit
                  ? FontWeight.bold
                  : _pickedImage == null ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          Spacer(),
          widget._isEdit
              ? IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: _pickImage,
                )
              : _pickedImage == null
                  ? SizedBox()
                  : IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: _pickImage,
                    ),
          IconButton(
            icon: Icon(widget._isEdit
                ? Icons.check
                : _pickedImage == null ? Icons.file_upload : Icons.check),
            color: widget._isEdit
                ? Colors.teal
                : _pickedImage == null ? Colors.black : Colors.teal,
            onPressed: _pickedImage == null ? _pickImage : () {},
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
