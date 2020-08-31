import 'package:flutter/material.dart';
import 'package:shop_watch/size_config.dart';
import 'package:shop_watch/widgets/image_splash_holder.dart';

enum WatchGender { man, women, universal }
enum Bracelet { leather, steel }
enum WatchType { mechanical, automatic }

class AddProductForm extends StatefulWidget {
  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  dynamic gender;
  dynamic typeW;
  dynamic bracelet;
  // dynamic option;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'E.g. Daytona',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 2, color: Colors.teal),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.teal)),
                  border: OutlineInputBorder(),
                ),
                autocorrect: true,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Brand',
                  hintText: 'E.g. Rolex',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 2, color: Colors.teal),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.teal)),
                  border: OutlineInputBorder(),
                ),
                autocorrect: true,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                  hintText: 'Enter the amount in \$',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 2, color: Colors.teal),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.teal)),
                  border: OutlineInputBorder(),
                ),
                autocorrect: true,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 2, color: Colors.teal),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.teal)),
                  border: OutlineInputBorder(),
                ),
                autocorrect: true,
                textCapitalization: TextCapitalization.words,
              ),
              Text(
                'Images:',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageSplashHolder(),
                  ImageSplashHolder(),
                  ImageSplashHolder(),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Gender: ',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildChooseOption(gender, 'Gender', 'Men', WatchGender.man),
                  buildChooseOption(
                      gender, 'Gender', 'Women', WatchGender.women),
                  buildChooseOption(
                      gender, 'Gender', 'Universal', WatchGender.universal),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Type',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildChooseOption(
                      typeW, 'Type', 'Automatic', WatchType.automatic),
                  buildChooseOption(
                      typeW, 'Type', 'Mechanical', WatchType.mechanical),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Bracelet',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildChooseOption(
                      bracelet, 'Bracelet', 'Lether', Bracelet.leather),
                  buildChooseOption(
                      bracelet, 'Bracelet', 'Steel', Bracelet.steel),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Quantity',
                style: TextStyle(fontSize: 20),
              ),
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
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          border: Border(
            bottom: option == watchOption
                ? BorderSide(width: 2, color: Colors.blue)
                : BorderSide.none,
          ),
        ),
        child: Text(
          type,
          style: TextStyle(
            color: option == watchOption ? Colors.blue : Colors.black,
            fontWeight:
                option == watchOption ? FontWeight.bold : FontWeight.normal,
            fontSize: option == watchOption ? 20 : 15,
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
          else
            bracelet = watchOption;
        });
      },
    );
  }
}
