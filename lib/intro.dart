import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sizer/sizer.dart';

import 'login.dart';

class intro extends StatelessWidget {
  intro({Key? key}) : super(key: key);
  final List<PageViewModel> pages = [
    PageViewModel(
      titleWidget: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            'HAVE YOUR X-RAY',
            style: TextStyle(
                fontSize: 35,
                color: Color(0xFF494848),
                fontFamily: "Century Gothic",
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      bodyWidget: Text(
        "All you have to do is, go to X-ray lab, and have your X-ray.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15,
            color: Color(0xFF494848),
            fontFamily: "Century Gothic"),
      ),
      image: Image.asset(
        "images/i1.png",
        //height: 40.0.w,
        width: 55.0.w,
      ),
    ),
    PageViewModel(
      titleWidget: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            'UPLOAD YOUR X-RAY',
            style: TextStyle(
                fontSize: 35,
                color: Color(0xFF494848),
                fontFamily: "Century Gothic",
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      bodyWidget: Text(
        "You can upload your X-ray by just picking up image file from your mobile storage.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15,
            color: Color(0xFF494848),
            fontFamily: "Century Gothic"),
      ),
      image: Image.asset(
        "images/i2.png",
        //height: 40.0.w,
        width: 65.0.w,
      ),
    ),
    PageViewModel(
      titleWidget: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            'TAKE A PICTURE FROM YOUR X-RAY',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 35,
                color: Color(0xFF494848),
                fontFamily: "Century Gothic",
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      bodyWidget: Text(
        "You can also upload the X-ray by clicking its picture using your mobile camera.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15,
            color: Color(0xFF494848),
            fontFamily: "Century Gothic"),
      ),
      image: Image.asset(
        "images/i3.png",
        //height: 40.0.w,
        width: 45.0.w,
      ),
    ),
    PageViewModel(
      titleWidget: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            'GET YOUR REPORT',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 35,
                color: Color(0xFF494848),
                fontFamily: "Century Gothic",
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      bodyWidget: Text(
        "After uploading your X-ray, our model will process it and provide you report whether you have pneumonia or not.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15,
            color: Color(0xFF494848),
            fontFamily: "Century Gothic"),
      ),
      image: Image.asset(
        "images/i4.png",
        //height: 40.0.w,
        width: 37.0.w,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: IntroductionScreen(
        pages: pages,
        dotsDecorator: DotsDecorator(
          size: Size(10, 10),
          color: Colors.grey,
          activeSize: Size.square(15),
          activeColor: Color(0xFF3373b9),
        ),
        showDoneButton: true,
        done: doneB("Get Started"),
        showSkipButton: true,
        skip: doneB("Skip"),
        showNextButton: true,
        next: Icon(
          Icons.arrow_forward_ios,
          size: 20,
        ),
        onDone: () => onDone(context),
      ),
    );
  }
}

Widget doneB(String s) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      color: Color(0xFF3373b9),
    ),
    height: 30,
    width: 100,
    child: Center(
        child: Text(
      s,
      style: TextStyle(color: Colors.white),
    )),
  );
}

void onDone(context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Login()));
}
