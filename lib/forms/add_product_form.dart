import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shop_watch/functions.dart';
import 'package:shop_watch/screens/user_products_screen.dart';
import 'package:shop_watch/size_config.dart';
import 'package:shop_watch/widgets/image_holder.dart';
import 'package:shop_watch/widgets/image_splash_holder.dart';
import 'package:shop_watch/widgets/quantity_widget_form.dart';

enum WatchGender { man, women, universal }
enum Bracelet { leather, steel }
enum WatchType { mechanical, automatic }

class AddProductForm extends StatefulWidget {
  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  String gender = 'Universal';
  String typeW = 'Automatic';
  String bracelet = 'Steel';
  bool isNew = true;
  bool isDiscounted = false;
  String brand = '';
  String name = '';
  String price = '';
  String description = '';
  String discountedProcent = '';
  String quantity = '';
  final _formKey = GlobalKey<FormState>();
  var _isInit = true;
  File _pickedImage;
  var isEdit = false;
  var id;
  var imgUrl;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      final arg =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      isEdit = true;
      if (arg != null) {
        brand = arg['brand'];
        name = arg['name'];
        price = arg['price'];
        description = arg['description'];
        gender = arg['gender'];
        typeW = arg['type'];
        bracelet = arg['bracelet'];
        isNew = arg['isNew'];
        isDiscounted = arg['isDiscounted'];
        id = arg['id'];
        imgUrl = arg['image'];
      } else {}
      _isInit = false;
    }
  }

  void _submitForm() async {
    print(brand);
    final valid = _formKey.currentState.validate();
    if (!valid) return;
    _formKey.currentState.save();

    FocusScope.of(context).unfocus();

    try {
      final User user = FirebaseAuth.instance.currentUser;
      final uid = user.uid;
      final docRef = isEdit
          ? FirebaseFirestore.instance.collection('watches').doc(id)
          : FirebaseFirestore.instance.collection('watches').doc();
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('$uid')
          .child('${docRef.id}' + '.jpeg');
      await ref.putFile(_pickedImage).onComplete;
      final url = await ref.getDownloadURL();
      await docRef.set({
        'id': docRef.id,
        'creatorId': uid,
        'brand': brand.trim(),
        'name': name.trim(),
        'price': price,
        'description': description.trim(),
        'isNew': isNew,
        'isDiscounted': isDiscounted,
        'image': url,
        'quantity': quantity,
        'gender': gender,
        'type': typeW,
        'bracelet': bracelet,
      });

      Navigator.of(context).pushReplacementNamed(UserProducts.routeName);
    } catch (err) {
      print(err);
    }
    //  Navigator.of(context).pop();
  }

  final _nameFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  //File _pickedImage2;
  //File _pickedImage3;

  void setQuantity(String quant) {
    quantity = quant;
  }

  void _pickedImageFn(File image) {
    _pickedImage = image;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameFocusNode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: brand,
                decoration: InputDecoration(
                  labelText: 'Brand',
                  hintText: 'E.g. ROLEX',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 2, color: Colors.teal),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) {
                  if (value.isEmpty) return 'Enter a brand';
                  return null;
                },
                autocorrect: true,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_nameFocusNode);
                },
                onSaved: (newValue) {
                  brand = newValue;
                  //  print(newValue);
                  //  print(brand);
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(
                  labelText: 'Model',
                  hintText: 'E.g. Daytona',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 2, color: Colors.teal),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey)),
                  border: OutlineInputBorder(),
                ),
                autocorrect: true,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                focusNode: _nameFocusNode,
                validator: (value) {
                  if (value.isEmpty) return 'Enter a model';
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (newValue) {
                  name = newValue;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: price,
                decoration: InputDecoration(
                  labelText: 'Price',
                  hintText: 'Enter the amount in \$',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 2, color: Colors.teal),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey)),
                  border: OutlineInputBorder(),
                ),
                autocorrect: true,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                validator: (value) {
                  if (value.isEmpty) return 'Enter a price';
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (newValue) {
                  price = newValue;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(
                  labelText: 'Description',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 2, color: Colors.teal),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey)),
                  border: OutlineInputBorder(),
                ),
                autocorrect: true,
                textCapitalization: TextCapitalization.sentences,
                focusNode: _descriptionFocusNode,
                maxLines: 3,
                validator: (value) {
                  if (value.isEmpty) return 'Enter a description';
                  return null;
                },
                onSaved: (newValue) {
                  description = newValue;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Images',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              ImageHolder(_pickedImageFn),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //   ImageSplashHolder(_pickedImageFn),
                  //   ImageSplashHolder(_pickedImageFn),
                  //   ImageSplashHolder(_pickedImageFn),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Gender ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildChooseOption(gender, 'Gender', 'Men', 'Men'),
                  buildChooseOption(gender, 'Gender', 'Women', 'Women'),
                  buildChooseOption(gender, 'Gender', 'Universal', 'Universal'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Type',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildChooseOption(typeW, 'Type', 'Automatic', 'Automatic'),
                  buildChooseOption(typeW, 'Type', 'Mechanical', 'Mechanical'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Bracelet',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildChooseOption(bracelet, 'Bracelet', 'Lether', 'Lether'),
                  buildChooseOption(bracelet, 'Bracelet', 'Steel', 'Steel'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quantity',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      height: 50,
                      width: 150,
                      child: QuantityWidgetForm(setQuantity)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Is new?',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildChooseOption(isNew, 'isNew', 'Yes', true),
                  buildChooseOption(isNew, 'isNew', 'No', false),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Is discounted?',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildChooseOption(isDiscounted, 'isDiscounted', 'Yes', true),
                  buildChooseOption(isDiscounted, 'isDiscounted', 'No', false),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: FlatButton(
                  onPressed: _submitForm,
                  child: Container(
                    width: 150,
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  color: Colors.blue[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildChooseOption(
      dynamic option, String category, String type, dynamic watchOption) {
    return GestureDetector(
      child: AnimatedContainer(
        width: (SizeConfig.screenWidth - 20) * 0.3,
        height: SizeConfig.screenHeight * 0.04,
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: option == watchOption ? Colors.teal : Colors.transparent,
          ),
        ),
        child: FittedBox(
          child: Text(
            type,
            style: TextStyle(
              color: option == watchOption ? Colors.teal : Colors.black,
              fontWeight:
                  option == watchOption ? FontWeight.bold : FontWeight.normal,
              fontSize: option == watchOption ? 20 : 15,
            ),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          option = watchOption;
          if (category == 'Gender')
            gender = watchOption;
          else if (category == 'Type')
            typeW = watchOption;
          else if (category == 'Bracelet')
            bracelet = watchOption;
          else if (category == 'isNew')
            isNew = watchOption;
          else if (category == 'isDiscounted') isDiscounted = watchOption;
        });
      },
    );
  }
}
