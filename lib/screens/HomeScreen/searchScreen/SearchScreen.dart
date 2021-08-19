import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/SearchModel.dart';
import 'package:shop_app/screens/HomeScreen/HomeCubit/HomeCubit.dart';
import 'package:shop_app/screens/HomeScreen/searchScreen/SearchCubit/SearchCubit.dart';
import 'package:shop_app/screens/HomeScreen/searchScreen/SearchCubit/SearchStates.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/styles.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
        create: (BuildContext context) => SearchCubit(),
        child: BlocConsumer<SearchCubit,SearchStates>(
            listener: (BuildContext context, state) {  },
            builder: (BuildContext context, state) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(),
                body: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                            defaultTextFormField(
                                controller: searchController,
                                keyboardType: TextInputType.text,
                                labelText: 'Search',
                                validator: (text){
                                  if(text!.isEmpty)
                                   { return 'write some text to search about !';}
                                  return null;
                                },
                               prefixIcon: Icon(Icons.search),
                              onSubmit: (text){
                                  SearchCubit.get(context).searchOn(text);
                              },

                            ),

                        SizedBox(height: 10.0,),
                      if(state is SearchLoadingState)
                       LinearProgressIndicator(),
                        SizedBox(height: 20.0,),

                        if(state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) => productItemWithoutDiscountBanner(SearchCubit.get(context).searchModel!.data!.data[index],context),
                            itemCount: SearchCubit.get(context).searchModel!.data!.data.length,
                            separatorBuilder: (BuildContext context, int index)=>SizedBox(height: 15.0,),

                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              );
        }
        ));
  }



  Widget productItemWithoutDiscountBanner (SearchProduct? product, context){
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
            icon:Icon(Icons.favorite_outline) ,
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
