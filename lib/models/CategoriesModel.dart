class CategoriesModel {
  bool? status ;
  AllCategoryDataModel? allCategories ;
  CategoriesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    allCategories = AllCategoryDataModel.fromJson(json['data']);
  }

}

class AllCategoryDataModel {
   List<CategoryModel> data = [] ;

  AllCategoryDataModel.fromJson(Map<String,dynamic> json){

    json['data']!.forEach((element){
      data.add(CategoryModel.fromJson(element));
    });
  }

}


class CategoryModel{
  late int id ;
  late String name ;
  late String image ;
  CategoryModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}