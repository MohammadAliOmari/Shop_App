import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/colors.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {
        if (state is FavoritessuccessState) {
          if (!state.model.status) {
            showToast(
                massage: state.model.message, toastState: ChoseState.error);
          } else {
            showToast(
                massage: state.model.message, toastState: ChoseState.success);
          }
        }
      },
      builder: (context, state) {
        Shopcubit cubit = Shopcubit.get(context);
        return cubit.homeModel != null
            ? homebuilditem(cubit.homeModel, cubit.categoriesModel, context)
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget homebuilditem(
      HomeModel? model, CategoriesModel? categoriesModel, context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model!.data.banners
                  .map((e) => Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    e.image,
                                  ),
                                )),
                          )
                      // Image(
                      //   image: NetworkImage(e.image,),
                      //   width: double.infinity,
                      //   fit: BoxFit.cover,
                      // ),
                      )
                  .toList(),
              options: CarouselOptions(
                height: 200,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(seconds: 2),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 110,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return buildCategoreisItem(
                            categoriesModel.data.data[index]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesModel!.data.data.length),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'New Product',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              childAspectRatio: 1 / 1.6,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              mainAxisSpacing: 3,
              crossAxisSpacing: 2,
              crossAxisCount: 2,
              children: List.generate(model.data.products.length, (index) {
                return buildProductItem(model.data.products[index], context);
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget buildProductItem(Product productmodel, context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(productmodel.image),
                width: double.infinity,
                height: 200,
              ),
              if (productmodel.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productmodel.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      ' ${productmodel.price.round()}\$',
                      style: const TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (productmodel.discount != 0)
                      Text(
                        ' ${productmodel.oldPrice.round()}\$',
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
                              .changeFavorite(productmodel.id);
                        },
                        icon: Icon(
                            color: Shopcubit.get(context)
                                        .favorites[productmodel.id] ??
                                    false
                                ? Colors.redAccent[700]
                                : null,
                            Shopcubit.get(context).favorites[productmodel.id] ??
                                    false
                                ? Icons.favorite
                                : Icons.favorite_border_outlined))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildCategoreisItem(Datum catmodel) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    catmodel.image,
                  ),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.grey, width: 2)),
          // child: Image(
          //   image: NetworkImage(catmodel.image),
          //   height: 70,
          //   width: 70,
          //   fit: BoxFit.cover,
          // ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            width: 100,
            child: Text(
              catmodel.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ))
      ],
    );
  }
}
