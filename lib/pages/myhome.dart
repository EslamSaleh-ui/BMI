import 'dart:io';
import 'package:bmi_app/controller/controller.dart';
import 'package:bmi_app/methods/methods.dart';
import 'package:bmi_app/pages/first.dart';
import 'package:counter_button/counter_button.dart';
import 'package:bmi_app/widgets/raw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_choice_chip/flutter_3d_choice_chip.dart';
import 'package:get/get.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  List<String> kind=['Male','Female'];
  List<String> setting=['Rate app','Share app','Help center'];
  List<Icon> icons=[Icon(Icons.rate_review_outlined),Icon(Icons.share),Icon(Icons.help_center)];
  final controllor =Get.put(controller());

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
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
              return PopupMenuItem(child: raw(text: Text(e),icon:icons.elementAt(setting.indexOf(e)) ),onTap: (){
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Divider(color: Colors.transparent),
            Row(mainAxisAlignment:MainAxisAlignment.spaceAround ,
                children:kind.map((e) {
                  return ChoiceChip3D(
                    height:120 ,
                    width: 150,
                    style: ChoiceChip3DStyle.white, // ChoiceChip3DStyle.red, ChoiceChip3DStyle.white
                    selected: false,
                    onSelected: () {controllor.Kind_2.value=e;},
                    onUnSelected: () {},
                    child:Center(child:Column(children:[
                      Container(height:70 ,width: 200,
                          decoration:BoxDecoration(image:
                          DecorationImage(image:
                          AssetImage(e=='Male'?'assets/image/male.png':'assets/image/female.png') ))) ,
                      Text(e.tr,style:TextStyle(fontSize: 20,color:Colors.black ) ,)
                    ])),
                  );
                }).toList()
            ) ,
            Divider(height:20,color: Colors.transparent),
            Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children:[
                    Text('Weight'.tr,style:TextStyle(fontSize: 20 )),
                    Divider(color: Colors.transparent),
                    Obx(()=> CounterButton(
                      loading: false,
                      onChange: (int val) {controllor.Weight.value = val.toDouble();},
                      count:controllor.Weight.value.toInt() ,
                      buttonColor: Colors.purpleAccent,
                    ))]), SizedBox(width: 10,),
                  Column(children:[
                    Text('Age'.tr,style:TextStyle(fontSize: 20 )),
                    Divider(color: Colors.transparent),
                    Obx(()=>CounterButton(
                      loading: false,
                      onChange: (int val) {controllor.Age.value = val.toDouble();},
                      count:controllor.Age.value.toInt() ,
                      buttonColor: Colors.purpleAccent,
                    ))])
                ]),Divider(color: Colors.transparent),
            Center(child:Column(children: [Text('Height'.tr,style:TextStyle(fontSize: 20 ) ),
              Obx(()=>Text(controllor.Height.value.toStringAsFixed(2)+' m',style: TextStyle(fontSize: 20 )))],)),
            Obx(()=> Slider(max:3.0,min: 0.0 ,value:controllor.Height.value, onChanged:(v){controllor.Height.value=v;},activeColor:Colors.blue) ),
          ],
        ),
      ),floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat ,
      floatingActionButton:NiceButtons(
        stretch: true,
        progress: false,
        startColor:Colors.pinkAccent ,
        endColor:Colors.pink ,
        borderColor:Colors.pinkAccent ,
        gradientOrientation: GradientOrientation.Horizontal,
        onTap: (finish) {
          load();
          if(controllor.Height.value>0 && controllor.Kind_2.value!='' && controllor.Age.value>10 && controllor.Weight.value>25 )
          {controllor.calculateBmi();
          Get.to(()=>First(Result1:controllor. Result.value,Result2:controllor.Age.value ,Result3:controllor.Kind_2.value));
          }
          else if(controllor.Kind_2.value=='')
            Toast.show('1'.tr,duration:Toast.lengthLong,gravity: Toast.bottom );
          else if( controllor.Age.value<10)
            Toast.show('error3'.tr,duration:Toast.lengthLong,gravity: Toast.bottom );
          else if(controllor.Weight.value<25 )
            Toast.show('error2'.tr,duration:Toast.lengthLong,gravity: Toast.bottom );
          else
            Toast.show('Please Enter your Height'.tr,duration:Toast.lengthLong,gravity: Toast.bottom );
        },
        child: Text('Calculate'.tr,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ) ,
    );
  }

}
