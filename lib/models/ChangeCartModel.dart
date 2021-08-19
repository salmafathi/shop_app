class ChangeCartModel {

  late bool status ;
  late String message ;
  late ChangeCartData  changedData ;


  ChangeCartModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    changedData = ChangeCartData.fromJson(json['data']);
  }

}


class ChangeCartData{
  ChangeCartProduct? product ;
  ChangeCartData.fromJson(Map<String,dynamic> json){
    product = ChangeCartProduct.fromJson(json['product']);
  }

}

class ChangeCartProduct{
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;

  ChangeCartProduct.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}