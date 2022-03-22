import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photoshoot/activity/Category.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_html/flutter_html.dart';

import '../utils/ApiCalls.dart';
import '../utils/ColorList.dart';
import '../utils/Methods.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home>{

  var height = 0.0, width= 0.0;
  bool isLoading = true;
  var dataSettings, dataPortfolio;
  TextEditingController controllerEventID = TextEditingController();

  @override
  void initState() {
    super.initState();
    //controllerEventID.text = 'PHOTO2566';
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    ApiCalls.getHomepageData()
        .then((value) {
      setState(() {
        isLoading = false;
        if(value != null) {
          dataSettings = json.decode(value)['data']['setting'];
          dataPortfolio = json.decode(value)['data']['portfolio'];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return isLoading
        ? Container(
            height: height,
            color: ColorList.colorAccent,
            child: const Center(
              child: CircularProgressIndicator(
                color: ColorList.colorDPBorder,
              ),
            ),
          )
        : Scaffold(
            body: SlidingUpPanel(
                parallaxEnabled: true,
                //isDraggable: false,
                color: Colors.transparent,
                minHeight: height * 0.7,
                maxHeight: height * 0.8,
                panel: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: height * 0.15 / 2,
                        ),
                        Container(
                          width: width,
                          height: height * 0.725,
                          padding: EdgeInsets.all(height * 0.025),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(height * 0.02),
                              topRight: Radius.circular(height * 0.02)
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () => Methods.openURL(dataSettings['facebook_link']),
                                    child: Image(
                                      image: const AssetImage('assets/images/fb.png'),
                                      height: height * 0.05,
                                      width: height * 0.05,
                                    ),
                                  ),
                                  SizedBox(
                                    width: height * 0.015,
                                  ),
                                  InkWell(
                                    onTap: () => Methods.openURL(dataSettings['twitter_link']),
                                    child: Image(
                                      image: const AssetImage('assets/images/twitter.png'),
                                      height: height * 0.05,
                                      width: height * 0.05,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () => Methods.openURL(dataSettings['linkedin_link']),
                                    child: Image(
                                      image: const AssetImage('assets/images/linkedin.png'),
                                      height: height * 0.05,
                                      width: height * 0.05,
                                    ),
                                  ),
                                  SizedBox(
                                    width: height * 0.015,
                                  ),
                                  InkWell(
                                    onTap: () => Methods.openURL(dataSettings['insta_link']),
                                    child: Image(
                                      image: const AssetImage('assets/images/instagram.png'),
                                      height: height * 0.05,
                                      width: height * 0.05,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.025,
                              ),
                              const Text(
                                'EVENT ID',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorList.colorAccent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  shape: BoxShape.rectangle,
                                  //border: Border.all(color: ColorList.colorDPBorder, width: 2, style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(height * 0.015),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: controllerEventID,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.go,
                                        cursorColor: ColorList.colorPrimary,
                                        onEditingComplete: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Category(controllerEventID.text)),
                                          );
                                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                                          FocusScope.of(context).requestFocus(FocusNode());
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(height * 0.015),
                                          hintText: 'Enter Event ID',
                                          focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(0.0)),
                                            borderSide: BorderSide(color: Colors.transparent, width: 0),
                                          ),
                                          enabledBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(0.0)),
                                            borderSide: BorderSide(color: Colors.transparent, width: 0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: ColorList.colorDPBorder,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(height * 0.015),
                                              bottomRight: Radius.circular(height * 0.015))
                                      ),
                                      child: IconButton(
                                          icon: const Icon(Icons.arrow_forward_outlined, color: Colors.white,),
                                          onPressed: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => Category(controllerEventID.text)),
                                            );
                                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                                            FocusScope.of(context).requestFocus(FocusNode());
                                          }
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {

                                    },
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 10,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(0.0, height * 0.025, 0.0, 0.0),
                                            child: const Text(
                                              'PORTFOLIO',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 10,
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(0.0, height * 0.0125, 0.0, 0.0),
                                            child: SizedBox(
                                              height: width * 0.4,
                                              child: ListView.builder(
                                                  physics: const ClampingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: dataPortfolio.length,
                                                  itemBuilder: (BuildContext context, int item) =>
                                                      Container(
                                                        width: width * 0.3,
                                                        //color: ColorList.colorPrimary,
                                                        margin: EdgeInsets.only(
                                                          left: item == 0 ? 0 : width * 0.025,
                                                          right: item == dataPortfolio.length - 1 ? 0 : width * 0.025
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: ColorList.colorAccent,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey.withOpacity(0.5),
                                                              spreadRadius: 2,
                                                              blurRadius: 10,
                                                              offset: const Offset(0, 2),
                                                            ),
                                                          ],
                                                          shape: BoxShape.rectangle,
                                                          //border: Border.all(color: ColorList.colorDPBorder, width: 2, style: BorderStyle.solid),
                                                          borderRadius: BorderRadius.circular(height * 0.01),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              width: width * 0.3,
                                                              height: width * 0.3,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(height * 0.01),
                                                                color: Colors.black,
                                                                image: DecorationImage(
                                                                  fit: BoxFit.cover,
                                                                  image: Methods.getImage(ApiCalls.urlMain + dataPortfolio[item]['image'], 'placeholder'),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: width * 0.1,
                                                              alignment: Alignment.center,
                                                              child: Text(
                                                                dataPortfolio[item]['name'],
                                                                style: const TextStyle(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.normal,
                                                                    color: Colors.black
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: height * 0.025,
                                  ),
                                  SizedBox(
                                    child: const Text(
                                      'About Us',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black
                                      ),
                                    ),
                                    width: width,
                                  ),
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  SizedBox(
                                    child: SingleChildScrollView(
                                      child: Html(
                                        data: dataSettings['about_us'],
                                        style: {
                                          '#': Style(
                                            fontSize: const FontSize(14.0),
                                            textAlign: TextAlign.center,
                                          ),
                                        },
                                      ),
                                    ),
                                    height: height * 0.175,
                                    width: width,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: width,
                      height: height * 0.15,
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Container(
                          width: height * 0.15,
                          height: height * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            shape: BoxShape.rectangle,
                            border: Border.all(color: ColorList.colorDPBorder, width: 2, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(height * 0.015),
                            color: Colors.black,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Methods.getImage(ApiCalls.urlMain + dataSettings['icon'], 'placeholder'),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                body: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: height * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Methods.getImage(ApiCalls.urlMain + dataSettings['main_image'], 'placeholder'),
                        ),
                      ),
                    ),
                  ],
                )
            ),
    );
  }

}