import 'package:dots_indicator/dots_indicator.dart';
import 'package:eatit/Controllers/popular_product_controller.dart';
import 'package:eatit/Controllers/recommended_product_controller.dart';
import 'package:eatit/Models/popular_products_model.dart';
import 'package:eatit/Pages/Food/PopularFood.dart';
import 'package:eatit/Routes/route_helper.dart';
import 'package:eatit/Util/AppConstants.dart';
import 'package:eatit/Util/Dimensions.dart';
import 'package:eatit/Util/colors.dart';
import 'package:eatit/Widgets/BigText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/SmallText.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
       setState(() {
         _currPageValue = pageController.page!;
         print('Current values is ${_currPageValue.toString()}');
       });
    });
  }

  @override void dispose() {
    super.dispose();
    // TODO: implement dispose
    pageController.dispose();
  }

  PageController pageController = PageController(viewportFraction: 0.9);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Slider Section
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return popularProducts.isLoaded?Container(
            height: Dimensions.pageView,
            child: PageView.builder(
                controller: pageController,
                itemCount: popularProducts.popularProductList.length,
                itemBuilder: (context,position){
                  return _buildPageItem(position,popularProducts.popularProductList[position]);
                }),
          ):const CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),

        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeColor: AppColors.mainColor,
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),

        //Popular Text
        const SizedBox(height: 30),
        Container(
          margin: EdgeInsets.only(left: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".",color: Colors.black26,)
              ),
              SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food Pairing"),
              )
            ],
          )
        ),

        //Recommended List
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
            return recommendedProduct.isLoaded?ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recommendedProduct.recommendedProductList.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
                      },
                    child: Container(
                      margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                      child: Row(
                        children: [
                          //Image Section
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white38,
                                image:   DecorationImage(
                                    image: NetworkImage(
                                        AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
                                    ),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),

                          //Text Section
                          Expanded(
                            child: Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)
                                ),
                                color: Colors.white,
                              ),

                              child: Padding(
                                padding: const EdgeInsets.only(left:10,right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 2),
                                    BigText(text:recommendedProduct.recommendedProductList[index].name!,size: 17),
                                    const SizedBox(height: 10),

                                    Row(
                                      children: [
                                        SizedBox(width: 5),
                                        const Icon(Icons.workspace_premium_outlined,size: 15,color: Color(0xFFffd700),),
                                        const SizedBox(width: 5),
                                        SmallText(text: "Free delivery with premium"),
                                      ],
                                    ),

                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        SizedBox(width: 7),
                                        Row(
                                          children: [
                                            Icon(Icons.circle,color: AppColors.yellowColor,size: 15),
                                            SizedBox(width: 5),
                                            SmallText(text: "Normal",size: 10)
                                          ],
                                        ),
                                        SizedBox(width: 5),

                                        Row(
                                          children: [
                                            Icon(Icons.location_on,color: AppColors.mainColor,size: 15),
                                            SizedBox(width: 5),
                                            SmallText(text: "1.7km",size: 10)
                                          ],
                                        ),
                                        SizedBox(width: 5),

                                        Row(
                                          children: [
                                            Icon(Icons.access_time_rounded,color: AppColors.iconColor2,size: 15),
                                            SizedBox(width: 5),
                                            SmallText(text: "32min",size: 10)
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],

                      ),
                    ),
                  );
                }):CircularProgressIndicator(
              color: AppColors.mainColor,
            );
          })
      ],
    );
  }

  Widget _buildPageItem(int index,ProductModel popularProduct){
    Matrix4 matrix = new Matrix4.identity();
    if(index == _currPageValue.floor()){
      var currScale = 1-(_currPageValue - index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else if(index == _currPageValue.floor() + 1){
      var currScale = _scaleFactor  + (_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else if(index == _currPageValue.floor() - 1){
      var currScale = 1-(_currPageValue - index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){

              Get.toNamed(RouteHelper.getPopularFood(index,"home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: 5,right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: 35,right: 35,bottom: 20),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0XFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(5,5)
                  ),

                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0)
                  )
                ]
              ),

              child: Container(
                padding: EdgeInsets.only(top: 15,left: 15,right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: popularProduct.name!),
                    SizedBox(height: 10),

                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor, size: 15,)),
                        ),
                        SizedBox(width: 10),
                        SmallText(text: "4.5"),
                        SizedBox(width: 10),
                        SmallText(text: "1287 comments")
                      ],
                    ),
                    SizedBox(height: 15),

                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.circle,color: AppColors.yellowColor,size: 20),
                            SizedBox(width: 5),
                            SmallText(text: "Normal")
                          ],
                        ),
                        SizedBox(width: 20),

                        Row(
                          children: [
                            Icon(Icons.location_on,color: AppColors.mainColor,size: 20),
                            SizedBox(width: 5),
                            SmallText(text: "1.7km")
                          ],
                        ),
                        SizedBox(width: 20),

                        Row(
                          children: [
                            Icon(Icons.access_time_rounded,color: AppColors.iconColor2,size: 20),
                            SizedBox(width: 5),
                            SmallText(text: "32min")
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

