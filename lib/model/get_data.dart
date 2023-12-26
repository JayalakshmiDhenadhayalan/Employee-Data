// To parse this JSON data, do
//
//     final getEmployeeData = getEmployeeDataFromJson(jsonString);

import 'dart:convert';

GetEmployeeData getEmployeeDataFromJson(String str) => GetEmployeeData.fromJson(json.decode(str));

String getEmployeeDataToJson(GetEmployeeData data) => json.encode(data.toJson());

class GetEmployeeData {
    final String status;
    final List<Datum> data;
    final String message;

    GetEmployeeData({
        required this.status,
        required this.data,
        required this.message,
    });

    factory GetEmployeeData.fromJson(Map<String, dynamic> json) => GetEmployeeData(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum {
    final int id;
    final String employeeName;
    final int employeeSalary;
    final int employeeAge;
    final String profileImage;

    Datum({
        required this.id,
        required this.employeeName,
        required this.employeeSalary,
        required this.employeeAge,
        required this.profileImage,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        employeeName: json["employee_name"],
        employeeSalary: json["employee_salary"],
        employeeAge: json["employee_age"],
        profileImage: json["profile_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employee_name": employeeName,
        "employee_salary": employeeSalary,
        "employee_age": employeeAge,
        "profile_image": profileImage,
    };
}







///update data
///
