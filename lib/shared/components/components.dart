import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/get_favorite_model.dart';
import 'package:shop_app/shared/constants/colors.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

Widget defualtButton({
  double width = double.infinity,
  double? height,
  Color color = primaryColor,
  Color fontColor = Colors.white,
  double fontSize = 20,
  bool isUpperCase = true,
  required String text,
  required VoidCallback onPressed,
  double raduis = 0.0,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(raduis),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(
              color: fontColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            )),
      ),
    );

//TextFormField
Widget defualtTextForm({
  //carefull
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required String? Function(String?)? validator,
  void Function(String)? onSubmitted,
  void Function()? onTap,
  void Function(String)? onChanged,

  //icons
  required IconData prefixIcon,
  IconData? suffixIcon,
  void Function()? suffixFunction,
  bool isClicAble = true,
  bool isRead = false,
  bool isPassword = false,
  Color iconColor = Colors.grey,
  Color textFormColor = Colors.white,

  //style
  double radius = 0,
  double labelFontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      enabled: isClicAble,
      validator: validator,
      obscureText: isPassword,
      readOnly: isRead,
      decoration: InputDecoration(
          fillColor: textFormColor,
          label: Text(label,
              style: TextStyle(
                color: primaryColor,
                fontSize: labelFontSize,
                fontWeight: fontWeight,
              )),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
          prefixIcon: Icon(
            prefixIcon,
            color: iconColor,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixFunction,
                  icon: Icon(
                    suffixIcon,
                    color: iconColor,
                  ),
                )
              : null),
    );

//divider
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

//navigator.push
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
void navigateToAndFinish(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void showToast({
  required String massage,
  required ChoseState toastState,
}) =>
    Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseColor(toastState),
        textColor: Colors.white,
        fontSize: 16.0);

enum ChoseState { success, error, warning }

//Color Toast method
Color chooseColor(ChoseState state) {
  Color color;
  switch (state) {
    case ChoseState.success:
      color = Colors.green;
      break;
    case ChoseState.error:
      color = Colors.red;
      break;
    case ChoseState.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget productitem(model, BuildContext context, {bool isSearch = true}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: 120,
                height: 120,
              ),
              if (isSearch && model?.discount != 0)
                Container(
                  decoration: BoxDecoration(
                      color: Colors.redAccent[700],
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}\$',
                      style: const TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (isSearch && model?.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Shopcubit.get(context).changeFavorite(model.id);
                      },
                      icon: Icon(
                          color: Shopcubit.get(context).favorites[model.id] ??
                                  false
                              ? Colors.redAccent[700]
                              : null,
                          Shopcubit.get(context).favorites[model.id] ?? false
                              ? Icons.favorite
                              : Icons.favorite_border_outlined),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
