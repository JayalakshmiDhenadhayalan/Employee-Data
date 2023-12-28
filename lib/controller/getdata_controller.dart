import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sampleemployee/model/get_data.dart';

class getController extends ChangeNotifier {
  GetEmployeeData? _employeeList;

  GetEmployeeData? get employeeList => _employeeList;
  List<Datum> employedata = [];
  getEmployeeData() async {
    notifyListeners();

    var url = 'https://dummy.restapiexample.com/api/v1/employees';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //  employedata= json.decode(response.body)['data'];
      //  print("Response Body: ${response.body}");

      _employeeList = getEmployeeDataFromJson(response.body);
      employedata = _employeeList?.data ?? [];
      // employedata.forEach((e)=>print("the List is ${e.employeeName}"));
      //  employedata=   _employeeList?.toJson();
      //  print("++++++++++++++++++++${_employeeList?.toJson()}");

      // print("++++++++++++++++++++${employedata[0].toJson()}");
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  var message = "";
  Future addtoSubmit(
      BuildContext context, String empName, int empSalary, int empAge) async {
    const url = 'https://dummy.restapiexample.com/api/v1/create';
    final body = {
      "name": empName,
      "salary": empSalary,
      "age": empAge,
    };
    print(body);

    try {
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body));
          // print("+++++++++++++++++++${json.encode(body)}");
          // print("________________${response.body}");
          // print("Status Code: ${response.statusCode}");
      final jsonResponse = json.decode(response.body);
  // print("Status Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        message = jsonResponse['message'];
        print("success added ${message}");

        notifyListeners();
      } else {
        message = 'Failed to add employee.status code:${response.statusCode}';
        // print("failed to add employee .status code:${response.statusCode}");
      }
      notifyListeners();
    } catch (e,stackTrace) {
      message = 'Error:$e';
       print('Stack Trace: $stackTrace');
      // print('Error:$e');
      notifyListeners();
    }
  }

  var updateMsg="";
  Future<void> updateEmployee(
      int employeeId, Map<String, dynamic> updatedData) async {
    try {
      final response = await http.put(
        Uri.parse('https://dummy.restapiexample.com/api/v1/update/$employeeId'),
        body: jsonEncode(updatedData),
        headers: {'Content-Type': 'application/json'},
      );

      print('https://dummy.restapiexample.com/api/v1/update/$employeeId');
      print(updatedData);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        updateMsg = jsonResponse['message'];
        print("7777777$updateMsg");
        // If the update is successful, fetch the updated data
        await getEmployeeData(); // Assuming you have a method to fetch data
        notifyListeners();
      } else {
        // Handle errors
        print(
            'Failed to update employee data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors
      print('Error updating employee data: $error');
    }
  }

  var deleteMsg="";
  Future<void> deleteData(int id) async {
    final response = await http.delete(
        Uri.parse('https://dummy.restapiexample.com/api/v1/delete/$id'));
    final jsonResponse = json.decode(response.body);
    deleteMsg = jsonResponse['message'];
    print("$deleteMsg");
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }
}
