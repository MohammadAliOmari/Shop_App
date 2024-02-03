import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/search_page.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/colors.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Shopcubit cubit = Shopcubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              'Shop App',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: defualtColor2),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  moveTo(context, const SearchPage());
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: cubit.screens[cubit.curentindex],
          bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black12.withOpacity(0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 25,
                    offset: const Offset(10, 20))
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.black12.withOpacity(0),
                showUnselectedLabels: true,
                currentIndex: cubit.curentindex,
                unselectedItemColor: Colors.grey,
                selectedItemColor: defualtColor2,
                onTap: (index) {
                  cubit.changeeNavBar(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      backgroundColor: Colors.white,
                      icon: Icon(Icons.home),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_tree_outlined),
                      label: 'Categories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Favorites'),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
