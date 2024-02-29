import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/single_categorie_page.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Shopcubit cubit = Shopcubit.get(context);
        return ListView.builder(
          itemBuilder: (context, index) => FadeInLeft(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  cubit.getSingleCategories(
                      id: cubit.categoriesModel!.data.data[index].id);
                  navigateTo(
                      context,
                      SingleCategoriePage(
                        categorieName:
                            cubit.categoriesModel!.data.data[index].name,
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 20,
                            offset: Offset(-4, 10))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                cubit.categoriesModel!.data.data[index].image),
                          ),
                        ),
                      ),
                      Text(
                        cubit.categoriesModel!.data.data[index].name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          itemCount: cubit.categoriesModel?.data.data.length,
        );
      },
    );
  }
}
