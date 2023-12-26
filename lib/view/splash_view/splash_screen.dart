import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sampleemployee/controller/getdata_controller.dart';
import 'package:sampleemployee/view/home_view/home_view.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Provider.of<getController>(context, listen: false)
        .getEmployeeData(context);

   
    });
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  HomeView(),
          )),
    );
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final maxheight = MediaQuery.of(context).size.height;
    final maxwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
            child: SizedBox(
                height: maxheight * .4,
                width: maxwidth * .8,
                child: Text('Splash')
                
                )));
  }
}
