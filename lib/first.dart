import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:load/load.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
RxDouble Height=1.5.obs;
RxDouble Weight=0.0.obs;
RxDouble Age=0.0.obs;
RxDouble Result=0.0.obs;
final Kind_2=''.obs;
final yes=false.obs;
List<String> setting=['Rate app','Share app','Help center'];

class First extends StatefulWidget {
  final double Result1;
  final double Result2;
  final String Result3;
  const First({this.Result1,this.Result2,this.Result3,  Key key}) : super(key: key);
  @override
  State<First> createState() => _First();
}
class _First extends State<First> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return
      Screenshot(
        controller:screenshotController ,
        child:Scaffold(
        appBar:AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color:Colors.pink ),),
        title:Text("Result".tr),
            actions: [IconButton(onPressed:(){
              Height.value=0.0;
              Weight.value=0.0;
              Age.value=0.0;
              Kind_2.value='';
              Get.back();
            },tooltip:'change'.tr , icon:Icon(Icons.replay,color:Colors.black)),
              IconButton(onPressed:()async{
              final image=await screenshotController.capture();
              final directory=await getApplicationDocumentsDirectory();
              final image1=File('${directory.path}/screenshot.png');
              image1.writeAsBytesSync(image);
              Share.shareFiles([image1.path]);
              image1.delete();
              },tooltip:'share'.tr , icon:Icon(Icons.share,color:Colors.black))
            ]) ,
      body:SingleChildScrollView(child:Column(children: [
        Divider(),
        Row(mainAxisAlignment:MainAxisAlignment.spaceAround ,
          children: [Text('${'Age'.tr}\n ${widget.Result2.toInt().toString()}',style:TextStyle(fontSize:25,fontWeight:FontWeight.w900)),
            Text('${'2'.tr}\n ${widget.Result3.tr}',style:TextStyle(fontSize:25,fontWeight:FontWeight.w900)), ]),
        Divider(),
        Center(child:Text('your'.tr,style: TextStyle(fontSize:30))),
        Divider(),
        PrettyGauge(
          gaugeSize: 300,
          minValue:0 ,
          maxValue: 40,
            startMarkerStyle: TextStyle(fontSize:25,color:Colors.white) ,
            endMarkerStyle:  TextStyle(fontSize:25,color:Colors.white),
            showMarkers:true,
          segments: [
            GaugeSegment('Low', 18.5, Colors.blue.shade800),
            GaugeSegment('Medium', 6.5, Colors.green.shade800),
            GaugeSegment('High', 5, Colors.yellow),
            GaugeSegment('High', 10, Colors.red.shade900),
          ],
          currentValue:widget.Result1,
          displayWidget: Text(widget.Result1.toStringAsFixed(2), style: TextStyle(fontSize:30)),
        ),
        Divider(),
        Text(Score_express(widget.Result1).tr,style: TextStyle(fontSize:30)),
        Divider(),
          Text(advise( Score_express(widget.Result1)),style: TextStyle(fontSize:18)),
        Text('your health'.tr+':'+health_range(Height.value,18.5,25.0).elementAt(0).toStringAsFixed(0)+'-'+
            health_range(Height.value,18.5,25.0).elementAt(1).toStringAsFixed(0)+' '+'KG'.tr
            ,style: TextStyle(fontWeight:FontWeight.bold , fontSize:20)),
      ])) ));
  }
  String advise(String score)
  {
    switch(score) {
      case 'Under weight':
        return "3".tr;
        break;
      case  'Healthy weight':
        return "4".tr;
        break;
      case 'Pre_obesity' :
        return "5".tr;
        break;
      case 'Obesity class |':
      case 'Obesity class ||':
      case 'Obesity class |||':
       return "6".tr ;
       break;
        default:
        return '';
        break;
    }
  }
  String Score_express(double score)
  {
    if(score<=18.5)
      return 'Under weight';
    else if(score >18.5 && score<=25 )
      return 'Healthy weight';
    else if (score >25 && score<=30 )
      return 'Pre_obesity';
    else if(score >30 && score<=35)
         return 'Obesity class |';
    else if(score >35 && score<=40)
      return 'Obesity class ||';
    else
      return 'Obesity class |||';
  }
  List<double> health_range(double height,double start,double end)
  {
    return [(height*height)*start,(height*height)*end];
  }
}
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
        FlatButton(
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
              yes.value=false;
            else   yes.value=true;} ,
            minLines: 5,
            style:TextStyle(fontSize: 25,color: Colors.black) ,
            decoration:InputDecoration(hintText : '44'.tr,
                hintStyle:TextStyle(fontSize: 25,color: Colors.black) ,
                counterStyle: TextStyle(fontSize: 25,color: Colors.black),
                enabledBorder:OutlineInputBorder(borderSide:BorderSide(width: 1,color: Colors.black) )
                ,focusedBorder:OutlineInputBorder(borderSide:BorderSide(width: 1,color: Colors.black) ))
        )), Divider(thickness: 5,color: Colors.transparent),
        Obx(()=> FlatButton(onPressed:yes.isFalse?null:()async{
          final       url='mailto:eslam1995saleh@gmail.com?subject=bmi_app&body=${tc1.text}';
          if (await canLaunch(url)) {
            await launch(url);
          }
          else
            Toast.show('45'.tr, gravity: Toast.bottom, duration: Toast.lengthLong);
        }, child: Text('Submit'.tr,style: TextStyle(fontSize: 40,color: Colors.white)),height: 100,minWidth: 200,shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50) ),
            color:yes.isFalse?Colors.transparent:Colors.pinkAccent )
        ),        Divider(thickness: 5,color: Colors.transparent) ]   ));
}));}
class Languages implements Translations{
  @override
  Map<String, Map<String, String>> get keys =>{
    "ar":{"your":"قياس مؤشرك","Under weight":"تحت الوزن","Healthy weight":"وزن صحى و مثالى",
      "Add":" أضف معلوماتك", "change":"تغيير الوضع","Calculate":"أحسب",
      "your health":"مدى الوزن المثالى لك","KG":"كجم", '43':'أخبرنا بالمشكلة التي واجهتها',
      "Obesity class ||":"سمنة من الدرجة الثانية","Obesity class |||":"سمنة من الدرجة الثالثة",
      "Pre_obesity":"ما قبل السمنة","Obesity class |":"سمنة من الدرجة الاولى",
      "Male":"ذكر", "Female":"أنثى","Height":"الطول","Weight":"الوزن بالكيلو",
      "error2":"يجب أن يكون 25 كجم عالاقل", "error3":"يجب ان يكون 10 سنوات عالاقل",
      "1":"أدخل نوع جنسك","load":"تحميل",'45':'تعذر تشغيل هذا الرابط',
      '44':'أدخل تعليقك',"type":"نوع",
      "3":"يشير مؤشر كتلة الجسم الذي يقل عن 18.5 إلى أنك تعاني من نقص الوزن "
          "، لذلكقد تحتاج إلى زيادة الوزن ، يوصى باستشارة طبيبك أو اختصاصي التغذية",
      '42':'هل تحب هذا التطبيق؟ خذ القليل من وقتك لتترك تقييمًا:','41':'قيم هذا التطبيق',
      "4":"يشير مؤشر كتلة الجسم الخاص بك إلى أنك تتمتع بوزن صحي يتناسب مع طولك "
          "، فمن خلال الحفاظ على وزن صحي ، فإنك تقلل من خطر الإصابة بمشكلات صحية خطيرة",'Submit':'نفذ',
      "6":"يشير مؤشر كتلة الجسم الذي يزيد عن 30 إلى أنك تعاني من زيادة الوزن بشكل كبير ، لذلك قد تكون صحتك في خطر حقيقي إذا لم تفقد الوزن ، يوصى باستشارة طبيبك أو اختصاصي التغذية",
      "5":"يشير مؤشر كتلة الجسم من 25 إلى 30 إلى أنك تعاني من زيادة طفيفة في الوزن ، لذلك قد يُنصح بفقدان بعض الوزن لأسباب صحية ، ويُنصح باستشارة طبيبك أو اختصاصي التغذية " ,
      "2":"الجنس", "Age":"العمر","Result":"النتيجة","Please Enter your Height":"أدخل قيمة الطول"
    },
    "en":{"your":"Your Score","Under weight":"Under weight","Obesity class |":"Obesity class |",
        "Obesity class ||":"Obesity class ||","Obesity class |||":"Obesity class |||",
      "Healthy weight":"Healthy weight","Pre_obesity":"Pre_obesity",'45':'Could not launch This link',
      "your health":"Your Health Weight Range","KG":"KG",'Submit':'Submit', '44':'Enter your Comment',
      '43':'Tell us the problem you encountered',"type":"type",'41':'Rate this app',
      '42':'You like this app ? Then take a little bit of your time to leave a rating :',
      "5":"A BMI of 25-30 indicates that you are slightly overweight, so"
          "you may be advised to lose some weight for health reasons ,you are recommended to ask your doctor or a dietitian for advice",
       "3":"A BMI of less than 18.5 indicates that you are underweight, so"
"you may need to put on some weight ,you are recommended to ask your doctor or a dietitian for advice",
      "4":"Your BMI indicates that you are Healthy weight,"
  "for your height ,by maintaining a health weight you lower your risk of developing serious health problems",
      "Add":"add your information","change":"change mode","Age":"Age","2":"Gender"
    ,"error3":"Must be at least 10 years old","1":"Please Enter your gender","load":"loading",
    "error2":"Must be at least 25 Kg", "6":"A BMI over 30 indicates that you are heavily overweight, so"
          "your health may be at really risk if you do not lose weight ,you are recommended to ask your doctor or a dietitian for advice",
      "Please Enter your Height":"Please Enter your Height","Calculate":"Calculate",
     "Result":"Result" ,"Male":"Male","Female":"Female","Height":"Height","Weight":"Weight Kilograms"}
  };
}
load(){
  showCustomLoadingWidget(
      Center(child:Container(child: Row(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('    '),CircularProgressIndicator(color:Colors.lightBlue),Text('   '),Text("load".tr,style: TextStyle(color: Colors.white,fontSize:20 ))],))
      ));
  Future.delayed(Duration(seconds: 3),(){hideLoadingDialog();});
}