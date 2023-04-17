import 'package:eatit/Controllers/cart_controller.dart';
import 'package:eatit/Controllers/popular_product_controller.dart';
import 'package:eatit/Pages/Cart/cart_page.dart';
import 'package:eatit/Pages/Home/main_food_page.dart';
import 'package:eatit/Routes/route_helper.dart';
import 'package:eatit/Util/AppConstants.dart';
import 'package:eatit/Widgets/ExpandableText.dart';
import 'package:eatit/Widgets/app_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Util/Dimensions.dart';
import '../../Util/colors.dart';
import '../../Widgets/BigText.dart';
import '../../Widgets/SmallText.dart';

class PopularFood extends StatelessWidget {
  int pageId;
  final String page;
  PopularFood({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //Background Image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImage,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        AppConstants.BASE_URL + AppConstants.UPLOAD_URL+product.img!
                    )
                  )
                ),
          )),
          //Top Icon
          Positioned(
            left: 20,
            right: 20,
            top: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      //Get.toNamed(RouteHelper.getInitial());

                      if(page == "cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }

                      else{
                        Get.toNamed(RouteHelper.getInitial());
                      }

                    },
                    child: AppIcon(icon: Icons.chevron_left)
                ),

                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(

                    onTap:(){
                      //if (controller.totalItems>=1) {
                        Get.toNamed(RouteHelper.cartPage);
                      //}
                    },

                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart),
                        Get.find<PopularProductController>().totalItems>=1?
                          const Positioned(
                              right: 0,top: 0,
                                child: AppIcon(icon: Icons.circle,size: 20,
                                    iconColor: Colors.transparent,
                                    bgColor: AppColors.mainColor
                                ),
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
                    ),
                  );
                }),

              ],
          ),),
          // Introduction
          Positioned(
              left: 0,
              right: 0,
              top: Dimensions.popularFoodImage-20,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)
                    ),
                    color: Colors.white
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: product.name,size: 26),
                          SizedBox(height: 10),

                          Row(
                            children: [
                              Wrap(
                                children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor, size: 15,)),
                              ),
                              SizedBox(width: 3),
                              SmallText(text: "4.5"),
                              SizedBox(width: 20),
                              SmallText(text: "1287 comments")
                            ],
                          ),
                          SizedBox(height: 15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.circle,color: AppColors.yellowColor,size: 20),
                                  SizedBox(width: 5),
                                  SmallText(text: "Normal")
                                ],
                              ),

                              Row(
                                children: [
                                  Icon(Icons.location_on,color: AppColors.mainColor,size: 20),
                                  SizedBox(width: 5),
                                  SmallText(text: "1.7km")
                                ],
                              ),

                              Row(
                                children: [
                                  Icon(Icons.access_time_rounded,color: AppColors.iconColor2,size: 20),
                                  SizedBox(width: 5),
                                  SmallText(text: "32min")
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      BigText(text: "Description"),
                      SizedBox(height: 25),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ExpandableText(text: product.description!),
                        ),
                      )
                    ],
                  )
          ))
        ],
      ),

      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
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
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(Icons.remove,color: AppColors.signColor)
                    ),
                    SizedBox(width: 5),
                    BigText(text: '${popularProduct.cartItems}'),
                    SizedBox(width: 5),
                    GestureDetector(
                        child: Icon(Icons.add,color: AppColors.signColor,),
                        onTap: (){
                          popularProduct.setQuantity(true);
                        }
                    )
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
                      text:"${product.price} \$ | Add to cart",
                      color: Colors.white,
                      weight: FontWeight.w400,
                      size: 18
                  ),

                  onTap: (){
                    popularProduct.addItem(product);
                  },
                ),
              )
            ],
          ),
        );
      },)
    );
  }
}
