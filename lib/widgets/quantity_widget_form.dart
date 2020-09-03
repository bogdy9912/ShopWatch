import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_watch/size_config.dart';

class QuantityWidgetForm extends StatefulWidget {
  final Function setQuantity;

  QuantityWidgetForm(this.setQuantity);
  @override
  _QuantityWidgetFormState createState() => _QuantityWidgetFormState();
}

class _QuantityWidgetFormState extends State<QuantityWidgetForm> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        child: Row(
          children: [
            Stack(alignment: AlignmentDirectional.center, children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300]),
              ),
              IconButton(
                iconSize: 20,
                icon: Icon(Icons.remove),
                onPressed: () {
                  int currentValue = int.parse(_controller.text);
                  setState(() {
                    currentValue--;
                    _controller.text = (currentValue > 1 ? currentValue : 1)
                        .toString(); // decrementing value
                  });
                  widget.setQuantity(_controller.text);
                },
              ),
            ]),
            SizedBox(
              width: 40,
              child: TextFormField(
                autovalidate: true,
                validator: (value) {
                  if (int.parse(value) < 1) {
                    return 'To low';
                  }
                  return null;
                },
                decoration: InputDecoration(border: InputBorder.none),
                textAlign: TextAlign.center,
                controller: _controller,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
                onTap: () {
                  _controller.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _controller.value.text.length);
                },
              ),
            ),
            Stack(alignment: AlignmentDirectional.center, children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300]),
              ),
              IconButton(
                  iconSize: 20,
                  icon: Icon(
                    Icons.add,
                  ),
                  onPressed: () {
                    int currentValue = int.parse(_controller.text);
                    setState(() {
                      currentValue++;
                      _controller.text =
                          (currentValue).toString(); // decrementing value
                    });
                    widget.setQuantity(_controller.text);
                  }),
            ]),
          ],
        ),
      ),
    );
  }
}
