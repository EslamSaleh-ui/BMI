

import 'package:get/get.dart';

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