import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final TextEditingController namecontroller = TextEditingController();

  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController phoncontroller = TextEditingController();

  final GlobalKey<FormState> kform = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Shopcubit()..getUserData(),
      child: BlocConsumer<Shopcubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          namecontroller.text =
              Shopcubit.get(context).userModel?.data?.name! ?? '';
          emailcontroller.text =
              Shopcubit.get(context).userModel?.data?.email! ?? '';
          phoncontroller.text =
              Shopcubit.get(context).userModel?.data?.phone! ?? '';
          return Shopcubit.get(context).userModel != null
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: kform,
                      child: Column(
                        children: [
                          const Image(
                              image: AssetImage('assets/Profile.png'),
                              height: 300),
                          defualtTextForm(
                              radius: 20,
                              controller: namecontroller,
                              type: TextInputType.text,
                              label: 'Name',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'your name must not be empty';
                                }
                                return null;
                              },
                              prefixIcon: Icons.person),
                          const SizedBox(
                            height: 10,
                          ),
                          defualtTextForm(
                              radius: 20,
                              controller: emailcontroller,
                              type: TextInputType.emailAddress,
                              label: 'Email',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'your email must not be empty';
                                }
                                return null;
                              },
                              prefixIcon: Icons.email_outlined),
                          const SizedBox(
                            height: 10,
                          ),
                          defualtTextForm(
                            radius: 20,
                            controller: phoncontroller,
                            type: TextInputType.number,
                            label: 'phone',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'your phone must not be empty';
                              }
                              return null;
                            },
                            prefixIcon: Icons.phone_android,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (state is UpdateUserDataLodingState)
                            const LinearProgressIndicator(),
                          const SizedBox(
                            height: 15,
                          ),
                          defualtButton(
                              text: 'Update Profile',
                              onPressed: () {
                                if (kform.currentState!.validate()) {
                                  Shopcubit.get(context).updateUserData(
                                      email: emailcontroller.text,
                                      name: namecontroller.text,
                                      phone: phoncontroller.text);
                                }
                              },
                              raduis: 20),
                          const SizedBox(
                            height: 10,
                          ),
                          defualtButton(
                            text: 'Sign Out',
                            onPressed: () {
                              Shopcubit.get(context).signOut(context);
                            },
                            raduis: 20,
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
