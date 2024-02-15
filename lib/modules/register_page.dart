import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login_page.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/colors.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../shared/constants/constants.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController remailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.registermodel!.status!) {
            CacheHelper.saveData(
                    key: 'token', value: state.registermodel!.data!.token)
                .then((value) {
              token = state.registermodel!.data!.token;
              showToast(
                massage: state.registermodel!.message!,
                toastState: ChoseState.success,
              );
              navigateToAndFinish(context, const ShopLayout());
            });
          } else {
            debugPrint(state.registermodel!.message);
            showToast(
              massage: state.registermodel!.message!,
              toastState: ChoseState.error,
            );
          }
        }
      },
      builder: (context, state) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                    image: AssetImage(
                      'assets/login.png',
                    ),
                  ),
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'register now for browse our hot offers',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defualtTextForm(
                    iconColor: primaryColor,
                    controller: namecontroller,
                    type: TextInputType.text,
                    label: 'Name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter your name';
                      }
                      return null;
                    },
                    prefixIcon: Icons.person,
                    radius: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defualtTextForm(
                    iconColor: primaryColor,
                    controller: phonecontroller,
                    type: TextInputType.number,
                    label: 'Phone',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter your phone number';
                      }
                      return null;
                    },
                    prefixIcon: Icons.phone_android_outlined,
                    radius: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defualtTextForm(
                    iconColor: primaryColor,
                    controller: remailcontroller,
                    type: TextInputType.emailAddress,
                    label: 'Email Address',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' enter your email address';
                      }
                      return null;
                    },
                    prefixIcon: Icons.email_outlined,
                    radius: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defualtTextForm(
                    iconColor: primaryColor,
                    controller: passwordcontroller,
                    type: TextInputType.visiblePassword,
                    label: 'Passowrd',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter your password';
                      }
                      return null;
                    },
                    prefixIcon: Icons.lock_outline,
                    suffixIcon: Shopcubit.get(context).sufixIcon,
                    isPassword: Shopcubit.get(context).ispassword,
                    suffixFunction: () {
                      Shopcubit.get(context).changePasswordVisibility();
                    },
                    onSubmitted: (value) {},
                    radius: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state is! RegisterLodingState
                      ? defualtButton(
                          text: 'Rgister',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Shopcubit.get(context).userRegister(
                                  name: namecontroller.text,
                                  phone: phonecontroller.text,
                                  email: remailcontroller.text,
                                  password: passwordcontroller.text);
                              log(namecontroller.text);
                              log(phonecontroller.text);
                              log(remailcontroller.text);
                              log(passwordcontroller.text);
                            }
                          },
                          raduis: 10,
                        )
                      : const Center(child: CircularProgressIndicator()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('already have an account ?'),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, LogIn());
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: primaryColor),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
