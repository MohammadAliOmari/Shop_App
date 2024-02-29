import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class InitalState extends ShopStates {}

class LoginSuccessState extends ShopStates {
  final LoginModel? loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginLodingState extends ShopStates {}

class LoginErrorState extends ShopStates {}

class PasswordVisibilityState extends ShopStates {}

class ChangeBottomNavBarState extends ShopStates {}

class HomeLodingState extends ShopStates {}

class HomesuccessState extends ShopStates {}

class HomeErrorState extends ShopStates {}

class CategoriesLodingState extends ShopStates {}

class CategoriessuccessState extends ShopStates {}

class CategoriesErrorState extends ShopStates {}

class FavoritesLodingState extends ShopStates {}

class FavoritessuccessState extends ShopStates {
  final FavoriteModel model;

  FavoritessuccessState(this.model);
}

class FavoritesErrorState extends ShopStates {}

class GetFavoriteLodingState extends ShopStates {}

class GetFavoritesuccessState extends ShopStates {}

class GetFavoriteErrorState extends ShopStates {}

class GetUserDataLodingState extends ShopStates {}

class GetUserDatasuccessState extends ShopStates {
  final LoginModel model;

  GetUserDatasuccessState(this.model);
}

class GetUserDataErrorState extends ShopStates {}

class RegisterErrorState extends ShopStates {}

class RegisterLodingState extends ShopStates {}

class RegisterSuccessState extends ShopStates {
  final LoginModel? registermodel;

  RegisterSuccessState(this.registermodel);
}

class UpdateUserDataErrorState extends ShopStates {}

class UpdateUserDataLodingState extends ShopStates {}

class UpdateUserDataSuccessState extends ShopStates {}

class SearchProductErrorState extends ShopStates {}

class SearchProductLodingState extends ShopStates {}

class SearchProductSuccessState extends ShopStates {}

class GetSingleCategoriesErrorState extends ShopStates {}

class GetSingleCategoriesLodingState extends ShopStates {}

class GetSingleCategoriesSuccessState extends ShopStates {}
