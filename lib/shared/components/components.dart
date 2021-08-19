import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shared/styles/styles.dart';


void navigateTo(context,widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>widget));

void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget),
    (Route<dynamic> route) => false,);





Widget defaultTextFormField({
    required TextEditingController controller,
    required TextInputType keyboardType,
    required String labelText,
    required String? Function(String?)? validator,
    Icon? prefixIcon,
    Icon? suffixIcon,
    ValueChanged<String>? onSubmit,
    Function(String)? onChange,
    bool obscureText = false,
    VoidCallback? suffixFun,
    Function()? onTap,
}) =>
    TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(borderRadius:BorderRadius.circular(20.0) ),
          prefixIcon: prefixIcon,
            suffixIcon: suffixIcon != null ? IconButton(icon: suffixIcon, onPressed: suffixFun,) : null ,
        ),
        keyboardType: keyboardType,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        obscureText: obscureText,
    );

//-------------------------------------------------------------

Widget defaultButton({
  double buttonWidth = double.infinity,
  Color buttonColor = primaryColor,
  required Function() buttonFunction,
  required String buttonText,
}) =>
    Container(
      width: buttonWidth,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),color:buttonColor ),
      child: MaterialButton(

        onPressed: buttonFunction,
        child: Text(
          buttonText.toUpperCase(),
          style: bigTitles.bodyText2!.copyWith(color: Colors.white),
        ),
      ),
    );



//---------------Toast-----------------------------------------------------------


Future<bool?> makeToast (String mssg) async {
  return  Fluttertoast.showToast(
      msg: mssg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: primaryColor.shade100,
      textColor: Colors.black,
      fontSize: 14.0 );
}
