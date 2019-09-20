import 'package:flutter/material.dart';
import 'package:headphone_store/pages/headphone_detail.dart';
import '../models/item_list.dart';

import '../manager/base_info_manager.dart';
import '../service_loactor.dart';
import 'dart:math' as math;

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
  Animation<double> _rotateAnimation;
  Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: animationDuration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _rotateAnimation = Tween<double>(begin: 0.2, end: 0).animate(_controller);
    _positionAnimation = Tween<Offset>(
            begin: Offset.fromDirection(math.pi, 1.0),
            end: Offset.fromDirection(0, 0))
        .animate(_controller);
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
                color: Colors.transparent,
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
                          child: RotationTransition(
                            turns: _rotateAnimation,
                            child: Icon(
                              Icons.close,
                              size: 35.0,
                              color: Colors.white,
                            ),
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
              SlideTransition(
                position: _positionAnimation,
                child: Container(
                  height: 300,
                  child: Column(
                    children: createMenuItems(),
                  ),
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      top: sl<BaseInfomanager>().homeIndex == 1
          ? sl<BaseInfomanager>().showMenu
              ? screenHeight * 0.18
              : screenHeight * 0.13
          : screenHeight * 0.93,
      height: screenHeight * 0.97,
      left: sl<BaseInfomanager>().showMenu ? 40 : -1,
      right: sl<BaseInfomanager>().showMenu ? -40 : 0,
      duration: animationDuration,
      curve: Curves.easeInBack,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff335bd5),
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onVerticalDragUpdate: (DragUpdateDetails detail) {
                if (sl<BaseInfomanager>().homeIndex == 1 &&
                    detail.delta.dy > 0) {
                  sl<BaseInfomanager>().setHomePart(1);
                  setState(() {});
                }
                if (sl<BaseInfomanager>().homeIndex != 1 &&
                    detail.delta.dy < 0) {
                  sl<BaseInfomanager>().setHomePart(1);
                  setState(() {});
                }
              },
              onTap: () {
                sl<BaseInfomanager>().setHomePart(1);
                setState(() {});
              },
              child: Container(
                height: 50,
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
            GestureDetector(
              onVerticalDragUpdate: (DragUpdateDetails detail) {
                if (sl<BaseInfomanager>().homeIndex == 1 &&
                    detail.delta.dy > 0) {
                  sl<BaseInfomanager>().setHomePart(1);
                  setState(() {});
                }
                if (sl<BaseInfomanager>().homeIndex != 1 &&
                    detail.delta.dy < 0) {
                  sl<BaseInfomanager>().setHomePart(1);
                  setState(() {});
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Headphones',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 35.0,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 11,
              child: PageView.builder(
                controller:
                    PageController(initialPage: 0, viewportFraction: 0.9),
                itemCount: (itemList.length / 2).round(),
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                itemBuilder: (context, index) {
                  return Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        HeadPhoneItem(itemList[2 * index]),
                        2 * index + 1 > itemList.length
                            ? null
                            : HeadPhoneItem(itemList[2 * index + 1]),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Earphones',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 35.0,
                  )
                ],
              ),
            ),
            Expanded(
                flex: 6,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) => Container(
                          width: screenWidth * 0.65,
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                ),
                                child: Image.asset(
                                  'assets/images/MUQ72.png',
                                  width: 150,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Tvory',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    '\$ 249.95',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            ],
                          ),
                        ))),
            Padding(
              padding: EdgeInsets.only(left: 12, top: 8, bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xfff8b502),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Colors.black,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.mail_outline,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.1,
            )
          ],
        ),
      ),
    );
  }
}

class HomeBottom extends StatefulWidget {
  @override
  _HomeBottomState createState() => _HomeBottomState();
}

class _HomeBottomState extends State<HomeBottom>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _rotateAnimation = Tween<double>(begin: 0, end: 0.08).animate(_controller);
    _controller.forward();
    sl<BaseInfomanager>().setHomePart.listen((index) {
      print(index);
      print('from listen');
      if (index != 0) {
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
    return AnimatedBuilder(
      animation: _controller,
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
      builder: (BuildContext context, Widget child) {
        return Transform(
          alignment: Alignment.topCenter,
          transform: Matrix4.identity() //生成一个单位矩阵
            ..setEntry(3, 2, 0.006) // 透视
            ..rotateX(sl<BaseInfomanager>().showMenu
                ? _rotateAnimation.value * 0.5
                : _rotateAnimation.value * 1.2)
            ..translate(
                0.0, sl<BaseInfomanager>().homeIndex == 0 ? 0.0 : 13.0, 0.0),
          child: SafeArea(
            child: Material(
              color: Colors.white,
              animationDuration: animationDuration,
              borderRadius: sl<BaseInfomanager>().showMenu
                  ? BorderRadius.circular(25)
                  : sl<BaseInfomanager>().homeIndex != 0
                      ? BorderRadius.circular(25)
                      : null,
              child: child,
            ),
          ),
        );
      },
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

class HeadPhoneItem extends StatelessWidget {
  final ProudctItem item;
  HeadPhoneItem(this.item);

  @override
  Widget build(BuildContext context) {
    Color _textColor =
        item.bgColor == Colors.white ? Colors.black : Colors.white;
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: ((contex){
            return HeadphoneDetail(item: item,);
          })
        ));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
              color: item.bgColor, borderRadius: BorderRadius.circular(15.0)),
          width: MediaQuery.of(context).size.width*0.4,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(item.path),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Beats Solo 3',
                      style: TextStyle(
                          color: _textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      item.colors.first,
                      style: TextStyle(
                          color: _textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$ ${item.price}',
                      style: TextStyle(
                          color: _textColor, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
