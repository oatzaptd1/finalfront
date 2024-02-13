import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myproject/src/routes/routes.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  bool Pass_visible = true;

  @override
  void initState() {
    super.initState();
    usernamecontroller.text = "admin";
  }

  void Login(String username, String password) async {
    try {
      final response = await http.get(Uri.parse(
          'http://10.0.2.2:8000/project-v0/profile/login/$username/$password'));

      // if (response.statusCode == 200) {
      //   // การแปลงข้อมูล JSON
      //   Map<String, dynamic> data = json.decode(response.body);
      //   print("Response Data: $data");
      // } else {
      //   print("HTTP Request failed with status: ${response.statusCode}");
      // }

      if (response.statusCode == 200) {
        // การแปลงข้อมูล JSON

        Map<String, dynamic> data = json.decode(response.body);
        // print("Response Data: $data");

        // เข้าถึงค่า res_code และ res_msg
        String resCode = data['res_code'];
        String resMsg = data['res_msg'];

        // ตรวจสอบค่า res_code
        if (resCode == "000") {
          print("Login success");
        } else {
          print("ล็อคอินไม่ผ่านนะจะ");
        }
      } else {
        print("HTTP Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 156, 247),
      body: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 150,
              ),
              Container(
                height: 350,
                width: 325,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'กรุณาเข้าสู่ระบบ',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: usernamecontroller,
                        decoration: InputDecoration(labelText: "ชื่อผู้ใช้งาน"),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: TextFormField(
                        controller: passwordcontroller,
                        obscureText: Pass_visible,
                        decoration: InputDecoration(
                            labelText: "รหัสผ่าน",
                            suffixIcon: IconButton(
                              icon: Icon(Pass_visible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  Pass_visible = !Pass_visible;
                                });
                              },
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: _OnClick, child: Text('เข้าสู่ระบบ')),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  void _OnClick() {
    // print("login success (${usernamecontroller.text})");

    Login(
        usernamecontroller.text.toString(), passwordcontroller.text.toString());
    Navigator.pushNamed(context, AppRoute.menupage);
  }
}
