import 'package:flutter/material.dart';
import 'package:shop_app/models/onboarding_model.dart';
import 'package:shop_app/modules/login_page.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/colors.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardingcontroller = PageController();
  bool isLast = false;
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateToAndFinish(context, LogIn());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: const Text(
              'SKIP',
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == onBoardingPage.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardingcontroller,
                itemCount: onBoardingPage.length,
                itemBuilder: (context, index) {
                  return onBoardingItem(onBoardingPage[index]);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                    count: onBoardingPage.length,
                    controller: boardingcontroller,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: primaryColor)),
                FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: primaryColor,
                  onPressed: () {
                    isLast
                        ? submit()
                        : boardingcontroller.nextPage(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeInOut);
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget onBoardingItem([OnBoardingModel? onBoarding]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Image(image: AssetImage(onBoarding!.image))),
        const SizedBox(
          height: 30,
        ),
        Text(
          onBoarding.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          onBoarding.description,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
