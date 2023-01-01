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
  List<IconData> icons=[Icons.rate_review_outlined,Icons.share,Icons.help_center];
  final Controller =Get.put( controller());

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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Divider(color: Colors.transparent),
            Row(mainAxisAlignment:MainAxisAlignment.spaceAround ,
                children:kind.map((e) {
                  final choice=false.obs;
                  return Obx(() => ChoiceChip3D(
                    height:120 ,
                    width: 150,
                    style: ChoiceChip3DStyle.white,
                    selected: choice.value,
                    onSelected: () {Controller.Kind_2.value=e;choice.value=true;},
                    onUnSelected: () {choice.value=false;Controller.Kind_2.value='';},
                    child:Center(child:Column(children:[
                      Container(height:70 ,width: 200,
                          decoration:BoxDecoration(image:
                          DecorationImage(image:
                          AssetImage(e=='Male'?'assets/image/male.png':'assets/image/female.png') ))) ,
                      Text(e.tr,style:TextStyle(fontSize: 20,color:Colors.black ) ,)
                    ])),
                  ));
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
                      onChange: (int val) {Controller.Weight.value = val.toDouble();},
                      count:Controller.Weight.value.toInt() ,
                      buttonColor: Colors.purpleAccent,
                    ))]), SizedBox(width: 10,),
                  Column(children:[
                    Text('Age'.tr,style:TextStyle(fontSize: 20 )),
                    Divider(color: Colors.transparent),
                    Obx(()=>CounterButton(
                      loading: false,
                      onChange: (int val) {Controller.Age.value = val.toDouble();},
                      count:Controller.Age.value.toInt() ,
                      buttonColor: Colors.purpleAccent,
                    ))])
                ]),Divider(color: Colors.transparent),
            Center(child:Column(children: [Text('Height'.tr,style:TextStyle(fontSize: 20 ) ),
              Obx(()=>Text(Controller.Height.value.toStringAsFixed(2)+' m',style: TextStyle(fontSize: 20 )))],)),
            Obx(()=> Slider(max:3.0,min: 0.0 ,value:Controller.Height.value, onChanged:(v){Controller.Height.value=v;},activeColor:Colors.blue) ),
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
          if(Controller.Height.value>0 && Controller.Kind_2.value!='' && Controller.Age.value>10 && Controller.Weight.value>25 )
          {Controller.calculateBmi();
          Get.to(()=>First(Result1:Controller. Result.value,Result2:Controller.Age.value ,Result3:Controller.Kind_2.value));
          }
          else if(Controller.Kind_2.value=='')
            Toast.show('1'.tr,duration:Toast.lengthLong,gravity: Toast.bottom );
          else if( Controller.Age.value<10)
            Toast.show('error3'.tr,duration:Toast.lengthLong,gravity: Toast.bottom );
          else if(Controller.Weight.value<25 )
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
