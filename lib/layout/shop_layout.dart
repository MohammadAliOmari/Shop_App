import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/modules/search_page.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Shopcubit cubit = Shopcubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Shop App',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchPage());
                },
                icon: const Icon(
                  Icons.search,
                ),
              )
            ],
          ),
          body: cubit.screens[cubit.curentindex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                showUnselectedLabels: true,
                currentIndex: cubit.curentindex,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.white,
                onTap: (index) {
                  cubit.changeeNavBar(index);
                },
                items: [
                  BottomNavigationBarItem(
                      backgroundColor: const Color(0xFF022082).withOpacity(0.9),
                      icon: const Icon(Icons.home),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      backgroundColor: const Color(0xFF022082).withOpacity(0.9),
                      icon: const Icon(Icons.account_tree_outlined),
                      label: 'Categories'),
                  BottomNavigationBarItem(
                      backgroundColor: const Color(0xFF022082).withOpacity(0.9),
                      icon: const Icon(Icons.favorite),
                      label: 'Favorites'),
                  BottomNavigationBarItem(
                    backgroundColor: const Color(0xFF022082).withOpacity(0.9),
                    icon: const Icon(Icons.person),
                    label: 'Profile',
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
