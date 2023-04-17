import 'package:eatit/Controllers/cart_controller.dart';
import 'package:eatit/Models/popular_products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Data/Repository/popular_food_repo.dart';
import '../Models/cart_model.dart';
import '../Util/colors.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded=>_isLoaded;

  int _quantity = 0;
  int get quantity=> _quantity;
  int _cartItems=0;
  int get cartItems => _cartItems+_quantity;

  Future<void> getPopularProductList() async{
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){

      print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      //print(_popularProductList);
      update();
    }
    else{

    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      print("quantity updated to $quantity");
      _quantity++;
    }
    else{
      if ((cartItems/*+_quantity*/)>0) {
        _quantity = _quantity-1;
      }
      else {
        Get.snackbar( "Item Count", "No items selected!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white
        );
        _quantity = _quantity;
      }
    }
    update();
  }

  void initProduct(ProductModel product,CartController cart){
    _quantity=0;
    _cartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if(exist){
      _cartItems=_cart.getQuantity(product);
    }

  }

  void addItem(ProductModel product){
    /*if(quantity==0){

    }*/
    //else{
      _cart.addItem(product, quantity);
      _quantity=0;
      _cartItems =_cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        print("Id of the product ${value.id}, quantity of the product ${value.quantity}");
      });
    //}
    update();
  }

  int get totalItems {
    return _cart.TotalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}