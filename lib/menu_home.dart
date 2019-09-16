import 'package:flutter/material.dart';

import 'manager/base_info_manager.dart';
import 'service_loactor.dart';

List<Color> menuBackgroundColor = [Color(0xff335bd5), Color(0xff3d68f3)];

class MenuHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          menu(context),
          home(context),
        ],
      ),
    );
  }

  Widget home(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    return StreamBuilder<bool>(
        stream: sl<BaseInfomanager>().toggleMenu,
        initialData: false,
        builder: (context, snapshot) {
          print(snapshot.data);
          return AnimatedPositioned(
            top: snapshot.data ? 0.1 * screenHeight : 0,
            height: snapshot.data ? 0.8 * screenHeight : screenHeight,
            left: snapshot.data ? 0.78 * screenWidth : 0,
            width: snapshot.data ? 0.8 * screenWidth : screenWidth,
            duration: Duration(milliseconds: 650),
            curve: Curves.easeOutSine,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                HomeBottom(),
                // HomeTop(),
              ],
            ),
          );
        });
  }

  Widget menu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: menuBackgroundColor,
        ),
      ),
      child: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.close,
                            size: 30.0,
                            color: Colors.white,
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Menu',
                          style: TextStyle(color: Colors.white, fontSize: 29),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 300,
                child: Column(
                  children: createMenuItems(),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> createMenuItems() => sl<BaseInfomanager>()
      .menuItems
      .map((item) => MenuItem(
            icon: item['icon'],
            text: item['text'],
          ))
      .toList();
}

class HomeTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}

class HomeBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: InkWell(
            child: Icon(Icons.dashboard, color: Colors.blue, size: 30),
            onTap: () {
              sl<BaseInfomanager>().toggleMenu();
            },
          ),
        ),
        actions: <Widget>[
          Icon(Icons.search, color: Colors.grey, size: 30),
          SizedBox(width: 20)
        ],
      ),
      body: Center(
        child: Text('This is the center page'),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const MenuItem({Key key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white),
          SizedBox(width: 22.0),
          Text(text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
