import 'dart:async';

import 'package:eatit/Routes/route_helper.dart';
import 'package:eatit/Util/Dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controllers/popular_product_controller.dart';
import '../../Controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double>animation;
  late AnimationController controller;
  Future<void>_loadResources() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadResources();
    controller = AnimationController(vsync: this,duration: Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(
      const Duration(seconds: 5),
      ()=>Get.offNamed(RouteHelper.getInitial())
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(child: Center(
              child: Image.asset("assets/images/logo-1.png",width: Dimensions.splashScreenHeight,height: Dimensions.splashScreenHeight),
          ),
            scale: animation,
          ),
          Center(child: Image.asset("assets/images/logo-text.png",width: Dimensions.splashScreenHeight,height: 100))
        ],
      ),
    );
  }
}
