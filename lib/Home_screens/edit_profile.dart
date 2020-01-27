import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final double circleRadius = 150.0;
  final double circleBorderWidth = 5.0;
  int _radioValue1 = -1;
  int correctScore = 0;

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          centerTitle: true,
          title: Text("John Micheal"),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(160.0),
              child: Container(
                child: Theme(
                  data: Theme.of(context).copyWith(accentColor: Colors.blue),
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        height: 1,
                      ),
                      ContainerWithCircle()
                    ],
                  ),
                ),
              )),
        ),
        body: ListView(children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 20, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Radio(
                    focusColor: Colors.blue,
                    activeColor: Theme.of(context).accentColor,
                    value: 0,
                    groupValue: _radioValue1,
                    onChanged: _handleRadioValueChange1,
                  ),
                  new Text(
                    'Mr',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: _radioValue1 == 0
                            ? Theme.of(context).accentColor
                            : Colors.black),
                  ),
                  new Radio(
                    focusColor: Theme.of(context).accentColor,
                    value: 1,
                    groupValue: _radioValue1,
                    onChanged: _handleRadioValueChange1,
                  ),
                  new Text(
                    'Mrs',
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: _radioValue1 == 1
                            ? Theme.of(context).accentColor
                            : Colors.black),
                  ),
                ],
              )),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: RegisterForm(),
            ),
          ),
        ]));
  }
}

class ContainerWithCircle extends StatelessWidget {
  final double circleRadius = 80.0;
  final double circleBorderWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: circleRadius / circleRadius),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            //replace this Container with your Card

            height: 170.0,
          ),
        ),
        Container(
          width: circleRadius,
          height: circleRadius,
          decoration:
              ShapeDecoration(shape: CircleBorder(), color: Colors.white),
          child: Padding(
            padding: EdgeInsets.all(circleBorderWidth),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/bill_gate.jpg'))),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 50, left: 80),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            //color: Colors.white,
            padding: EdgeInsets.all(0.0),
            child: Icon(
              Icons.edit,
              color: Theme.of(context).backgroundColor,
              size: 20,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 120),
          child: Container(
              color: Theme.of(context).backgroundColor,
              child: Text(
                "Johenmicheal@gmail.com",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'First name is required!';
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Last name is required!';
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField( onSaved: (String value) {
              //  _email = value;
              },
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'DOB is required!';
                  }
                },
              ),
              Container(
                  padding: EdgeInsets.only(top: 50,bottom: 50),
                  alignment: Alignment.center,
                  child:  Column(children: <Widget>[
                       SizedBox(height: 50,width:MediaQuery.of(context).size.width,child: RaisedButton(
                          child: Text('Save my Password',style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontSize: 18),),
                          onPressed: _submit,
                          color: Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),),
                    SizedBox(height: 20,),
                    SizedBox(height:50,width:MediaQuery.of(context).size.width,child: RaisedButton(
                      child: Text('Save',style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontSize: 18),),
                      onPressed: _submit,
                      color: Theme.of(context).backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),),

                      ],)

                  ),
            ],
          ),
        ));
  }

  void _submit() {
    _formKey.currentState.validate();
    print('Form submitted');
  }
}

