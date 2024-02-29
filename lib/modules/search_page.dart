import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/colors.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Shopcubit cubit = Shopcubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  cubit.searchModel = null;
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                alignment: Alignment.topCenter,
                child: defualtTextForm(
                  radius: 20,
                  textFormColor: primaryColor,
                  iconColor: primaryColor,
                  controller: searchcontroller,
                  type: TextInputType.text,
                  label: 'Seearch',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Text To Search';
                    }
                    return null;
                  },
                  prefixIcon: Icons.search_outlined,
                  onSubmitted: (text) {
                    cubit.searchProduct(text);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (state is SearchProductLodingState)
                const LinearProgressIndicator(color: primaryColor),
              cubit.searchModel != null
                  ? Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return productitem(
                                cubit.searchModel!.data!.data![index], context,
                                isSearch: false);
                          },
                          separatorBuilder: (context, index) {
                            return myDivider();
                          },
                          itemCount: cubit.searchModel!.data!.data!.length),
                    )
                  : const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Search For Product....',
                              style: TextStyle(
                                  fontSize: 29,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Image(
                            image: AssetImage(
                              'assets/search.gif',
                            ),
                            width: 400,
                          ),
                        ],
                      ),
                    ),
            ]),
          ),
        );
      },
    );
  }
}
