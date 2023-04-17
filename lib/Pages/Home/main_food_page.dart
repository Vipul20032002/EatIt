import 'package:eatit/Pages/Home/food_page_body.dart';
import 'package:eatit/Widgets/BigText.dart';
import 'package:eatit/Widgets/SmallText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Util/colors.dart';
class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: 45, bottom: 15),
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          BigText(text: 'India',color: AppColors.mainColor,),
                          Row(
                            children: [
                              SmallText(text: ' Pune',),
                              Icon(Icons.arrow_drop_down,color: Colors.black,)
                            ],
                          )
                        ],
                      ),
                      Container(
                        width: 45,
                        height: 45,

                        child: Icon(Icons.search , color: Colors.white),

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.mainColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: SingleChildScrollView(child: FoodPageBody()))
        ],
      ),
    );
  }
}
