import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PromoCodeScreen extends StatefulWidget {
  @override
  _PromoCodeScreenState createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String firstValue = '0201201';

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Promo Code"),
          centerTitle: true,
        ),
        body: ListView(children: <Widget>[
          Container(
              padding: EdgeInsets.all(20),
              decoration: new BoxDecoration(
                //new Color.fromRGBO(255, 0, 0, 0.0),
                borderRadius: new BorderRadius.all(Radius.circular(50)),
              ),
              child: Column(
                children: <Widget>[
                  Card(
                    child: Form(
                      key: _formKey,
                      child: Container(
                          margin: const EdgeInsets.only(right: 20, left: 20),
                          padding: EdgeInsets.only(bottom: 20, top: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue)),
                                labelText: 'Promo Code',
                                filled: true,
                                hintText: "12121",
                                fillColor: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter a valid promo code';
                              }
                            },
                            onSaved: (String value) {
                              firstValue = value;
                            },
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  ScopedModelDescendant<MainModel>(builder:
                      (BuildContext context, Widget child, MainModel model) {
                    return SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: RaisedButton(
                        child: Text(
                          'Save',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        onPressed: () {
                          _submitForm();
                        },
                        color: Theme.of(context).backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    );
                  }),
                ],
              ))
        ],)

    );
  }
}
