import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                    title: Text('ADD DATA'),
                    content: SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          Container(
                            height: 50.0,

                            // Adjust the height as needed
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
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
                              decoration: InputDecoration(
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
                              decoration: InputDecoration(
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
                                controller.addtoSubmit(context,
                                nameController.text,
                                salaryController.text);
                                Navigator.pop(context);
                              },
                              child: Text('Submit'))),
                   
                    ],
                  );
                },
              );
            },
            child: Padding(
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
                  itemCount: value.employeeList?.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var employee = value.employeeList?.data[index];
                    return employeeWidget(
                      text: employee!.employeeName.toString(),
                      salary: employee.employeeSalary,
                      age: employee.employeeAge,
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
  });
  final String text;
  final num salary;
  final num age;
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
                  Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Icon(
                    Icons.delete,
                    color: Colors.black,
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
