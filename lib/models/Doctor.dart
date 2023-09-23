import 'dart:convert';

class Doctor {

  String? name;
  List<String>? nonWorkingDays;
  List<String>? slots;
  Doctor({
    this.name,
    this.nonWorkingDays,
    this.slots
  });

  factory Doctor.fromJSON(Map<String, dynamic> json_) => Doctor(
    name: json_["name"],
    nonWorkingDays: json.decode(json_["non_working_days"]).cast<String>().toList(),
    slots: json.decode(json_["slots"]).cast<String>().toList(),
  );



}