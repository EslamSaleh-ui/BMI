import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bmi_app/controller/controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';



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
  final controllor =Get.put(controller());
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
              controllor.Height.value=0.0;
              controllor.Weight.value=0.0;
              controllor.Age.value=0.0;
              controllor.Kind_2.value='';
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
        Divider(color: Colors.transparent),
        Row(mainAxisAlignment:MainAxisAlignment.spaceAround ,
          children: [Text('${'Age'.tr}\n ${widget.Result2.toInt().toString()}',style:TextStyle(fontSize:25,fontWeight:FontWeight.w900)),
            Text('${'2'.tr}\n ${widget.Result3.tr}',style:TextStyle(fontSize:25,fontWeight:FontWeight.w900)), ]),
        Divider(color: Colors.transparent),
        Center(child:Text('your'.tr,style: TextStyle(fontSize:30))),
        Divider(color: Colors.transparent),
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
        Divider(color: Colors.transparent),
        Text(controllor.Score_express(widget.Result1).tr,style: TextStyle(fontSize:30)),
        Divider(color: Colors.transparent),
          Text(controllor.advise(controllor. Score_express(widget.Result1)),style: TextStyle(fontSize:18)),
        Text('your health'.tr+':'+controllor.health_range(controllor.Height.value,18.5,25.0).elementAt(0).toStringAsFixed(0)+'-'+
            controllor.health_range(controllor.Height.value,18.5,25.0).elementAt(1).toStringAsFixed(0)+' '+'KG'.tr
            ,style: TextStyle(fontWeight:FontWeight.bold , fontSize:20)),
      ])) ));
  }
}


