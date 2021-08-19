import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/HomeScreen/HomeScreen.dart';
import 'package:shop_app/screens/SignUpScreen/SignUpScreen.dart';
import 'package:shop_app/shared/Network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shared/styles/styles.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext con) {

    var emailConteroller = TextEditingController();
    var passwordConteroller = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (BuildContext context, state){
          if(state is LoginSuccessState){
           if (state.loginModelObject.status != null &&  state.loginModelObject.status == true)
                {
                  CachHelper.putDataInSharedPreference(value: state.loginModelObject.data!.token, key: 'token')
                  .then((value) {
                    token =  state.loginModelObject.data!.token!;
                    navigateAndFinish(context, HomeScreen());
                  });

                }
           else
                  {
                    makeToast('${state.loginModelObject.message}');
                    navigateTo(context,SignUpScreen());
                  }
          }

          else if(state is LoginErrorState){
            makeToast('${state.errorString}');
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text('LOGIN',
                          style: bigTitles.headline5),
                      SizedBox(height: 10.0,),
                      Text('Welcome to Shop app, please login',
                          style: bigTitles.bodyText2),
                      SizedBox(height: 45.0,),
                      defaultTextFormField(
                          validator: (String? text) {
                            if(text!.isEmpty)
                              return 'please enter valid email';
                          },
                          controller: emailConteroller,
                          labelText: 'E-mail',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icon(Icons.email)
                      ),
                      SizedBox(height: 15.0,),

                      defaultTextFormField(
                        validator: (String? text) {
                          if(text!.isEmpty)
                            return 'please enter valid password';
                        },
                        controller: passwordConteroller,
                        labelText: 'password',
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: LoginCubit.get(context).obsecureTextToggle ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                        obscureText:LoginCubit.get(context).obsecureTextToggle,
                        suffixFun: (){LoginCubit.get(context).changePasswordVisibility();}
                        ,
                        onSubmit: (value){
                          if(formKey.currentState!.validate())
                          {
                            LoginCubit.get(context).userLogin(email: emailConteroller.text, password: passwordConteroller.text);
                          }
                        }
                      ),



                      SizedBox(height: 15.0,),

                      state is! LoginLoadingState ?
                      defaultButton(
                        buttonFunction: () {
                          if(formKey.currentState!.validate())
                            {
                              LoginCubit.get(context).userLogin(email: emailConteroller.text, password: passwordConteroller.text);
                            }
                        },
                        buttonText: 'login',
                      )
                      : Center(child: CircularProgressIndicator(),),


                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          TextButton(onPressed: () {
                            navigateTo(context, SignUpScreen());
                          }, child: Text('Sign up',style: bigTitles.bodyText2!.copyWith(color: primaryColor,fontWeight: FontWeight.bold),)),
                        ],
                      ),



                    ],
                  ),
                ),
              ),
            ),
          ) ;
        },

      ),
    );
  }
}
