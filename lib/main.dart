// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Native Code',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:const NativeCodeScreen(),
    );
  }
}

class NativeCodeScreen extends StatefulWidget {
  const NativeCodeScreen({Key? key}) : super(key: key);

  @override
  _NativeCodeScreenState createState() => _NativeCodeScreenState();
}

class _NativeCodeScreenState extends State<NativeCodeScreen> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
// Get battery level.
  String batteryLevel = 'Unknown battery level.';

  Future<void> getBatteryLevel() async {
    platform.invokeMethod('getBatteryLevel').then((value){
     setState(() {
       batteryLevel = 'Battery level at $value % .';
     });
    }).catchError((onError){
      print( "Failed to get battery level: '${onError.message.toString()}'.");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Calculate Pattery Level Native Code',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white
        ),),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Get Battery Level'),
              onPressed: getBatteryLevel,
            ),
            const SizedBox(height: 10,),
            Text(batteryLevel),//fffff
          ],
        ),
      ),
    );
  }
}

