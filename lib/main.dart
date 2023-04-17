import 'package:eatit/Controllers/cart_controller.dart';
import 'package:eatit/Controllers/popular_product_controller.dart';
import 'package:eatit/Controllers/recommended_product_controller.dart';
import 'package:eatit/Pages/Cart/empty_cart.dart';
import 'package:eatit/Widgets/recommended_food_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Pages/Cart/cart_page.dart';
import 'Pages/Food/PopularFood.dart';
import 'Pages/Home/food_page_body.dart';
import 'Pages/Home/main_food_page.dart';
import 'Helper/Dependencies.dart' as dep;
import 'Pages/Splash/splash_page.dart';
import 'Routes/route_helper.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),


          //home: MainFoodPage(),
          initialRoute: RouteHelper.getSplashPage(),
          //home:SplashScreen(),
          getPages: RouteHelper.routes,



        );
      });
    });
  }
}