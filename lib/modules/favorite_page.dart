import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/colors.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Shopcubit cubit = Shopcubit.get(context);
        return cubit.getFavoriteModel!.data?.data?.isEmpty ?? true
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'No Favorites Item found',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image(
                    image: AssetImage(
                      'assets/love.gif',
                    ),
                    width: 150,
                  ),
                ],
              )
            : ListView.separated(
                itemBuilder: (context, index) => productitem(
                    cubit.getFavoriteModel!.data!.data![index].product,
                    context),
                separatorBuilder: (context, index) => const SizedBox(),
                itemCount: cubit.getFavoriteModel!.data?.data?.length ?? 0);
      },
    );
  }
}
