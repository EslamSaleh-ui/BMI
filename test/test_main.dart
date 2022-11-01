import 'package:bmi_app/controller/controller.dart';
import 'package:bmi_app/pages/myhome.dart';
import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_choice_chip/flutter_3d_choice_chip.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

void main()
{
testWidgets('ok main page', (tester) async{
  await tester.pumpWidget(    GetMaterialApp(home: MyHomePage()));
    expect(find.text('Add'), findsOneWidget);
     expect(find.byIcon(Icons.language), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    expect(find.byIcon(Icons.brightness_1_rounded), findsOneWidget);
    expect(find.byType(ChoiceChip3D), findsWidgets);
    expect(find.byType(CounterButton), findsWidgets);
    expect(find.text('Calculate'), findsOneWidget);
    await tester.tap(find.byType(NiceButtons));
    await tester.pumpAndSettle(Duration(seconds: 3));
  expect(find.byType(MyHomePage), findsNothing);
  expect(find.byType(PrettyGauge), findsOneWidget);
  expect(find.byIcon(Icons.replay), findsOneWidget);
  expect(find.byIcon(Icons.share), findsOneWidget);
});
}
