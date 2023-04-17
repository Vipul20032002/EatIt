import 'dart:convert';

import 'package:eatit/Controllers/cart_controller.dart';
import 'package:eatit/Util/AppConstants.dart';
import 'package:eatit/Widgets/BigText.dart';
import 'package:eatit/Widgets/SmallText.dart';
import 'package:eatit/Widgets/app_icon.dart';
import 'package:eatit/base/no_data_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../Models/cart_model.dart';
import '../../Routes/route_helper.dart';
import '../../Util/colors.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String,int> cartItemsPerOrder = Map();

    for(var element in getCartHistoryList){

      if(cartItemsPerOrder.containsKey(element.time)){
        cartItemsPerOrder.update(element.time!,(value)=>++value);
      }

      else{
        cartItemsPerOrder.putIfAbsent(element.time!,()=>1);
      }
    }

    List<int> cartItemsPerOrderList(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    }

    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderList();
    var saveCounter=0;

    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if (index<getCartHistoryList.length) {
        DateTime parseData = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[saveCounter].time!);
        var inputDate = DateTime.parse(parseData.toString());
        var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate,size: 17);
    }


    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 35,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History",color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined,)
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistoryList().length>0?Expanded(
              child: Container(
                  margin: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20
                  ),

                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context, child: ListView(
                    children: [
                      for(int i=0;i<itemsPerOrder.length;i++)
                        Container(
                          height: 120,
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(saveCounter ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOrder[i] , (index){
                                      if(saveCounter<getCartHistoryList.length){
                                        saveCounter++;
                                      }
                                      return index<=2?Container(
                                        margin: EdgeInsets.only(right: 5),
                                        height: 75,
                                        width: 75,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[saveCounter-1].img!
                                                )
                                            )
                                        ),
                                      ):Container();
                                    }),
                                  ),
                                  Container(
                                    height: 85,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(text: "Total",color: AppColors.titleColor,),
                                        BigText(text: itemsPerOrder[i].toString() + " Items",color: AppColors.titleColor,size: 18,),
                                        GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(width: 1,color: AppColors.mainColor),
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 7,vertical: 5),
                                            child: SmallText(text: "Order Again",color: AppColors.mainColor,),
                                          ),

                                          onTap: (){
                                            var orderTime = cartOrderTimeToList();
                                            Map<int,CartModel> moreOrder = {};
                                            for(int j=0;j<getCartHistoryList.length;j++){
                                              if(getCartHistoryList[j].time==orderTime[i]){
                                                moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                    CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                );
                                              }
                                            }
                                            Get.find<CartController>().setItems = moreOrder;
                                            Get.find<CartController>().addToCartList();
                                            Get.toNamed(RouteHelper.getCartPage());
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  ),)
              ),
            ):NoDataPage(text: "History is Empty!",img_path: "assets/images/History-Empty.png");
          })
        ],
      ),
    );
  }
}
