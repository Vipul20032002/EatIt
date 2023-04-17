import 'package:eatit/Controllers/cart_controller.dart';
import 'package:eatit/Controllers/popular_product_controller.dart';
import 'package:eatit/Data/API/api_client.dart';
import 'package:eatit/Data/Repository/cart_repo.dart';
import 'package:eatit/Data/Repository/popular_food_repo.dart';
import 'package:eatit/Util/AppConstants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/recommended_product_controller.dart';
import '../Data/Repository/recommended_food_repo.dart';

Future<void> init()async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));

  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}