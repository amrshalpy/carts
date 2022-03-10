import 'package:carts/style/theme.dart';
import 'package:flutter/material.dart';

Widget button({
  required onPress,
  required txt,
}) {
  return Container(
    height: 40,
    width: double.infinity,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPress,
        child: Text(
          txt,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        )),
  );
}

Widget customTitle({
  required txt,
  required Color color,
  required double fontSize,
  required FontWeight fontWeight,
}) {
  return Text(
    txt,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget customText({
  required txt,
  required Color color,
  required double fontSize,
  required FontWeight fontWeight,
}) {
  return Text(
    txt,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

nextPage({
  required BuildContext context,
  required Widget page,
}) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

nextPageUntil({
  required BuildContext context,
  required Widget page,
}) {
  return Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page), (route) => false);
}

Widget buildFormField({
  required Function validate,
  Function()? onPress,
  required TextEditingController controller,
  required String hint,
  required TextInputType type,
  required String lable,
  required IconData iconData,
  IconData? icon,
  bool obscure = false,
}) {
  return Container(
    height: 50,
    width: double.infinity,
    child: TextFormField(
      validator: (String? val) {
        validate(val);
      },
      controller: controller,
      keyboardType: type,
      cursorColor: mainColor,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor),
        ),
        labelStyle: TextStyle(
          color: mainColor,
        ),
        fillColor: Colors.grey[70],
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(lable),
        hintText: hint,
        prefixIcon: Icon(iconData),
        suffix: IconButton(
          icon: Icon(icon),
          onPressed: onPress,
        ),
      ),
      obscureText: obscure,
    ),
  );
}

pop({BuildContext? context}) {
  Navigator.pop(context!);
}
