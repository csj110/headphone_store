import 'package:flutter/material.dart';
import '../models/item_list.dart';

class HeadphoneDetail extends StatelessWidget {
  final ProudctItem item;

  const HeadphoneDetail({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.colors[0]),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset(item.path),
            ],
          ),
        ),
      ),
    );
  }
}
