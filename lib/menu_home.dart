import 'package:flutter/material.dart';

import 'manager/base_info_manager.dart';
import 'service_loactor.dart';

List<Color> menuBackgroundColor = [Color(0xff335bd5), Color(0xff3d68f3)];
Duration animationDuration = Duration(milliseconds: 250);

class MenuHome extends StatefulWidget {
  @override
  _MenuHomeState createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: animationDuration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    sl<BaseInfomanager>().toggleMenu.listen((show) {
      if (show) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    // final screenHeight = size.height;
    final screenWidth = size.width;
    return StreamBuilder<bool>(
        stream: sl<BaseInfomanager>().toggleMenu,
        initialData: false,
        builder: (context, snapshot) {
          print(snapshot.data);
          return AnimatedPositioned(
            top: 0,
            left: snapshot.data ? 0.6 * screenWidth : 0,
            width: screenWidth,
            bottom: 0,
            duration: animationDuration,
            curve: Curves.easeOutSine,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Material(
                elevation: 0,
                animationDuration: animationDuration,
                borderRadius: snapshot.data
                    ? BorderRadius.all(Radius.elliptical(25, 35))
                    : null,
                // clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  overflow: Overflow.visible,
                  fit: StackFit.expand,
                  children: <Widget>[
                    HomeBottom(),
                    HomeTop(),
                  ],
                ),
              ),
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
                        child: InkWell(
                          child: Icon(
                            Icons.close,
                            size: 35.0,
                            color: Colors.white,
                          ),
                          onTap: () {
                            sl<BaseInfomanager>().toggleMenu();
                          },
                        ),
                      ),
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

class HomeTop extends StatefulWidget {
  @override
  _HomeTopState createState() => _HomeTopState();
}

class _HomeTopState extends State<HomeTop> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    print(sl<BaseInfomanager>().homeIndex);
    return AnimatedPositioned(
      top: sl<BaseInfomanager>().homeIndex == 1
          ? screenHeight * 0.15
          : screenHeight * 0.8,
      height: screenHeight,
      left: -1,
      right: 0,
      duration: animationDuration,
      curve: Curves.easeInBack,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff335bd5),
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 40,
              width: 200,
              child: GestureDetector(
                onTap: () {
                  sl<BaseInfomanager>().setHomePart(1);
                  setState(() {
                  });
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.remove, color: Colors.white),
                      Icon(Icons.remove, color: Colors.white),
                      Icon(Icons.remove, color: Colors.white),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Icon(Icons.dashboard, color: Colors.blue, size: 35),
                  onTap: () {
                    sl<BaseInfomanager>().toggleMenu();
                  },
                ),
                Icon(Icons.search, color: Colors.grey, size: 35),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('This is the center page'),
            ),
          ),
        ],
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
