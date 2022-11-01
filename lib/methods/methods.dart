import 'package:bmi_app/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:load/load.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

final controllors =Get.put(controller());

void rate(BuildContext context) { RateMyApp rateMyApp = RateMyApp(
  preferencesPrefix: 'rateMyApp_',
  minDays: 7,
  minLaunches: 10,
  remindDays: 7,
  remindLaunches: 10,
  googlePlayIdentifier: 'com.example.bmi_app',
  appStoreIdentifier: 'com.example.bmiApp',
);
rateMyApp.init().then((_) {
  rateMyApp.showStarRateDialog(
    context,
    title: '41'.tr, // The dialog title.
    message: '42'.tr,
    actionsBuilder: (context, stars) {
      return [
        ElevatedButton(
            child: Text('OK'),
            onPressed: () async {
              await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
              Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
              if(stars==null || stars.round()<=3)
              {help();}
              else {
                Future.delayed(Duration(seconds: 3),(){
                  LaunchReview.launch(androidAppId: 'com.example.bmi_app',iOSAppId:' com.example.bmiApp' );
                });  }
            })
      ];
    },
    dialogStyle: const DialogStyle( // Custom dialog styles.
      titleAlign: TextAlign.center,
      messageAlign: TextAlign.center,
      messagePadding: EdgeInsets.only(bottom: 20),
    ),
    starRatingOptions: const StarRatingOptions(),
    onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
  );  }); }
void help()
{
  final tc1=TextEditingController();
  Get.bottomSheet(BottomSheet(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
      onClosing: (){}, builder:(context){
    return SingleChildScrollView(child: Column(
        children: [
          Align(alignment:Alignment.topLeft,child: IconButton(padding: EdgeInsets.all(5),onPressed:(){Get.back();}, icon: Icon(Icons.close)) ),
          Center(child: Icon(Icons.attach_email,color:Colors.pinkAccent,size: 50)),
          Divider(thickness: 5,color: Colors.transparent),
          Text('43'.tr,style: TextStyle(fontSize: 25),textAlign:TextAlign.center),
          Divider(thickness: 5,color: Colors.transparent),
          Align(alignment: Alignment.centerLeft,child:Text('   '+'type'.tr,style: TextStyle(fontSize: 25))),
          Divider(thickness: 5,color: Colors.transparent),
          Padding(padding: EdgeInsets.all(5),child:
          TextFormField(
              controller: tc1,
              maxLines: 5,
              keyboardType: TextInputType.text,
              maxLength: 500,
              onChanged:(i){if(i==null || i.length<6)
                controllors.yes.value=false;
              else   controllors.yes.value=true;} ,
              minLines: 5,
              style:TextStyle(fontSize: 25,color: Colors.black) ,
              decoration:InputDecoration(hintText : '44'.tr,
                  hintStyle:TextStyle(fontSize: 25,color: Colors.black) ,
                  counterStyle: TextStyle(fontSize: 25,color: Colors.black),
                  enabledBorder:OutlineInputBorder(borderSide:BorderSide(width: 1,color: Colors.black) )
                  ,focusedBorder:OutlineInputBorder(borderSide:BorderSide(width: 1,color: Colors.black) ))
          )), Divider(thickness: 5,color: Colors.transparent),
          Obx(()=> ElevatedButton(onPressed:controllors.yes.isFalse?null:()async{
            final       url='mailto:eslam1995saleh@gmail.com?subject=bmi_app&body=${tc1.text}';
            if (await canLaunch(url)) {
              await launch(url); }
            else
              Toast.show('45'.tr, gravity: Toast.bottom, duration: Toast.lengthLong);
          }, child: Text('Submit'.tr,style: TextStyle(fontSize: 40,color: Colors.white)),
              style: ElevatedButton.styleFrom(
                  backgroundColor:controllors.yes.isFalse?Colors.transparent:Colors.pinkAccent
                  ,shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
                  minimumSize: Size(MediaQuery.of(context).size.width-50 ,50))
          )
          ),        Divider(thickness: 5,color: Colors.transparent) ]   ));
  }));}
load(){
  showCustomLoadingWidget(
      Center(child:Container(child: Row(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('    '),CircularProgressIndicator(color:Colors.lightBlue),Text('   '),Text("load".tr,style: TextStyle(color: Colors.white,fontSize:20 ))],))
      ));
  Future.delayed(Duration(seconds: 3),(){hideLoadingDialog();});
}