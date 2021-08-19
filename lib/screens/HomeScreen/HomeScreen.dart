import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/LoginModel.dart';
import 'package:shop_app/screens/HomeScreen/HomeCubit/HomeCubit.dart';
import 'package:shop_app/screens/HomeScreen/HomeCubit/HomeStates.dart';
import 'package:shop_app/screens/HomeScreen/searchScreen/SearchScreen.dart';
import 'package:shop_app/screens/HomeScreen/settingsScreen/SettingsScreen.dart';
import 'package:shop_app/screens/ProfileScreen/ProfileScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData()..getCategoriesData()..getFavoritesModel()..getCartModel()..getLoginModel(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (BuildContext context, Object? state) {
          if(state is FavoritesSuccessState){
            makeToast('${state.changeFavModel!.message}');
          }
          else if (state is CartChangeSuccessState){
            makeToast('${state.changeCartModel!.message}');
          }
          else if (state is GetProfileSuccessState){

          }
        },
        builder: (BuildContext context, state){
          var cubit = HomeCubit.get(context);
          return cubit.loginModel != null ?
          Scaffold(
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                      color: primaryColor,
                    ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(backgroundImage:  NetworkImage(cubit.loginModel!.data!.image.toString()),
                          maxRadius: 40.0,),
                          SizedBox(height: 10.0,),
                          Text(cubit.loginModel!.data!.name.toString(),style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Janna',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold
                          ),)
                           ]),


                          ),

                  ListTile(onTap: (){
                    navigateTo(context, ProfileScreen());
                  },
                          title: Text('Profile',style:TextStyle(fontSize: 16.0, fontFamily: 'Janna')),
                          leading: Icon(Icons.person) ,
                          contentPadding:EdgeInsets.symmetric(horizontal: 10.0) ,

                  ),

                  ListTile(onTap: (){
                    signOutFun(context);
                  },
                    title: Text('Log out',style:TextStyle(fontSize: 16.0, fontFamily: 'Janna')),
                    leading: Icon(Icons.logout) ,
                    contentPadding:EdgeInsets.symmetric(horizontal: 10.0) ,

                  ),
                        ],
                      ),

                  ),

            appBar: AppBar(
              title: Text('Super Shop'),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),onPressed: (){
                    navigateTo(context, SearchScreen());
                },),
                // IconButton(
                //   icon: Icon(Icons.view_headline_sharp),onPressed: (){
                //   navigateTo(context, SearchScreen());
                // },),
              ],
            ),
            body: cubit.bottomNavScreens[cubit.currentBottomNavIndex] ,
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeBottomNav(index);
                },
              currentIndex: cubit.currentBottomNavIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home',activeIcon: Icon(Icons.home),),
                BottomNavigationBarItem(icon: Icon(Icons.widgets_outlined),label: 'Categories',activeIcon: Icon(Icons.widgets),),
                bottomNavItem(icon: Icon(Icons.favorite_border_outlined),label: '',activeIcon: Icon(Icons.favorite),counter: cubit.counter),
                bottomNavItem(icon: Icon(Icons.shopping_cart_outlined),label: '',activeIcon: Icon(Icons.shopping_cart),counter:cubit.counterCart),
              ],

            ),
          )
              :Center(child: CircularProgressIndicator(),);
        },

      ),
    );
  }




  BottomNavigationBarItem bottomNavItem ({
    required Icon icon ,
    required String label ,
    required Icon activeIcon ,
    int? counter,
})
  {
    return BottomNavigationBarItem(
      icon: new Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
              child: icon,
            ),
            counter! > 0 ? new Positioned(
            right: 8,
            top: 5,
            child: new Container(
              padding: EdgeInsets.all(1),
              decoration: new BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(15),
              ),
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: new Text(
                '$counter',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize:12,
                  fontFamily: 'Janna'
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ) :SizedBox()
        ],
      ),
      label: label,
      activeIcon:  new Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
            child: activeIcon,
          ),
          counter> 0 ? new Positioned(
            right: 8,
            top: 5,
            child: new Container(
              padding: EdgeInsets.all(1),
              decoration: new BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(15),
              ),
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: new Text(
                '$counter',
                style: new TextStyle(
                    color: Colors.white,
                    fontSize:12,
                    fontFamily: 'Janna'
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ) :SizedBox()
        ],
      ),
    );
  }

}
