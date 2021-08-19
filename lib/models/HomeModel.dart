import 'dart:collection';

class HomeModel{
   bool? status ;
   DataModel? data ;

  //named Constructor
  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data =  DataModel.fromJson(json['data']);
  }

}

class DataModel {
   List<BannerModel> banners  =[];
   List<ProductModel> products =[] ;

  DataModel.fromJson(Map<String,dynamic> json){
    json['banners']!.forEach((element){
      banners.add(BannerModel.fromJson(element));
    });

    json['products']!.forEach((element){
      products.add(ProductModel.fromJson(element));
    });


  }
}

class BannerModel {
  int? id;
  String? image ;


  BannerModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}


class ProductModel {
    late int id ;
     dynamic price ;
     dynamic oldPrice ;
     dynamic discount ;
    String? image ;
    String? name ;
    late bool inFavorites ;
    late bool inCart ;

    ProductModel.fromJson(Map<String,dynamic> json){
      id = json['id'];
      price = json['price'];
      oldPrice = json['old_price'];
      discount = json['discount'];
      image = json['image'];
      name = json['name'];
      inFavorites = json['in_favorites'];
      inCart = json['in_cart'];

    }
  }