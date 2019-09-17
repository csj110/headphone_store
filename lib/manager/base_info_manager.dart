import 'package:flutter/material.dart';
import 'package:rx_command/rx_command.dart';

abstract class BaseInfomanager {
  List<dynamic> get menuItems;
  int get homeIndex;
  RxCommand<void, bool> toggleMenu;
  RxCommand<int, int> setHomePart;
}

class BaseInfoManagerImpl implements BaseInfomanager {
  int _homeIndex = 1;
  bool _showMenu = false;

  BaseInfoManagerImpl() {
    toggleMenu = RxCommand.createSyncNoParam(() {
      _showMenu = !_showMenu;
      return _showMenu;
    });
    setHomePart = RxCommand.createSync((int index) {
      _homeIndex = _homeIndex == index ? 0 : index;
      return _homeIndex;
    });
  }

  @override
  List<dynamic> get menuItems => [
        {'icon': Icons.home, "text": 'Home'},
        {'icon': Icons.shopping_cart, "text": 'Shopping  Cart'},
        {'icon': Icons.favorite, "text": 'Favorites'},
        {'icon': Icons.notifications, "text": 'Notification'},
        {'icon': Icons.message, "text": 'Messages'},
        {'icon': Icons.settings, "text": 'Settings'},
      ];

  @override
  RxCommand<void, bool> toggleMenu;

  @override
  RxCommand<int, int> setHomePart;

  @override
  int get homeIndex => _homeIndex;
}
