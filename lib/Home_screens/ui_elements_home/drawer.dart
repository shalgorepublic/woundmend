import 'package:derm_pro/Home_screens/Library.dart';
import 'package:derm_pro/Home_screens/inbox_page.dart';
import 'package:derm_pro/Home_screens/drawer_class.dart';
import 'package:derm_pro/Home_screens/setting/setting_screen.dart';
import 'package:derm_pro/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DrawerBuilder extends StatefulWidget {
  @override
  _DrawerBuilderState createState() => _DrawerBuilderState();
}

class _DrawerBuilderState extends State<DrawerBuilder> {
  List<MenuItem> _menuItems;
  int _currentSelected = 0;

  @override
  initState() {
    super.initState();
    _menuItems = createMenuItems();
  }

  List<MenuItem> createMenuItems() {
    final menuItems = [
      new MenuItem(
        "Profile",
        'assets/user.png',
      ),
      new MenuItem(
        "Library",
        'assets/book.png',
      ),
      new MenuItem(
        "Inbox",
        'assets/mail.png',
      ),
      new MenuItem(
        "Settings",
        'assets/gear.png',
      ),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.topLeft,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).backgroundColor,
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 40, left: 20),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/bill_gate.jpg'),
                        ),
                      ),
                      ScopedModelDescendant<MainModel>(
                          builder: (context, child, model) => Container(
                                padding: EdgeInsets.only(left: 20, top: 25),
                                child: Text(
                                  'Johenmicheal@gmail.com',
                                  style: TextStyle(color: Colors.white,fontSize: 18),
                                ),
                              ))
                    ],
                  )),
              SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0.0),
                  itemCount: _menuItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: _currentSelected == index
                          ? Theme.of(context).disabledColor
                          : Colors.white,
                      child: ListTile(
                        leading:
                            new Image.asset('${_menuItems[index].iconName}'),
                        title: Text(
                          _menuItems[index].title,
                          style: TextStyle(
                              color: _currentSelected == index
                                  ? Theme.of(context).backgroundColor
                                  : Colors.black,
                              fontSize: 16),
                        ),
                        onTap: () {
                          setState(() {
                            _currentSelected = index;
                            if (_currentSelected == 0) {
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(
                                  context, '/profilePage');
                            }
                            if (_currentSelected == 1) {
                              Navigator.pop(context);
                              Navigator.of(context).push(
                                  MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          LibraryScreen()));
                            }
                            if (_currentSelected == 2) {
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(
                                  context, '/inboxScreen');
                            }
                            if (_currentSelected == 3) {
                              Navigator.pop(context);
                              Navigator.of(context).push(
                                  MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          SettingScreen()));
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}
