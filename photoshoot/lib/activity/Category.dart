

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/ApiCalls.dart';
import '../utils/ColorList.dart';
import '../utils/Methods.dart';
import 'Album.dart';

class Category extends StatefulWidget{
  String eventID;
  Category(this.eventID, {Key? key}) : super(key: key);

  @override
  State<Category> createState() => CategoryState();
}

class CategoryState extends State<Category>{

  var height = 0.0, width= 0.0;
  bool isLoading = true;
  var dataLogin, dataCategory;

  @override
  void initState() {
    super.initState();
    ApiCalls.getUserData(widget.eventID)
        .then((value) {
      setState(() {
        if(value != null) {
          dataLogin = json.decode(value)['data'];
          if(dataLogin != null){
            ApiCalls.getCategoryData(dataLogin['access_token'])
                .then((value){
              setState(() {
                isLoading = false;
                dataCategory = json.decode(value)['data'];
              });
            });
          } else {
            Methods.showError(json.decode(value)['message']);
            Navigator.pop(context);
          }
        } else {
          //Methods.showError(json.decode(value)['message']);
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: ColorList.colorAccent,
        centerTitle: true,
        title: const Text(
          'Category',
          style: TextStyle(
            //fontFamily: 'SF_Pro_700',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorList.colorPrimary,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: isLoading
          ? Container(
              height: height,
              color: ColorList.colorAccent,
              child: const Center(
                child: CircularProgressIndicator(
                  color: ColorList.colorDPBorder,
                ),
              ),
            )
          : (dataCategory != null || dataCategory.length > 0)
            ? ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                //scrollDirection: Axis.horizontal,
                itemCount: dataCategory.length,
                itemBuilder: (BuildContext context, int item) =>
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Album(dataCategory[item]['name'], dataCategory[item]['id'], dataLogin['access_token'])),
                        );
                      },
                      child: Container(
                          width: width,
                          height: width * 0.3,
                          margin: EdgeInsets.only(
                            left: height * 0.015,
                            top: (item == 0) ? height * 0.015 : height * 0.015 / 2,
                            right: height * 0.015,
                            bottom: (item == dataCategory.length-1) ? height * 0.015 : height * 0.015 / 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(height * 0.015),
                            color: Colors.black,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Methods.getImage(ApiCalls.urlMain + dataCategory[item]['image'], 'placeholder'),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(height * 0.015),
                                  color: ColorList.colorPrimary.withOpacity(0.5),
                                ),
                              ),
                              Center(
                                //padding: EdgeInsets.all(height * 0.015),
                                child: Text(
                                  dataCategory[item]['name'],
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    ),
              )
            : const Center(
                //padding: EdgeInsets.all(height * 0.015),
                child: Text(
                  'No category found',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              )
    );
  }

}