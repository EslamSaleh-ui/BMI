import 'package:bmi_app/controller/controller.dart';
import 'package:bmi_app/pages/first.dart';
import 'package:bmi_app/pages/myhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

void main()
{
testWidgets('ok main page', (tester) async{
    final controllor =Get.put(controller());
    controllor.Result.value=24.5;
    controllor.Age.value=24;
    controllor.Kind_2.value='Male';
    await tester.pumpWidget(    GetMaterialApp(home: First(Result1: controllor.Result.value,Result2:controllor.Age.value ,
    Result3: controllor.Kind_2.value )  ));
    expect(find.text('Result'), findsOneWidget);
    expect(find.byIcon(Icons.replay), findsOneWidget);
    expect(find.byIcon(Icons.share), findsOneWidget);
    expect(find.byType(PrettyGauge), findsOneWidget);
    expect(find.text('Healthy weight'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.byType(MyHomePage), findsNothing);
    await tester.tap(find.byIcon(Icons.replay));
    await tester.pumpAndSettle(Duration(seconds: 3));
    expect(controllor.Age.value,0.0);
    expect(controllor.Height.value,0.0);
    expect(controllor.Weight.value,0.0);
});
}
