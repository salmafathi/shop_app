class ChangeFavoritesModel {

  late bool status ;
  late String message ;
  FavoriteDataModel ? data ;


  ChangeFavoritesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = FavoriteDataModel.fromJson(json['data']);
  }

}


class FavoriteDataModel{
  late int id ;
  FavoriteDataModel.fromJson(Map<String,dynamic> json){
      id = json['id'];
  }

}