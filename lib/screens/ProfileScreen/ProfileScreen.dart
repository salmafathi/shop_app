import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/HomeScreen/HomeCubit/HomeCubit.dart';
import 'package:shop_app/screens/HomeScreen/HomeCubit/HomeStates.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var nameTextController = TextEditingController()  ;
    var emailTextController = TextEditingController()  ;
    var phoneTextController = TextEditingController()  ;
    var imageTextController = TextEditingController()  ;
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => HomeCubit()..getLoginModel(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){
          if (state is GetProfileSuccessState) {
          nameTextController.text = HomeCubit.get(context).loginModel!.data!.name! ;
          emailTextController.text = HomeCubit.get(context).loginModel!.data!.email! ;
          phoneTextController.text = HomeCubit.get(context).loginModel!.data!.phone! ;
          imageTextController.text =  HomeCubit.get(context).loginModel!.data!.image! ;
          }

          if(state is UpdateProfileSuccessState){
            makeToast('Updated Successfully');
          }
        },
        builder: (context,state){
          var cubit = HomeCubit.get(context);
          return cubit.loginModel != null ?
            Scaffold(
              backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Profile'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 30.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if(state is UpdateProfileLoadingState)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: LinearProgressIndicator(),
                        ),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                            fit: StackFit.passthrough,
                            children: [
                          CircleAvatar(
                              radius: 50.0,
                              backgroundImage:  NetworkImage(cubit.loginModel!.data!.image.toString())),

                          InkWell(
                            onTap: (){
                              cubit.onchangePhotoClicked();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor,
                              ),
                              width: 30.0, height: 30.0,
                              child: Icon(Icons.edit , color: Colors.white, size: 20.0,),


                            ),
                          )
                        ]),
                      ),

                      SizedBox(height: 25.0,),
                      defaultTextFormField(
                          onChange: (text){cubit.onChangeEditText();},
                          prefixIcon: Icon(Icons.person),
                          labelText: '',
                          keyboardType: TextInputType.name,
                          controller: nameTextController,
                          validator: (String? text) {
                            if(text!.isEmpty) {return 'name must not be empty';}
                            return null;
                          }),

                      SizedBox(height: 20.0,),
                      defaultTextFormField(
                          onChange: (text){cubit.onChangeEditText();},
                          prefixIcon: Icon(Icons.email),
                          labelText: '',
                          keyboardType: TextInputType.emailAddress,
                          controller: emailTextController,
                          validator: (String? text) {
                            if(text!.isEmpty) {return 'email must not be empty';}
                            return null;
                          }),

                      SizedBox(height: 20.0,),
                      defaultTextFormField(
                          onChange: (text){cubit.onChangeEditText();},
                          prefixIcon: Icon(Icons.phone),
                          labelText: '',
                          keyboardType: TextInputType.phone,
                          controller: phoneTextController,
                          validator: (String? text) {
                            if(text!.isEmpty) {return 'phone must not be empty';}
                            return null;
                          }),



                     cubit.changePhotoClicked?
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: defaultTextFormField(
                            onChange: (text){cubit.onChangeEditText();},
                            prefixIcon: Icon(Icons.image),
                            labelText: 'photo',
                            keyboardType: TextInputType.url,
                            controller: imageTextController,
                            validator: (String? text) {
                              if(text!.isEmpty) {return 'phone must not be empty';}
                              return null;
                            }),
                      )
                      : SizedBox(),



                      SizedBox(height: 20.0,),
                      defaultButton(
                          buttonColor: cubit.updatedUserFormData ? primaryColor : Colors.grey,
                          buttonFunction: cubit.updatedUserFormData ? (){
                            if(formKey.currentState!.validate()){
                              cubit.updateUserData
                                (name: nameTextController.text,
                                  email: emailTextController.text,
                                  phone: phoneTextController.text);
                            }
                          } : (){},
                          buttonText: 'Update'),

                    ],
                  ),
                ),
              ),
            ),
          )
              : Center(child: CircularProgressIndicator());
        },

      ),
    );
  }
}
