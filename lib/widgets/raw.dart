

import 'package:flutter/material.dart';

class raw extends StatelessWidget{
  final Widget icon;
  final Widget text;

  const raw({this.icon,this.text,  Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Padding(padding: EdgeInsets.symmetric(horizontal: 1.0),child:
       Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [this.icon,this.text],
     ));
  }

}