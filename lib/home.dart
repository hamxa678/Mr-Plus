import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  // Controllers

  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _file_controller = new TextEditingController();
  final TextEditingController _result_controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future getPdfAndUpload() async {
    setState(() {});
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Please select an X-ray image:',
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    String? filepath = result?.files.single.path;

    String file_path = filepath.toString();

    print(file_path);

    File file = File(file_path);
    Uri url = Uri.parse("http://192.168.10.10:8000/list");

    var bytes = file.readAsBytesSync();

    setState(() {
      _controller.text;
      file_path;
    });
    var request = http.MultipartRequest('POST', url)
      ..fields['filename'] = _controller.text
      ..files.add(await http.MultipartFile.fromPath("docfile", file_path,
          contentType: MediaType('application', 'x-tar')));
    var response = await request.send();
    print(response);
    if (response.statusCode == 200) print('Uploaded!');

    String _basename = file_path.split("/").last;

    _file_controller.text = file_path;
    setState(() {
      _controller.text = _basename;
    });

    //_result_controller.text = "no results";
    this.setState(() {});
  }

  Future makePostRequest() async {
    this.setState(() {});

    final uri = Uri.parse('http://192.168.10.10:8000/status');
    final headers = {'Content-Type': 'application/json'};
    Map<String, String> body = {'file': _controller.text};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    var data = json.decode(responseBody);
    print(data['status']);
    _result_controller.text = data['status'];
    setState(() {});
  }

  File? imageFile;
  Future _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      String file_path = pickedFile.path;

      File file = File(file_path);
      Uri url = Uri.parse("http://192.168.10.10:8000/list");

      var bytes = file.readAsBytesSync();

      var request = http.MultipartRequest('POST', url)
        ..fields['filename'] = _controller.text
        ..files.add(await http.MultipartFile.fromPath("docfile", file_path,
            contentType: MediaType('application', 'x-tar')));
      var response = await request.send();
      print(response);
      if (response.statusCode == 200) print('Uploaded!');

      _file_controller.text = file_path;
      String _basename = _file_controller.text.split("/").last;
      _controller.text = _basename;
      //_result_controller.text = "no results";
      this.setState(() {});

      this.setState(() {
        _controller.text;
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
            if (_file_controller.text == "") ...[
              Center(
                child: Image(
                  image: AssetImage("images/hp.png"),
                  width: 55.0.w,
                ),
              ),
            ] else ...[
              Container(
                height: 40.h,
                width: 100.0.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2, color: Color(0xFFf4aacb)),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: FileImage(File(_file_controller.text)),
                        fit: BoxFit.cover)),
              ),
            ],

            // show result from server
            SizedBox(height: 20),
            Center(
              child: Text(
                _result_controller.text,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                getPdfAndUpload();
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
              onTap: () {
                makePostRequest();
              },
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
