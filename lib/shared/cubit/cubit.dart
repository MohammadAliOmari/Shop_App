import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/models/single_categorie_model.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/get_favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories_page.dart';
import 'package:shop_app/modules/favorite_page.dart';
import 'package:shop_app/modules/login_page.dart';
import 'package:shop_app/modules/products_page.dart';
import 'package:shop_app/modules/profile_page.dart';
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

//-----------------------------------------------------Login
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
      print(loginModel?.data!.name);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrorState());
    });
  }

//-----------------------------------------------------register
  LoginModel? registermodel;
  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(RegisterLodingState());

    DioHelper.postData(
      url: register,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password
      },
    ).then((value) {
      print(value.data);
      registermodel = LoginModel.fromJson(value.data);

      emit(RegisterSuccessState(registermodel));
    }).catchError((error) {
      print(error);
      emit(RegisterErrorState());
    });
  }

//----------------------------------------------------- changePasswordVisibility
  bool ispassword = true;
  IconData sufixIcon = Icons.visibility_off_outlined;
  void changePasswordVisibility() {
    ispassword = !ispassword;
    sufixIcon =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(PasswordVisibilityState());
  }

  //-----------------------------------------------------changeeNavBar
  int curentindex = 0;
  List<Widget> screens = [
    const ProductsPage(),
    const CategoriesPage(),
    const FavoritePage(),
    ProfilePage(),
  ];

  void changeeNavBar(int index) {
    curentindex = index;
    emit(ChangeBottomNavBarState());
  }

//-----------------------------------------------------getHomeData
  Map<num?, bool?> favorites = {};
  HomeModel? homeModel;
  void getHomeData() {
    emit(HomesuccessState());
    DioHelper.getData(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.data.banners[0].image);
      print(homeModel!.data.products[0].inFavorites);
      if (homeModel!.data.products.isNotEmpty) {
        for (var element in homeModel!.data.products) {
          favorites.addAll({element.id: element.inFavorites});
        }
      }

      emit(HomesuccessState());
    }).catchError((error) {
      emit(HomeErrorState());
    });
  }

//-----------------------------------------------------geetCategoriesData
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

//-----------------------------------------------------changeFavorite
  FavoriteModel? favoriteModel;
  void changeFavorite(num productId) {
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

//-----------------------------------------------------getFavorite
  GetFavoriteModel? getFavoriteModel;
  void getFavorite() {
    emit(GetFavoriteLodingState());
    DioHelper.getData(url: favorite, token: token).then((value) {
      getFavoriteModel = GetFavoriteModel.fromJson(value.data);
      print(getFavoriteModel!.data!.data![0]);
      emit(GetFavoritesuccessState());
    }).catchError((error) {
      print(error);
      emit(GetFavoriteErrorState());
    });
  }

//-----------------------------------------------------getUserData
  LoginModel? userModel;
  void getUserData() {
    emit(GetUserDataLodingState());
    DioHelper.getData(url: profile, token: token).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(GetUserDatasuccessState(userModel!));
    }).catchError((error) {
      print(error);
      emit(GetUserDataErrorState());
    });
  }

//-----------------------------------------------------updateUserData
  void updateUserData({
    required String email,
    required String name,
    required String phone,
  }) {
    emit(UpdateUserDataLodingState());
    DioHelper.putData(token: token, url: updateprofile, data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(UpdateUserDataSuccessState());
    }).catchError((error) {
      print(error);
      emit(UpdateUserDataErrorState());
    });
  }

//-----------------------------------------------------searchProduct
  SearchModel? searchModel;
  void searchProduct(String text) {
    emit(SearchProductLodingState());
    DioHelper.postData(url: search, token: token, data: {'text': text})
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel?.data?.data![0].name);
      emit(SearchProductSuccessState());
    }).catchError((error) {
      print(error);
      emit(SearchProductErrorState());
    });
  }

//-----------------------------------------------------GetSingleCategories
  GetSingleCategoriesModel? singleCategoriesModel;
  void getSingleCategories({required num id}) {
    emit(GetSingleCategoriesLodingState());
    DioHelper.getData(
      url: getcategories,
      token: token,
      query: {'category_id': id},
    ).then((value) {
      singleCategoriesModel = GetSingleCategoriesModel.fromJson(value.data);
      print(singleCategoriesModel?.data?.data![0].name);
      emit(GetSingleCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSingleCategoriesErrorState());
    });
  }

//-----------------------------------------------------signOut
  void signOut(context) {
    CacheHelper.removeData(
      key: 'token',
    ).then((value) {
      if (value) {
        navigateToAndFinish(context, LogIn());
      }
    });
  }
}
