import 'package:flutter/material.dart';
import 'package:flutter_car_installmemt_app/views/car_installment_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    // ให้หน้าจอสแปลชแสดงผลเป็นเวลา 3 วินาที แล้วเปลี่ยนไปยังหน้า HomeUi
    Future.delayed(
      //เวลาที่หน่วง
      Duration(seconds: 3),
      //เมื่อครบเวลาให้เปลี่ยนหน้า
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CarInstallmentUi(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 72, 88, 73),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              '/images/car.png',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Text(
              'Car Installment',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
                color: Colors.lightGreenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'คำนวณค่างวดรถยนต์',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
                color: Colors.lightGreenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 100),
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(height: 100),
            Text(
              'Created by Sugit DTI-SAU',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.015,
                color: Colors.lightGreenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.015,
                color: Colors.lightGreenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
