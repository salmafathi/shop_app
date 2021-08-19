// Sign out function .
import 'package:shop_app/screens/LoginScreen/LoginScreen.dart';
import 'package:shop_app/shared/Network/local/cache_helper.dart';
import 'components.dart';

void signOutFun(context){
  CachHelper.clearDataFromSharedPreference(key: 'token')
      .then((value) {
    if(value)
      navigateAndFinish(context, LoginScreen());
  });
}

String? token = ' ';