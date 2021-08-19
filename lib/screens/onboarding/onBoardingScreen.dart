import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/LoginScreen/LoginScreen.dart';
import 'package:shop_app/shared/Network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> titles = ['SHOP', 'PAY', 'DELIVER'];
    List<AssetImage> onBoardingImages = [
      AssetImage('assets/images/onboard1.png'),
      AssetImage('assets/images/onboard2.png'),
      AssetImage('assets/images/onboard3.png')
    ];

    var boardPageController = PageController();
    bool isLastPage = false ;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(onPressed: onSubmitSkipOnBoard,
              child: Text('SKIP',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => onBoardpageViewItem(titles[index], onBoardingImages[index]),
                itemCount: titles.length,
                controller: boardPageController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index){
                  if(index == titles.length-1)
                    {

                        isLastPage = true ;
                        print('Screen index : $index  - isLastPage : $isLastPage');
                    }
                  else{
                    setState(() {
                      isLastPage = false ;
                    });
                      print('Screen index : $index  - isLastPage : $isLastPage');
                  }
                },
              ),
            ),
            SizedBox(
              height: 90.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardPageController,
                  count: titles.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: primaryColor.shade100,
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      expansionFactor: 4.0,
                      spacing: 5.0),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLastPage)
                    {
                      onSubmitSkipOnBoard();
                    }

                   else
                     {
                      boardPageController.nextPage(duration: Duration(milliseconds: 150), curve: Curves.fastLinearToSlowEaseIn,);
                      print('on pressed isLastPage : $isLastPage');
                     }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                  backgroundColor: primaryColor.shade700,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget onBoardpageViewItem(String title, AssetImage image) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 32.0,
              fontFamily: 'AGENCY',
              fontWeight: FontWeight.w800,
              color: Colors.black54),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing',
          maxLines: 2,
          style: TextStyle(fontFamily: 'AGENCY'),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void onSubmitSkipOnBoard(){
    // save in the shared prefs that on boarding finished.
    CachHelper.putDataInSharedPreference(value: true, key: 'onboard')
    .then((value) {
      if(value)
        navigateAndFinish(context ,LoginScreen());
    });

  }
}
