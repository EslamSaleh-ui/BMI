
import 'dart:io';

import 'package:counter_button/counter_button.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:share/share.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_choice_chip/flutter_3d_choice_chip.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'first.dart';
import 'package:load/load.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   runApp( LoadingProvider(themeData: LoadingThemeData(),
      child:GetMaterialApp(
          theme: Get.theme,
          debugShowCheckedModeBanner: false,
          locale:Locale('en'),
          fallbackLocale:Locale("en") ,
          translations:Languages() ,
          home:MyApp()) ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      image: Image.asset('assets/image/BMI.png'),
        photoSize:MediaQuery.of(context).size.width/2,
        backgroundColor: Colors.black,
      navigateAfterSeconds:MyHomePage(),
       seconds: 5,
        useLoader:false
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> kind=['Male','Female'];
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
             return PopupMenuItem(child: Text(e),onTap: (){
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
            Divider(),
           Row(mainAxisAlignment:MainAxisAlignment.spaceAround ,
             children:kind.map((e) {
               return ChoiceChip3D(
                 height:120 ,
                 width: 150,
                 style: ChoiceChip3DStyle.white, // ChoiceChip3DStyle.red, ChoiceChip3DStyle.white
                 selected: false,
                 onSelected: () {Kind_2.value=e;},
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
            Divider(height:20),
        Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,
         children: [
           Column(children:[
             Text('Weight'.tr,style:TextStyle(fontSize: 20 )),
           Divider(),
           Obx(()=> CounterButton(
           loading: false,
           onChange: (int val) {Weight.value = val.toDouble();},
           count:Weight.value.toInt() ,
           buttonColor: Colors.purpleAccent,
         ))]), SizedBox(width: 10,),
           Column(children:[
             Text('Age'.tr,style:TextStyle(fontSize: 20 )),
             Divider(),
             Obx(()=>CounterButton(
             loading: false,
             onChange: (int val) {Age.value = val.toDouble();},
             count:Age.value.toInt() ,
             buttonColor: Colors.purpleAccent,
           ))])
         ]),Divider(),
            Center(child:Column(children: [Text('Height'.tr,style:TextStyle(fontSize: 20 ) ),
              Obx(()=>Text(Height.value.toStringAsFixed(2)+' m',style: TextStyle(fontSize: 20 )))],)),
            Obx(()=> Slider(max:3.0,min: 0.0 ,value:Height.value, onChanged:(v){Height.value=v;},activeColor:Colors.blue) ),
             ],
        ),
      ),floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked ,
      floatingActionButton:NiceButtons(
        stretch: true,
        progress: false,
        startColor:Colors.pinkAccent ,
        endColor:Colors.pink ,
        borderColor:Colors.pinkAccent ,
        gradientOrientation: GradientOrientation.Horizontal,
        onTap: (finish) {
          load();
           if(Height.value>0 && Kind_2.value!='' && Age.value>10 && Weight.value>25 )
                {calculateBmi();
                Get.to(()=>First(Result1: Result.value,Result2:Age.value ,Result3:Kind_2.value));
                }
                else if(Kind_2.value=='')
              Toast.show('1'.tr,duration:Toast.lengthLong,gravity: Toast.bottom );
                else if( Age.value<10)
             Toast.show('error3'.tr,duration:Toast.lengthLong,gravity: Toast.bottom );
                else if(Weight.value<25 )
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
  void calculateBmi() {
    Result.value = Weight.value / (Height.value *Height.value) ;
  }
}
