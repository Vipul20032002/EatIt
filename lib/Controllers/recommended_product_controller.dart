import 'package:eatit/Models/popular_products_model.dart';
import 'package:get/get.dart';

import '../Data/Repository/popular_food_repo.dart';
import '../Data/Repository/recommended_food_repo.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded=>_isLoaded;

  Future<void> getRecommendedProductList() async{
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200){

      print("got products recommended");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      //print(_popularProductList);
      update();
    }
    else{
      print("could not get products recommended. System code ${response.statusCode}");
    }
  }
}