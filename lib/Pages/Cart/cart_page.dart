import 'package:eatit/Controllers/cart_controller.dart';
import 'package:eatit/Controllers/popular_product_controller.dart';
import 'package:eatit/Pages/Home/main_food_page.dart';
import 'package:eatit/Util/AppConstants.dart';
import 'package:eatit/Widgets/BigText.dart';
import 'package:eatit/Widgets/SmallText.dart';
import 'package:eatit/Widgets/app_icon.dart';
import 'package:eatit/base/no_data_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../Controllers/recommended_product_controller.dart';
import '../../Routes/route_helper.dart';
import '../../Util/colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            top: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  AppIcon(icon: Icons.arrow_back,
                  iconColor: Colors.white,
                  bgColor: AppColors.mainColor,
                  iconSize: 24),

                  SizedBox(width: 100),
                  GestureDetector(
                    child: AppIcon(icon: Icons.home,
                        iconColor: Colors.white,
                        bgColor: AppColors.mainColor,
                        iconSize: 24),

                    onTap: (){
                      Get.toNamed(RouteHelper.initial);
                    },
                  ),

                  AppIcon(icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      bgColor: AppColors.mainColor,
                      iconSize: 24),
                ],
          )),

          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
                top: 120,
                left: 20,
                right: 20,
                bottom: 0,
                child: Container(
                  //color: Colors.black,
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder: (cartController){
                        var cartList = cartController.getItems;
                        return ListView.builder(
                            itemCount: cartList.length,
                            itemBuilder: (_,index){
                              return Container(
                                margin: EdgeInsets.only(top: 15),
                                height: 110,
                                width: double.maxFinite,

                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap:(){
                                        var popularIndex =
                                        Get.find<PopularProductController>().popularProductList.
                                        indexOf(cartList[index].product!);

                                        if(popularIndex>=0){
                                          Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                        }

                                        else{
                                          var recommendedIndex =
                                          Get.find<RecommendedProductController>().recommendedProductList.
                                          indexOf(cartList[index].product!);


                                          if(recommendedIndex<0){
                                            Get.snackbar("History Product",
                                                "Product preview is not available for history products",
                                                backgroundColor: AppColors.mainColor,
                                                colorText: Colors.white
                                            );
                                          }

                                          else{
                                            Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                          }

                                        }


                                      },
                                      child: Container(

                                        width: 100,
                                        height: 100,
                                        margin: EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                                ),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(child: Container(
                                      height: 100,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            text: cartController.getItems[index].name!,
                                            color: Colors.black54,
                                          ),
                                          SmallText(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text: "\$" + cartController.getItems[index].price.toString(),
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: Colors.white
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: (){
                                                          cartController.addItem(cartList[index].product!,-1);
                                                          print("Button Tapped");
                                                        },
                                                        child: Icon(Icons.remove,color: AppColors.signColor)
                                                    ),
                                                    SizedBox(width: 5),
                                                    BigText(text: cartList[index].quantity.toString()),//'${popularProduct.cartItems}'),
                                                    SizedBox(width: 5),
                                                    GestureDetector(
                                                        child: Icon(Icons.add,color: AppColors.signColor,),
                                                        onTap: (){
                                                          cartController.addItem(cartList[index].product!,1);
                                                          print("Button Tapped");
                                                        }
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 1)
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              );
                            });
                      })
                  ),
                )
            ):NoDataPage(text: "Your Cart is empty!");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
          return Container(
            height: 120,
            padding: EdgeInsets.only(top: 30,bottom: 30,left: 20,right: 20),
            decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: AppColors.buttonBackgroundColor
            ),

            child: cartController.getItems.length>0?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      BigText(text: cartController.totalAmount.toString()+"\$"),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.mainColor
                  ),
                  child: GestureDetector(
                    child: BigText(
                        text:"Check-Out",
                        color: Colors.white,
                        weight: FontWeight.w400,
                        size: 18
                    ),

                    onTap: (){
                      //popularProduct.addItem(product);
                      cartController.addToHistory();
                    },
                  ),
                )
              ],
            ): Container()
          );
        },)
    );
  }
}
