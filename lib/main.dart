import 'package:bmi_app/controller/language.dart';
import 'package:bmi_app/pages/myhome.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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