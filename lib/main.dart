import 'dart:convert';
import 'dart:io';

import 'package:body_measurement/view_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'ProgressDailog.dart';
import 'globalVariable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
            appId: '1:297855924061:ios:c6de2b69b03a5be8',
            apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
            projectId: 'flutter-firebase-plugins',
            messagingSenderId: '297855924061',
            databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
          )
        : FirebaseOptions(
            appId: '1:7671635450:android:8221c387016a748971d843',
            apiKey: 'AIzaSyDYMpGEwPmxZ_vQIESOaOVZwdX08blPwV8',
            storageBucket: 'bodymeasurement-adceb.appspot.com',
            messagingSenderId: '7671635450',
            projectId: 'bodymeasurement-adceb',
          ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late File _imageFile;
  String imageUrl = '';

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile!.path);
      print(_imageFile.toString());
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    await pickImage();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProgressDailog(
              status: 'Getting Info...',
            ));
    String fileName = basename(_imageFile.path);
    var firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    await firebaseStorageRef.putFile(_imageFile).whenComplete(() async {
      firebaseStorageRef.getDownloadURL().then((value) {
        imageUrl = value;
        print('url: $value');
      });
    });
  }

  Future<void> makePostRequest(context) async {
    await uploadImageToFirebase(context);
    final url = Uri.parse(
        'https://backend-test-zypher.herokuapp.com/uploadImageforMeasurement');
    final headers = {"Content-type": "application/json"};
    final json = '{"imageURL":"$imageUrl"}';
    final response = await http.post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    var data = jsonDecode(response.body);
    print("data us" + data['d']['measurementId']);
    measurementId = data['d']['measurementId'];
    neck = data['d']['neck'];
    height = data['d']['height'];
    weight = data['d']['weight'];
    belly = data['d']['belly'];
    chest = data['d']['chest'];
    wrist = data['d']['wrist'];
    armLength = data['d']['armLength'];
    thigh = data['d']['thigh'];
    shoulder = data['d']['shoulder'];
    hips = data['d']['hips'];
    ankle = data['d']['ankle'];
    Navigator.pop(context);

    print(hips + ankle + wrist + chest);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ViewData()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text('Body Measurement'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              makePostRequest(context);
            },
            child: const Text(
              'Upload Image',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ));
  }
}
