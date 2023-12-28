import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sampleemployee/controller/getdata_controller.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController salaryController = TextEditingController();
final TextEditingController ageController = TextEditingController();

class HomeView extends StatelessWidget {
  HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<getController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff004237),

        ///title:Text("Employee Data"),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('ADD DATA'),
                    content: SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          Container(
                            height: 50.0,

                            // Adjust the height as needed
                            child: TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                hintText: "Employee Name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            height: 50.0, // Adjust the height as needed
                            child: TextField(
                              controller: salaryController,
                              decoration: const InputDecoration(
                                hintText: "Employee Salary",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            height: 50.0, // Adjust the height as needed
                            child: TextField(
                              controller: ageController,
                              decoration: const InputDecoration(
                                hintText: "Employee Age",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              onPressed: () {
                                if (nameController.text != null &&
                                    nameController.text.isNotEmpty &&
                                    ageController.text != null &&
                                    ageController.text.isNotEmpty &&
                                    salaryController.text != null &&
                                    salaryController.text.isNotEmpty) {
                                  int salary = int.parse(salaryController.text);
                                  int? age = int.parse(ageController.text);
                                  if (salary != null && age != null) {
                                    controller.addtoSubmit(context,
                                        nameController.text, salary, age);
                                    Navigator.pop(context);
                                    //   print("successfully added  ${controller.message}");
                                    Fluttertoast.showToast(
                                        msg: controller.message,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    nameController.clear();
                                    ageController.clear();
                                    salaryController.clear();
                                  } else {
                                    print("its null");
                                  }
                                }
                              },
                              child: const Text('Submit'))),
                    ],
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 25),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Consumer<getController>(
          builder: (context, value, child) => Column(
            children: [
              const Text(
                "List of Employee",
                style: TextStyle(fontSize: 25, color: Colors.amber),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: GridView.builder(
                  physics: const ScrollPhysics(),
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  cacheExtent: 999999999,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.h,
                    crossAxisSpacing: 10.w,
                    childAspectRatio: 157 / 202,
                  ),
                  itemCount: value.employedata.length,
                  itemBuilder: (BuildContext context, int index) {
                    var employee = value.employedata[index];
                    return employeeWidget(
                      text: employee.employeeName.toString(),
                      salary: employee.employeeSalary,
                      age: employee.employeeAge,
                      editontapped: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('EDIT DATA'),
                              content: SizedBox(
                                height: 200,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50.0,

                                      // Adjust the height as needed
                                      child: TextField(
                                        controller: nameController,
                                        decoration: const InputDecoration(
                                          hintText: "Employee Name",
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      height:
                                          50.0, // Adjust the height as needed
                                      child: TextField(
                                        controller: salaryController,
                                        decoration: const InputDecoration(
                                          hintText: "Employee Salary",
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      height:
                                          50.0, // Adjust the height as needed
                                      child: TextField(
                                        controller: ageController,
                                        decoration: const InputDecoration(
                                          hintText: "Employee Age",
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                        onPressed: () async{
                                          if (nameController.text != null &&
                                              nameController.text.isNotEmpty &&
                                              ageController.text != null &&
                                              ageController.text.isNotEmpty &&
                                              salaryController.text != null &&
                                              salaryController
                                                  .text.isNotEmpty) {
                                            int salary = int.parse(
                                                salaryController.text);
                                            int? age =
                                                int.parse(ageController.text);
                                            if (salary != null && age != null) {
                                              int employeeId = employee.id;

                                              // Updated data for the employee
                                              Map<String, dynamic> updatedData =
                                                  {
                                                "name": nameController.text,
                                                // Replace with your updated data
                                                "salary": salaryController.text,
                                                "age": ageController.text,
                                              };
                                              // Update the employee data using the provider
                                             await value.updateEmployee(
                                                  employeeId, updatedData);

                                              Navigator.pop(context);
                                               print("======${controller.updateMsg}");
                                              //   print("successfully added  ${controller.message}");
                                              Fluttertoast.showToast(
                                                  msg: controller.updateMsg,
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              nameController.clear();
                                              ageController.clear();
                                              salaryController.clear();
                                            } else {
                                              print("its null");
                                            }
                                          }
                                        },
                                        child: const Text('Submit'))),
                              ],
                            );
                          },
                        );
                      },
                      deleteonTapped: () async{
                        int employeeId = employee.id;
                       await value.deleteData(employeeId);
                        //print("======${controller.deleteMsg}");
                        Fluttertoast.showToast(
                            msg: controller.deleteMsg,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class employeeWidget extends StatelessWidget {
  const employeeWidget({
    super.key,
    required this.text,
    required this.salary,
    required this.age,
    required this.editontapped,
    required this.deleteonTapped,
  });
  final String text;
  final num salary;
  final num age;
  final Function() editontapped;
  final Function() deleteonTapped;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
      height: 210.h,
      width: 150.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 100.h,
                  width: 80.w,
                  color: Colors.red,
                  child: Image.asset(
                    'assets/images/employee.png',
                    fit: BoxFit.fill,
                  )),
              Column(
                children: [
                  InkWell(
                    onTap: editontapped,
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: deleteonTapped,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
          ),
          Text("Salary : $salary",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w200)),
          Text("Age : $age",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w200))
        ],
      ),
    );
  }
}
