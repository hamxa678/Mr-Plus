import 'package:flutter/material.dart';
import 'package:mr_plus/intro.dart';
import 'package:sizer/sizer.dart';

class SplashS extends StatefulWidget {
  const SplashS({Key? key}) : super(key: key);

  @override
  State<SplashS> createState() => _SplashSState();
}

class _SplashSState extends State<SplashS> {
  @override
  void initState() {
    super.initState();
    _navigatetointro();
  }

  _navigatetointro() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => intro()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SizedBox()),
            Image(
              image: AssetImage('images/MR+.png'),
              height: 40.0.w,
              width: 40.0.w,
            ),
            Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "MR",
                  style: TextStyle(
                      fontSize: 31,
                      color: Color(0xFF707070),
                      fontFamily: "Century Gothic",
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Image(
                  image: AssetImage('images/MR+.png'),
                  height: 31,
                  width: 31,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
