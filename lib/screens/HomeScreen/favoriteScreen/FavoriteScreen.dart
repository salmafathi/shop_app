import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/GetFavoritesModel.dart';
import 'package:shop_app/models/HomeModel.dart';
import 'package:shop_app/screens/HomeScreen/HomeCubit/HomeCubit.dart';
import 'package:shop_app/screens/HomeScreen/HomeCubit/HomeStates.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shared/styles/styles.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (BuildContext context, Object? state){},
        builder: (BuildContext context, state) {
          return  state is! GetFavLoadingState ?
            productScreenWidget(cubit.favsModel)
          : Center(child: CircularProgressIndicator(),);
        }
    );
  }

  Widget productScreenWidget(getFavModel? favsModel) {

    return favsModel!.data!.data.isEmpty ?
    Center(child: Text('NO favorites yet !'),)
    : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => productItemWidget(favsModel.data!.data[index],context),
        itemCount: favsModel.data!.data.length,
        separatorBuilder: (BuildContext context, int index)=>SizedBox(height: 15.0,),

      ),
    );
  }

  Widget productItemWidget(FavData favsModel,context) {
    return
      favsModel.product!.discount != 0 ?
      ClipRect  (
        child: Banner(
          message: 'DISCOUNT',
          location: BannerLocation.topStart,
          color: Colors.pink,
          child: productItemWithoutDiscountBanner(favsModel.product,context),
        ),
      )
          : productItemWithoutDiscountBanner(favsModel.product,context);
  }

  Widget productItemWithoutDiscountBanner (FavProduct? product, context){
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 5.0,
          ),
          Image(
            image: NetworkImage('${product!.image}'),
            width: 100,
            height: 100,
          ),
          SizedBox(
            width: 10.0,
          ),

          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      wordSpacing: 1.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${product.oldPrice} \$',
                        style: TextStyle(

                            fontSize: 14.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough)),
                    SizedBox(width: 20.0,),
                    Text('${product.price} \$',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.black,
                        )),
                  ],
                ),
              ],

            ),
          ),

          SizedBox(
                width: 10.0,
              ),

          IconButton(
                color: Colors.amber,
                iconSize: 28.0,
                onPressed: () {
                  HomeCubit.get(context).changeFavorites(product.id);
                },
                icon:Icon(Icons.favorite) ,
                padding: EdgeInsets.all(0),
              ),
          SizedBox(
            width: 5.0,
          ),
            ],
          ),

      );
  }
}
