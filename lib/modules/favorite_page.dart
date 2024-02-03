import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
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
        return ListView.separated(
            itemBuilder: (context, index) =>
                favItem(cubit.getFavoriteModel!.data.data[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.getFavoriteModel!.data.data.length);
      },
    );
  }

  Widget favItem(Datum data, BuildContext context) {
    return Shopcubit.get(context).favorites[data.product.id] ?? false
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 120,
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Image(
                        image: NetworkImage(data.product.image),
                        width: 120,
                        height: 120,
                      ),
                      if (data.product.discount != 0)
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: const Text(
                            'DISCOUNT',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            height: 1.3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              '${data.product.price.round()}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: defualtColor2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            if (data.product.discount != 0)
                              Text(
                                '${data.product.oldPrice.round()}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                Shopcubit.get(context)
                                    .changeFavorite(data.product.id);
                              },
                              icon: Icon(
                                  color: Shopcubit.get(context)
                                              .favorites[data.product.id] ??
                                          false
                                      ? Colors.red
                                      : null,
                                  Shopcubit.get(context)
                                              .favorites[data.product.id] ??
                                          false
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child: Text(
              'No Favorites Item yet',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: defualtColor2),
            ),
          );
  }
}
