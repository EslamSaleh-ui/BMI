import 'package:bmi_app/controller/controller.dart';
import 'package:bmi_app/pages/myhome.dart';
import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_choice_chip/flutter_3d_choice_chip.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nice_buttons/nice_buttons.dart';

void main()
{
testWidgets('ok main page', (tester) async{
  final controllor =Get.put(controller());
  await tester.pumpWidget(GetMaterialApp(home: MyHomePage()));
    expect(find.text('Add'), findsOneWidget);
     expect(find.byIcon(Icons.language), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    expect(find.byIcon(Icons.brightness_1_rounded), findsOneWidget);
    expect(find.byType(ChoiceChip3D), findsWidgets);
    expect(find.byType(CounterButton), findsWidgets);
    expect(find.text('Calculate'), findsOneWidget);
  await tester.tap(find.byIcon(Icons.brightness_1_rounded));
  await tester.pumpAndSettle(Duration(seconds: 3));
  expect(Get.theme.brightness.name,ThemeData.light().brightness.name);
  await tester.tap(find.byIcon(Icons.dark_mode));
  await tester.pumpAndSettle(Duration(seconds: 3));
  expect(Get.theme.brightness.name,ThemeData.dark().brightness.name);
  controllor.Height.value=1.88;
  controllor.Weight.value=88;
  controllor.Age.value=27;
  controllor.Kind_2.value='Male';
    await tester.tap(find.byType(NiceButtons));
  await tester.pumpAndSettle(Duration(seconds: 3));
  expect(find.byType(MyHomePage), findsNothing);
  expect(find.text(controllor.Result.value.toStringAsFixed(2)), findsOneWidget);
  expect(find.byIcon(Icons.replay), findsOneWidget);
  expect(find.byIcon(Icons.share), findsOneWidget);
});
}