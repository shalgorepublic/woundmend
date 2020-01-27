import 'package:derm_pro/Home_screens/Library.dart';
import 'package:derm_pro/Home_screens/inbox_page.dart';
import 'package:derm_pro/Home_screens/drawer_class.dart';
import 'package:derm_pro/Home_screens/setting/setting_screen.dart';
import 'package:flutter/material.dart';

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
        'assets/dashboard.png',
      ),
      new MenuItem(
        "Library",
        'assets/dashboard.png',
      ),
      new MenuItem(
        "Inbox",
        'assets/dashboard.png',
      ),
      new MenuItem(
        "Settings",
        'assets/dashboard.png',
      ),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(color: Colors.white,
        child:Column(children: <Widget>[
          Container(width:MediaQuery.of(context).size.width,color:Theme.of(context).backgroundColor,height:100,child: Text("helo"),),
          Expanded(child:  ListView.builder(
            padding: EdgeInsets.all(0.0),
            itemCount: _menuItems.length,
            itemBuilder: (context, index) {
              return Container(
                color: _currentSelected == index
                    ? Colors.grey

                    : Colors.white,
                child: ListTile(
                  leading: new Image.asset('${_menuItems[index].iconName}'),
                  title: Text(
                    _menuItems[index].title,
                    style: TextStyle(
                        color: _currentSelected == index
                            ? Theme.of(context).backgroundColor
                            : Colors.black,fontSize: 16),
                  ),
                  onTap: () {
                    setState(() {
                      _currentSelected = index;
                      if (_currentSelected == 0) {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/profilePage');
                      }
                      if (_currentSelected == 1) {
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => LibraryScreen()));
                      }
                      if (_currentSelected == 2) {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/inboxScreen');
                      }
                      if (_currentSelected == 3) {
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => SettingScreen()));
                      }
                    });
                  },
                ),
              );
            },
          ),)

        ],)

      ),
    );
  }
}
