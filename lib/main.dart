import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/bloc_observer.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login_page.dart';
import 'package:shop_app/modules/onboarding_screen.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = LogIn();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});

  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Shopcubit()
        ..getHomeData()
        ..geetCategoriesData()
        ..getFavorite()
        ..getUserData(),
      child: BlocConsumer<Shopcubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop App',
            home: startWidget,
          );
        },
      ),
    );
  }
}
