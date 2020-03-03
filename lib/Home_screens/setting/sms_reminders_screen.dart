import 'package:derm_pro/Home_screens/setting/ui_elements/switch_button.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class SmsReminderScreen extends StatefulWidget {
  @override
  _SmsReminderScreenState createState() => _SmsReminderScreenState();
}

class _SmsReminderScreenState extends State<SmsReminderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String codeHint = 'Pakistan +92';
  bool buttonFlag = false;
  String phoneNumber = '03124202873';

  void _submitForm() {
    _formKey.currentState.validate();
    _formKey.currentState.save();
    print(phoneNumber);
    print('Form submitted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("SMS Reminders"),
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      SwitchButton(),
                      Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () async {},
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: 10),
                                        //   margin: EdgeInsets.symmetric(horizontal: 20),
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            CountryCodePicker(
                                              onInit: (code) => print(
                                                  "${code.name} ${code.dialCode}"),
                                              showFlag: true,
                                              onChanged: print,
                                              favorite: ['+92', 'Pakistan'],
                                              showCountryOnly: false,
                                              showOnlyCountryWhenClosed: false,
                                              alignLeft: false,
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.0, color: Colors.blue),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                    ),
                                    Form(
                                        key: _formKey,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            onTap: () {
                                              setState(() {
                                                buttonFlag = true;
                                              });
                                            },
                                            decoration: const InputDecoration(
                                              hintText: "Pakistan +92",
                                              helperStyle:
                                                  TextStyle(fontSize: 10),
                                              helperText:
                                                  'You will receive a code to verify this number',
                                              labelText: 'Phone Number',
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10.0, 20.0, 20.0, 10.0),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue)),
                                            ),
                                            // ignore: missing_return
                                            validator: (String value) {
                                              if (value.trim().isEmpty) {
                                                return 'Phone Number is required!';
                                              }
                                            },
                                            onSaved: (String value) {
                                              phoneNumber = value;
                                            },
                                          ),
                                        )),
                                    buttonFlag
                                        ? RaisedButton(
                                            child: Text(
                                              "ADD NUMBER",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              _submitForm();
                                              print("helo shahid");
                                              print(phoneNumber);
                                            },
                                            color:
                                                Theme.of(context).accentColor,
                                          )
                                        : Container(),
                                  ])),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                color: Theme.of(context).hoverColor,
                child: Container(
                    child: Text(
                  "Your phone number will only be used for personal health Related notifications",
                )),
              ),
            ],
          ),
        ));
  }
}
