import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/get_favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories_page.dart';
import 'package:shop_app/modules/favorite_page.dart';
import 'package:shop_app/modules/login_page.dart';
import 'package:shop_app/modules/products_page.dart';
import 'package:shop_app/modules/settings_page.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class Shopcubit extends Cubit<ShopStates> {
  Shopcubit()
      : super(
    InitalState(),
  );

  static Shopcubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;

  void userLogin({required String email, required String password}) {
    emit(LoginLodingState());
    DioHelper.postData(
      url: login,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      // print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.data!.name);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrorState());
    });
  }
LoginModel? registerModel;
  void userRegister({required String email, required String password,required String name,required String phone}) {
    emit(RegisterLodingState());
    DioHelper.postData(
      url: register,
      data: {
        'email': email,
        'password': password,
        'phone':phone,
        'name':name,
      },
    ).then((value) {
      // print(value.data);
      registerModel = LoginModel.fromJson(value.data);

      emit(RegistersuccessState(registerModel));
    }).catchError((error) {
      print(error);
      emit(RegisterErrorState());
    });
  }
  bool ispassword = true;
  IconData sufixIcon = Icons.visibility_off_outlined;

  void changePasswordVisibility() {
    ispassword = !ispassword;
    sufixIcon =
    ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(PasswordVisibilityState());
  }

  int curentindex = 0;
  List<Widget> screens =  [
    const ProductsPage(),
    const CategoriesPage(),
    const FavoritePage(),
    SettingsPage(),
  ];

  void changeeNavBar(int index) {
    curentindex = index;
    emit(ChangeBottomNavBarState());
  }

  Map<int?, bool?> favorites = {};
  HomeModel? homeModel;

  void getHomeData() {
    emit(HomesuccessState());
    DioHelper.getData(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.data.banners[0].image);
      print(homeModel!.data.products[0].inFavorites);
      homeModel!.data.products.forEach(
            (element) {
          favorites.addAll({element.id: element.inFavorites});
        },
      );
      emit(HomesuccessState());
    }).catchError((error) {
      emit(HomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;

  void geetCategoriesData() {
    emit(CategoriesLodingState());
    DioHelper.getData(url: categories, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.data.currentPage);
      emit(CategoriessuccessState());
    }).catchError((error) {
      emit(CategoriesErrorState());
    });
  }

  FavoriteModel? favoriteModel;

  void changeFavorite(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(FavoritesLodingState());
    DioHelper.postData(
      url: favorite,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      getFavorite();
      print(value.data);
      print(homeModel!.data.products[0].inFavorites);

      if (!favoriteModel!.status) {
        favorites[productId] = !favorites[productId]!;
      }
      emit(FavoritessuccessState(favoriteModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(FavoritesErrorState());
    });
  }

  GetFavoriteModel? getFavoriteModel;

  void getFavorite() {
    emit(GetFavoriteLodingState());
    DioHelper.getData(url: favorite, token: token)
        .then((Response<dynamic>? value) {
      getFavoriteModel = GetFavoriteModel.fromJson(value!.data);
      print(getFavoriteModel!.data.data[0]);

      emit(GetFavoritesuccessState());
    }).catchError((error) {
      print(error);
      emit(GetFavoriteErrorState());
    });
  }
  LoginModel ? userModel;
  void getUserData() {
    emit(GetUserDataLodingState());
    DioHelper.getData(url: profile,token: token).then((value) {
      userModel=LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(GetUserDatasuccessState(userModel!));
    }).catchError((error) {
      print(error);
      emit(GetUserDataErrorState());
    });
  }

  void signOut(context){
    CacheHelper.removeData(key: 'token',).then((value) {
      if(value){
        moveToAndFinish(context, LogIn());
      }
    });
  }
}
