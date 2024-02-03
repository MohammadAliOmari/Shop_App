class OnBoardingModel {
  final String title;
  final String description;
  final String image;
  OnBoardingModel(
      {required this.description, required this.image, required this.title});
}

List<OnBoardingModel> onBoardingPage = [
  OnBoardingModel(
      description: 'OnBoardingDescription1',
      image: 'assets/onborder1.png',
      title: 'OnBoardingTitle1'),
  OnBoardingModel(
      description: 'OnBoardingDescription2',
      image: 'assets/onborder2.png',
      title: 'OnBoardingTitle2'),
  OnBoardingModel(
      description: 'OnBoardingDescription3',
      image: 'assets/onborder3.png',
      title: 'OnBoardingTitle3'),
];
