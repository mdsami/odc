import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'account_devied_page.dart';

class SlidePages extends StatefulWidget {
  @override
  _SlidePagesState createState() => _SlidePagesState();
}

class _SlidePagesState extends State<SlidePages> {
 bool click=false;
  @override
  Widget build(BuildContext context) {
    final pages = [
      FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("images/first_page.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Get your doctor anytime from anywhere",style:SlidingScreenMsgText, textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.all(.0),
                child: FlatButton(
                  onPressed: ()async {
                    click=true;
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                     await prefs.setBool('time',click);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AccountType()),
                    );
                  },
                  child:Text(
                    "Skip",
                    style: SkipTextStyle,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("images/hospital.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Always laugh while you can,it is a cheap medicine",style:SlidingScreenMsgText, textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: ()async {
                                        click=true;
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                     await prefs.setBool('time',click);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AccountType()),
                    );
                  },
                  child:Text(
                    "Skip",
                    style: SkipTextStyle,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("images/call.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(right:50.0),
                child: Text("Get your service from home",style:SlidingScreenMsgText, textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100,right: 20),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                  padding:EdgeInsets.only(top:10,left: 20,bottom: 10,right: 20),
                  color: BasedBlueColor,
                  onPressed: ()async {
                                        click=true;
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                     await prefs.setBool('time',click);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AccountType()),
                    );
                  },
                  child:Text(
                    "Get started",
                    style: PagesBottonText,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    ];
    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        enableLoop: false,
        fullTransitionValue: 300,
        enableSlideIcon: true,
        waveType: WaveType.liquidReveal,
        positionSlideIcon: 0.5,
      ),
    );
  }
}
