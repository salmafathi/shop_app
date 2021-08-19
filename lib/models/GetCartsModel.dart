class getCartsModel {
  late bool status;
  String? message;
  DataCart? data;


  getCartsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =  DataCart.fromJson(json['data']);
  }


}

class DataCart {
  List<CartItems> cartItems = [];

  DataCart.fromJson(Map<String, dynamic> json) {

        json['cart_items'].forEach((v) {
        cartItems.add(CartItems.fromJson(v));
      });

  }

}

class CartItems {

  late CartProduct product;

   CartItems.fromJson(Map<String, dynamic> json) {
    product = CartProduct.fromJson(json['product']);
  }

}

class CartProduct {
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
 // List<String>? images;
  bool? inFavorites;
  bool? inCart;

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  //  images = json['images'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}
