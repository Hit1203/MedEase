import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tech_teo_2023/utils/constants.dart';
import 'package:http/http.dart' as http;


class User {
  // String? username;
  // String? userID;
  String? email;
  String? pwd;
  String? name;
  bool? isDoctor = false;
  String? gender;

  String? auth_token;
  bool isAuthorized = false;
  String basicUri = BASIC_URL;

  //for patient
  int? age;
  double? height;
  double? weight;
  String? bloodGroup;

  //for doctor
  String? qualification;
  String? whStart;
  String? whEnd;
  List<String>? nonWorkingDays;


  User({
    this.email,
    this.pwd,
    this.name,
    this.isDoctor,
    this.gender,

    this.age,
    this.height,
    this.weight,
    this.bloodGroup,

    this.qualification,
    this.whStart,
    this.whEnd,
    this.nonWorkingDays,
  });

  Map<String, String> toJSONLogIn(User user) {
    return {
      // "username": user.username!,
      "email": user.email!,
      "password": user.pwd!,
    };
    }

  Map<String, dynamic> toJSON(User user) {
    // if (isDoctor!){
      return {
        // "username": user.username!,
        "email": user.email!,
        "password": user.pwd!,
        "fullname": user.name!,
        "is_doctor": user.isDoctor!,
        "gender": user.gender!,

        "age": user.age,
        "weight": user.weight,
        "height": user.height,
        "blood_group": user.bloodGroup,

        "qualification": user.qualification,
        "wh_start": user.whStart,
        "wh_end":user.whEnd,
        "non_working_week_days": user.nonWorkingDays.toString(),

      };
    // }
    // else {
    //   return {
    //     "email":user.email!,
    //     "password": user.pwd!,
    //     "name": user.name!,
    //     "address": user.gender!,
    //     "website": user.bloodGroup!
    //   };
    // }
  }


  Future signUp(User user) async {
    // if(isDoctor!){
      print("Signing up..");
      final res = await http.post(
        Uri.parse('$basicUri/signup/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJSON(user)),
      );
      if (res.statusCode == 200)
        return jsonDecode(res.body);
      else
        throw Exception("Failed to register");
    // }
    // else{
    //   final res = await http.post(
    //     Uri.parse('$basicUri/signup/uni/'),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(user.toJSON(user)),
    //   );
    //   if (res.statusCode == 200)
    //     return jsonDecode(res.body);
    //   else
    //     throw Exception("Failed to register");
    // }


  }

  Future signIn(User user) async {
  // if(isStudent){
  //
  //
  // }
      final res = await http.post(
        Uri.parse('$basicUri/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJSONLogIn(user)),
      );

      if (res.statusCode == 200)
        return jsonDecode(res.body);
      else
        throw Exception("Failed to login");

  }


  Future storeUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("auth_token", auth_token!);
    prefs.setBool("isStudent", isDoctor!);
  }


  Future removeUser () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("auth_token");
    prefs.remove("isStudent");

  }



}