import 'package:get/get.dart';

class controller extends GetxController{

  RxDouble Height=1.5.obs;
  RxDouble Weight=0.0.obs;
  RxDouble Age=0.0.obs;
  RxDouble Result=0.0.obs;
  final choice=0.obs;
  final Kind_2=''.obs;
  final yes=false.obs;

  void calculateBmi() {
    Result.value = Weight.value / (Height.value *Height.value) ;
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