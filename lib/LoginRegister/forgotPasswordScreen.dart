import 'package:flutter/material.dart';
import 'Login_Register_Main_File.dart';
import 'package:tic_tech_teo_2023/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  Future postReq(String email) async {
    final res = await http.post(
      Uri.parse('$BASIC_URL/forgot-password/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"email": email}),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to request for password change");
    }

  }


  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Forgot Password"),
      ),

      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 18.0,vertical: 15),
            child: buildTextField(Icons.mail_outline, "info@demouri.com", false, true,email),
          ),
          OutlinedButton(
              onPressed: () async {
                final res = await postReq(email.text);

                print("res: $res");
              },
              child: const Text("Continue",style: TextStyle(color: Colors.black),)),
        ],
      ),

    );
  }
}
