import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/HomeScreen/HomeCubit/HomeCubit.dart';
import 'package:shop_app/screens/HomeScreen/HomeCubit/HomeStates.dart';
import 'package:shop_app/screens/HomeScreen/HomeScreen.dart';
import 'package:shop_app/screens/LoginScreen/LoginScreen.dart';
import 'package:shop_app/screens/onboarding/onBoardingScreen.dart';
import 'package:shop_app/shared/Network/local/cache_helper.dart';
import 'package:shop_app/shared/Network/remote/dio_helper.dart';
import 'package:shop_app/shared/blocobserver.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/styles/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  //get data  from shared preference
  await CachHelper.init() ;
  Widget startScreen ;
  bool? onBoard = CachHelper.getDataFromSharedPreference(key: 'onboard');
  token = CachHelper.getDataFromSharedPreference(key: 'token');

  if(onBoard != null)
    {
      if(token==null)
      {
        startScreen = LoginScreen();
      }
      else{
        startScreen = HomeScreen();
      }
    }
  else {startScreen = OnBoardingScreen();}

  runApp(MyApp(startScreen));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  late final Widget startWidgetScreen ;
  MyApp(this.startWidgetScreen);

  @override
  Widget build(BuildContext context) {
        return  MaterialApp(
          title: 'Shop App',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: startWidgetScreen,
        );
  }
}


