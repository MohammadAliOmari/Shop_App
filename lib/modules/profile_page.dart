import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/components/components.dart';

class ProfilePage extends StatelessWidget {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController phoncontroller = TextEditingController();
  final GlobalKey<FormState> kform = GlobalKey<FormState>();
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LoginModel? model = Shopcubit.get(context).userModel;
        namecontroller.text = model!.data!.name!;
        emailcontroller.text = model.data!.email!;
        phoncontroller.text = model.data!.phone!;
        return Shopcubit.get(context).userModel != null
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: kform,
                  child: Column(
                    children: [
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
                      SizedBox(
                        height: 10,
                      ),
                      if (state is UpdateUserDataLodingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 30,
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
                      )
                    ],
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
