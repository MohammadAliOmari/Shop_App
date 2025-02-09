import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register_page.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/colors.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../shared/constants/constants.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});

  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          debugPrint(state.loginModel!.message);
          debugPrint(state.loginModel!.data!.token);
          CacheHelper.saveData(
                  key: 'token', value: state.loginModel!.data!.token)
              .then((value) {
            showToast(
              massage: state.loginModel!.message!,
              toastState: ChoseState.success,
            );
            token = state.loginModel!.data!.token;
            navigateToAndFinish(context, const ShopLayout());
          }).catchError((error) {});

          if (state is LoginErrorState) {
            debugPrint(state.loginModel!.message);
            showToast(
              massage: state.loginModel!.message!,
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
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'login now for browse our hot offers',
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
                    controller: emailcontroller,
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
                    label: 'Password',
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
                    onSubmitted: (value) {
                      if (formKey.currentState!.validate()) {
                        Shopcubit.get(context).userLogin(
                            email: emailcontroller.text,
                            password: passwordcontroller.text);
                      }
                    },
                    radius: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state is! LoginLodingState
                      ? defualtButton(
                          text: 'Login',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Shopcubit.get(context).userLogin(
                                  email: emailcontroller.text.trim(),
                                  password: passwordcontroller.text.trim());
                            }
                          },
                          raduis: 20,
                        )
                      : const Center(child: CircularProgressIndicator()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account ?'),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, RegisterPage());
                          },
                          child: const Text(
                            'Register',
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
