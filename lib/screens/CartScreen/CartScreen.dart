import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/GetCartsModel.dart';
import 'package:shop_app/screens/HomeScreen/HomeCubit/HomeCubit.dart';
import 'package:shop_app/screens/HomeScreen/HomeCubit/HomeStates.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (BuildContext context, Object? state){},
        builder: (BuildContext context, state) {
          return  state is! GetCartLoadingState ?
               cartScreenWidget(cubit.getcartsModel)
              : Center(child: CircularProgressIndicator(),);
        }
    );
  }

  Widget cartScreenWidget(getCartsModel cartsModel) {
    return cartsModel.data!.cartItems.isEmpty ?
    Center(child: Text('NO products in cart yet !'),)
      : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => productItemWidget(cartsModel.data!.cartItems[index],context),
        itemCount: cartsModel.data!.cartItems.length,
        separatorBuilder: (BuildContext context, int index)=>SizedBox(height: 15.0,),

      ),
    );
  }

  Widget productItemWidget(CartItems cartItem,context) {
    return
      cartItem.product.discount != 0 ?
      ClipRect  (
        child: Banner(
          message: 'DISCOUNT',
          location: BannerLocation.topStart,
          color: Colors.pink,
          child: productItemWithoutDiscountBanner(cartItem.product,context),
        ),
      )
          : productItemWithoutDiscountBanner(cartItem.product,context);
  }

  Widget productItemWithoutDiscountBanner (CartProduct product, context){
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 5.0,
          ),
          Image(
            image: NetworkImage('${product.image}'),
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
            width: 5.0,
          ),
          IconButton(
            color: Colors.pink,
            iconSize: 28.0,
            onPressed: () {
              HomeCubit.get(context).changeCart(product.id);
            },
            icon: Icon(Icons.remove_shopping_cart),
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
