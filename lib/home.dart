import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Future getPdfAndUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Please select an X-ray image:',
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    String? filepath = result?.files.single.path;

    String file_path = filepath.toString();

    print(file_path);
  }

  File? imageFile;
  Future _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 60, 30, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(
                      fontSize: 35,
                      color: Color(0xFF494848),
                      fontFamily: "Century Gothic",
                      fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.menu),
                  iconSize: 35,
                )
              ],
            ),
            Row(
              children: const [
                Text(
                  "MR",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF494848),
                      fontFamily: "Century Gothic",
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Image(
                  image: AssetImage('images/MR+.png'),
                  height: 25,
                  width: 25,
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: Image(
                image: AssetImage("images/hp.png"),
                width: 55.0.w,
              ),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                _getFromGallery();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Color(0xFFf4aacb),
                ),
                height: 50,
                width: double.infinity,
                child: Center(
                    child: Text(
                  "Upload",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                _getFromCamera();
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Color(0xFFede1c7),
                  ),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Take a Picture",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Color(0xFF3373b9),
                ),
                height: 50,
                width: double.infinity,
                child: Center(
                    child: Text(
                  "Generate Report",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
