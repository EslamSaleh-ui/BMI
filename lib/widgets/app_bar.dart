import 'dart:io';

import 'package:bmi_app/methods/methods.dart';
import 'package:bmi_app/widgets/raw.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class app_bar extends StatelessWidget{

  List<String> setting=['Rate app','Share app','Help center'];
  List<IconData> icons=[Icons.rate_review_outlined,Icons.share,Icons.help_center];
  @override
  Widget build(BuildContext context) {
   return AppBar(
     flexibleSpace: Container(
       decoration: BoxDecoration(color:Colors.pink ),),
     title: Text('Add'.tr),
     actions: [IconButton(onPressed:(){
       if(Get.locale==Locale('en'))
         Get.updateLocale(Locale('ar'));
       else
         Get.updateLocale(Locale('en'));
     },tooltip:Get.locale==Locale('en')?'ENG':'ع' , icon:Icon(Icons.language,color:Colors.black)),
       IconButton(icon:Icon(Icons.dark_mode,color:  Colors.black),onPressed: (){
         Get.changeTheme(ThemeData.dark());
       }),
       IconButton(icon:Icon(Icons.brightness_1_rounded,color:Colors.yellow),onPressed: (){
         Get.changeTheme(ThemeData.light());
       }),
       PopupMenuButton(itemBuilder: (_){
         return setting.map((e) {
           return PopupMenuItem(child: raw(text: Text(e),icon:Icon(icons.elementAt(setting.indexOf(e)) ,color: Colors.blueGrey)),onTap: (){
             switch (setting.indexOf(e))
             {
               case 0:
                 rate(context);
                 break;
               case 1:
                 Share.share(Platform.isAndroid?"https://play.google.com/store/apps/details?id=${'com.example.bmi_app'}":"https://apps.apple.com/app/id${' com.example.bmiApp'}");
                 break;
               case 2:
                 help();
                 break;
               default:
                 break;
             }
           });
         }).toList();
       })
     ],
   );
  }
  
}