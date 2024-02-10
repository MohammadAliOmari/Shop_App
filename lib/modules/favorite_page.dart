import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/models/get_favorite_model.dart';
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
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'No Favorites Item yet',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.redAccent[700],
                    size: 60,
                    shadows: const [
                      Shadow(
                          color: Colors.black,
                          blurRadius: 20,
                          offset: Offset(2, 5))
                    ],
                  )
                ],
              )
            : ListView.separated(
                itemBuilder: (context, index) => productitem(
                    cubit.getFavoriteModel!.data!.data![index].product,
                    context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.getFavoriteModel!.data?.data?.length ?? 0);
      },
    );
  }
}
