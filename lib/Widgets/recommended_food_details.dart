import 'package:eatit/Controllers/popular_product_controller.dart';
import 'package:eatit/Controllers/recommended_product_controller.dart';
import 'package:eatit/Pages/Cart/cart_page.dart';
import 'package:eatit/Routes/route_helper.dart';
import 'package:eatit/Util/AppConstants.dart';
import 'package:eatit/Widgets/ExpandableText.dart';
import 'package:eatit/Widgets/app_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controllers/cart_controller.dart';
import '../Util/colors.dart';
import 'BigText.dart';

class RecommendedFood extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFood({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      //Get.toNamed(RouteHelper.initial);
                      if(page == "cartpage"){
                        Get.toNamed(RouteHelper.cartPage);
                      }

                      else{
                        Get.toNamed(RouteHelper.initial);
                      }
                    },
                    child: AppIcon(icon: Icons.clear)
                ),
                //AppIcon(icon: Icons.shopping_cart )
                GetBuilder<PopularProductController>(builder: (controller){
                  return Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart),
                      Get.find<PopularProductController>().totalItems>=1?
                       Positioned(
                          right: 0,top: 0,
                          child: GestureDetector(
                            child: AppIcon(icon: Icons.circle,size: 20,
                                iconColor: Colors.transparent,
                                bgColor: AppColors.mainColor
                            ),

                            onTap: (){
                              if (controller.totalItems>=1) {
                                Get.toNamed(RouteHelper.getCartPage());
                              }
                            }
                          )
                      ):
                      Container(),
                      Get.find<PopularProductController>().totalItems>=1?
                      Positioned(
                          right: 5,top: 3,
                          child: BigText(
                              text: Get.find<PopularProductController>().totalItems.toString(),
                              color: Colors.white,
                              size: 12
                          )
                      ):Container()
                    ],
                  );
                }),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(child: BigText(text: product.name!,size: 26),

                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)
                  )
                ),
              )
            ),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),

            ),
          ),
           SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20 ),
                  child: ExpandableText(text:product.description!),
                )
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: 50,right: 50,top: 10,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: AppIcon(
                        icon: Icons.remove,
                        bgColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: 24
                    ),
                    onTap: (){
                      controller.setQuantity(false);
                    },
                  ),
                  BigText(text: "\$ ${product.price!} X ${controller.cartItems}",color: AppColors.mainBlackColor),
                  GestureDetector(
                    child: AppIcon(
                        icon: Icons.add,
                        bgColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: 24
                    ),
                    onTap: (){
                      controller.setQuantity(true);
                    },
                  )
                ],
              ),
            ),

            Container(
              height: 120,
              padding: EdgeInsets.only(top: 30,bottom: 30,left: 20,right: 20),
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: AppColors.buttonBackgroundColor
              ),

              child: Row(
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
                        Icon(Icons.favorite,
                          color: AppColors.mainColor,)
                      ],
                    ),
                  ),
                  GestureDetector(

                    onTap: (){
                      controller.addItem(product);
                    },

                    child: Container(
                      padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.mainColor
                      ),
                      child: BigText(text:"${product.price} \$ | Add to cart",color: Colors.white,weight: FontWeight.w400,size: 18),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      })
    );
  }
}


