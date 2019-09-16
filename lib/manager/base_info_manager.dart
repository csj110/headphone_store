import 'package:flutter/material.dart';
import 'package:rx_command/rx_command.dart';

abstract class BaseInfomanager {
  List<dynamic> get menuItems;
  RxCommand<void, bool> toggleMenu;
}

class BaseInfoManagerImpl implements BaseInfomanager {
  BaseInfoManagerImpl() {
    toggleMenu = RxCommand.createSyncNoParam(() {
      _showMenu = !_showMenu;
      return _showMenu;
    });
  }

  bool _showMenu = false;
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
}
