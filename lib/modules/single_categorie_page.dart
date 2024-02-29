import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/single_categorie_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/colors.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class SingleCategoriePage extends StatelessWidget {
  const SingleCategoriePage({
    super.key,
    required this.categorieName,
  });
  final String categorieName;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Shopcubit cubit = Shopcubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  cubit.singleCategoriesModel = null;
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: const Color(0xFF022082).withOpacity(0.9),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 10, offset: Offset(2, 8))
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              textAlign: TextAlign.center,
                              categorieName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      const Text(
                        'Products',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(blurRadius: 10, color: Colors.black)
                            ]),
                        height: 5,
                        width: 50,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                cubit.singleCategoriesModel == null
                    ? const LodingSinglecategoriesScreen()
                    : Container(
                        margin: const EdgeInsets.all(5),
                        color: Colors.white,
                        child: GridView.count(
                          childAspectRatio: 1 / 1.65,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 3,
                          crossAxisCount: 2,
                          children: List.generate(
                              cubit.singleCategoriesModel?.data?.data?.length ??
                                  0, (index) {
                            return buildProductItem(
                                cubit.singleCategoriesModel!.data!.data![index],
                                context);
                          }),
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildProductItem(Datum data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(color: Colors.black, blurRadius: 20, offset: Offset(-4, 10))
        ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          data.image ??
                              "https://student.valuxapps.com/storage/uploads/products/1644372386y0SzM.4.jpg",
                        ),
                      ),
                      borderRadius: BorderRadius.circular(20)),
                ),
                if (data.discount != 0)
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
                    data.name!,
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
                        ' ${data.price?.round()}\$',
                        style: const TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (data.discount != 0)
                        Text(
                          ' ${data.oldPrice?.round()}\$',
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
                            Shopcubit.get(context).changeFavorite(data.id!);
                          },
                          icon: Icon(
                              color:
                                  Shopcubit.get(context).favorites[data.id] ??
                                          false
                                      ? Colors.redAccent[700]
                                      : null,
                              Shopcubit.get(context).favorites[data.id] ?? false
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
