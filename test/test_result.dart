import 'package:bmi_app/controller/controller.dart';
import 'package:bmi_app/pages/first.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

void main()
{
testWidgets('ok main page', (tester) async{
    final controllor =Get.put(controller());
    controllor.Height.value=1.88;
    controllor.Weight.value=88;
    controllor.Age.value=24;
    controllor.Kind_2.value='Male';
    await tester.pumpWidget(GetMaterialApp(home: First(Result1: controllor.Result.value,Result2:controllor.Age.value ,
    Result3: controllor.Kind_2.value )  ));
    expect(find.text('Result'), findsOneWidget);
    expect(find.byIcon(Icons.replay), findsOneWidget);
    expect(find.byIcon(Icons.share), findsOneWidget);
    expect(find.byType(PrettyGauge), findsOneWidget);
    expect(find.text(controllor.Result.value.toStringAsFixed(2)), findsOneWidget);
    await tester.tap(find.byIcon(Icons.replay));
    await tester.pump();
    expect(controllor.Age.value,0.0);
    expect(controllor.Height.value,0.0);
    expect(controllor.Weight.value,0.0);
});
}
