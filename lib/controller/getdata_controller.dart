import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sampleemployee/model/get_data.dart';

class getController extends ChangeNotifier {
  
GetEmployeeData?  _employeeList ;

 GetEmployeeData? get employeeList => _employeeList;
  bool orderLoading = false;

  getEmployeeData(BuildContext context) async {
    orderLoading = true;
    notifyListeners();

    var url = 'https://dummy.restapiexample.com/api/v1/employees';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      orderLoading = false;
      _employeeList = getEmployeeDataFromJson(response.body);
    //  employeeList = getEmployeeData.data;
      print("++++++++++++++++++++$_employeeList");
      notifyListeners();
    } else {
      orderLoading = false;
      notifyListeners();
    }
  }

  Future addtoSubmit(BuildContext context,String empName,
  int empSalary,int empAge) async{

    final url='https://dummy.restapiexample.com/api/v1/create';
 final body = {
      "name": empName,
      "salary": empSalary,
      "age": empAge,
    };
    final response=await http.post(Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body)
     
      );
      notifyListeners();
      if(response.statusCode==200){
        print("success");
        notifyListeners();

      }else{
            print("failure");
        notifyListeners();
      }
      notifyListeners();
  }



}
