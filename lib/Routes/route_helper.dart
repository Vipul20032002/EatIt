import 'package:eatit/Pages/Cart/cart_page.dart';
import 'package:eatit/Pages/Food/PopularFood.dart';
import 'package:eatit/Pages/Home/main_food_page.dart';
import 'package:eatit/Pages/Splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Pages/Home/home_page.dart';
import '../Widgets/recommended_food_details.dart';

class RouteHelper{
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page)=> '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page)=> '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage()=> '$cartPage';

  static List<GetPage> routes = [
    
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: initial, page: ()=>HomePage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFood(pageId: int.parse(pageId!),page: page!);
        },
        transition: Transition.fadeIn
    ),
    GetPage(name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFood(pageId: int.parse(pageId!),page: page!);
        },
        transition: Transition.fadeIn
    ),
    GetPage(name: cartPage,
      page: (){
        return CartPage();
      },

      transition: Transition.fadeIn
      ),
  ];
}