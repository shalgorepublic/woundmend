import 'package:derm_pro/Home_screens/edit_profile.dart';
import 'package:derm_pro/Home_screens/promo_code.dart';
import 'package:derm_pro/Home_screens/setting/feed_back_screen.dart';
import 'package:derm_pro/Home_screens/setting/notification_screen.dart';
import 'package:derm_pro/Home_screens/setting/privacy_policy_web.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:braintree_payment/braintree_payment.dart';


class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {


  String clientNonce =
      "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJlNTc1Mjc3MzZiODkyZGZhYWFjOTIxZTlmYmYzNDNkMzc2ODU5NTIxYTFlZmY2MDhhODBlN2Q5OTE5NWI3YTJjfGNyZWF0ZWRfYXQ9MjAxOS0wNS0yMFQwNzoxNDoxNi4zMTg0ODg2MDArMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS9ncmFwaHFsIiwiZGF0ZSI6IjIwMTgtMDUtMDgifSwiY2hhbGxlbmdlcyI6W10sImVudmlyb25tZW50Ijoic2FuZGJveCIsImNsaWVudEFwaVVybCI6Imh0dHBzOi8vYXBpLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb206NDQzL21lcmNoYW50cy8zNDhwazljZ2YzYmd5dzJiL2NsaWVudF9hcGkiLCJhc3NldHNVcmwiOiJodHRwczovL2Fzc2V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImF1dGhVcmwiOiJodHRwczovL2F1dGgudmVubW8uc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbSIsImFuYWx5dGljcyI6eyJ1cmwiOiJodHRwczovL29yaWdpbi1hbmFseXRpY3Mtc2FuZC5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0=";

  payNow() async {
    BraintreePayment braintreePayment = new BraintreePayment();
    var data = await braintreePayment.showDropIn(
        nonce: clientNonce, amount: "2.0", enableGooglePay: true);
    print("Response of the payment $data");
  }
  Future<bool> _onBackPressed(Function logout) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Log out',style: TextStyle(fontWeight:FontWeight.bold),),
            content: Text('Are you sure you want to log out?'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  logout();
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/myHomePage', (Route<dynamic> route) => false);
                //  Navigator.of(context).pushNamedAndRemoveUntil(
                  //    '/emailPage', ModalRoute.withName("/"));
                },
              ),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  color: Theme.of(context).hoverColor,
                  child: Container(
                      child: Text(
                    "ACCOUNT SETTINGS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                GestureDetector(child:
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Personal Details")),
                ),onTap: (){
                  Navigator.of(context).push(MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => EditProfile()));
                },),
                GestureDetector(child:
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Subcription")),
                ),onTap: (){
                  payNow();
                },),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  color: Theme.of(context).hoverColor,
                  child: Container(
                      child: Text(
                    "NOTIFICATIONS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                    child: Container(child: Text("Notification Reminders")),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            NotificationScreen()));
                  },
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  color: Theme.of(context).hoverColor,
                  child: Container(
                      child: Text(
                    "HELP & SUPPORT",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                GestureDetector(child:
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("FAQ")),
                ),onTap: (){
                  Navigator.pushNamed(context, '/library');
                },),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Instructions for use")),
                ),
               /* GestureDetector(child:Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Add Promo Code")),
                ),onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              PromoCodeScreen()));
                },),*/
                GestureDetector(child:
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Privacy Policy")),
                ),onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              PrivacyPloicyWebView('https://www.skinvision.com/privacy/')));
                },),
                GestureDetector(child:
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Terms & Conditions")),
                ),onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              PrivacyPloicyWebView('https://www.skinvision.com/terms/')));
                },),
                GestureDetector(child:
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Leave Feebback")),
                ),onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              FeedBackScreen()));
                },),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 10, left: 20, bottom: 20),
                  color: Theme.of(context).hoverColor,
                ),
            ScopedModelDescendant<MainModel>(
              builder: (context, child, model) =>
              GestureDetector(child:
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Container(child: Text("Log out")),
                ),onTap: (){
                _onBackPressed(model.logout);

              },),
            )
              ],
            )));
  }
}
