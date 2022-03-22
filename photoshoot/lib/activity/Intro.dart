import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'Home.dart';


class IntroScreen1 extends StatefulWidget {
  const IntroScreen1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IntroScreen1();
  }
}

class _IntroScreen1 extends State<IntroScreen1> {
  @override
  Widget build(BuildContext context) {
    PageDecoration pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 0.0, fontWeight: FontWeight.w700, color: Colors.black),
      bodyTextStyle: TextStyle(fontSize: 15.0, color: Colors.black),
  
      imagePadding: EdgeInsets.all(20),
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.4, 0.6],
          colors: [Color(0xffF5F5F5), Color(0xffF5F5F5),],
        ),
      ),
    );

    return IntroductionScreen(
      globalBackgroundColor: const Color(0xffF5F5F5),
      pages: [
        PageViewModel(
          bodyWidget: Container(
              decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(30.0),
          bottomLeft: Radius.circular(0.0)),
           color: Color(0xffFF8527),
      ),
           
            height: 300,
            width: 500,
          child: Column(
          children: const [
              SizedBox(height: 20,),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.camera_alt,color: Colors.orange), 
              ),
          
            SizedBox(height: 20,),
            Text('LIVE PHOTO SHARING',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 20,),
            Text('Get instant photos from PK Suri\n Worldwide Studio',style: TextStyle(color: Colors.white),),

          ],
          ),
            
          ),
          title: "",
          // body: "Higher Returns through Investment",
          image: introImage('assets/images/photo1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          bodyWidget: Container(
              decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(30.0),
          bottomLeft: Radius.circular(0.0)),
           color: Color(0xffFF8527),
      ),
           
            height: 300,
            width: 500,
          child: Column(
          children: const [
              SizedBox(height: 20,),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.camera_alt,color: Colors.orange), 
              ),
          
            SizedBox(height: 20,),
            Text('ALL IN ONE STORAGE \n PLACE',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 20,),
            Text('Get your photo from anywhere and \nanytime with PK Suri Studio',style: TextStyle(color: Colors.white),),

          ],
          ),
            
          ),
          image: introImage('assets/images/Group.png'),
          decoration: pageDecoration,
        ),
       /*  PageViewModel(
          title: "Fractional shares",
          body: "Zero Comissions,No minimums",
          image: introImage('assets/photo.png'),
          decoration: pageDecoration,
        ), */
      ],
      onDone: () => goHomepage(context),
      onSkip: () => goHomepage(context),
      showSkipButton: false,
    showNextButton: false,
      
      skip: const Text(
        'Skip',
        style: TextStyle(color: Colors.black),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
      done: const Text(
        'Next',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeColor:Color(0xffFF8527),
        activeSize: Size(10.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  void goHomepage(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return const Home();
    }), (Route<dynamic> route) => false);
  }

  Widget introImage(String assetName) {
    return Align(
      child: Image.asset(assetName, width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }
}
