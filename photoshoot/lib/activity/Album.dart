import 'dart:convert';

import 'package:flutter/material.dart';

import '../utils/ApiCalls.dart';
import '../utils/ColorList.dart';
import '../utils/Methods.dart';
import 'PhotoViewer.dart';

class Album extends StatefulWidget {
  var categoryName, categoryID, accessToken;

  Album(this.categoryName, this.categoryID, this.accessToken, {Key? key}) : super(key: key);

  @override
  State<Album> createState() => AlbumState();
}

class AlbumState extends State<Album> {

  var height = 0.0, width= 0.0;
  bool isLoading = true;
  var dataAlbum;

  @override
  void initState() {
    super.initState();
    ApiCalls.getAlbumData(widget.categoryID, widget.accessToken)
        .then((value) {
      print(value);
      setState(() {
        if(value != null) {
          dataAlbum = json.decode(value)['data'];
          isLoading = false;
        } else {
          //Methods.showError(value['message']);
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
        title: Text(
          widget.categoryName,
          style: const TextStyle(
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
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: width * 0.33,
                childAspectRatio: 1,
                crossAxisSpacing: width * 0.01,
                mainAxisSpacing: width * 0.01,
              ),
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(width * 0.01),
              itemCount: dataAlbum.length,
              itemBuilder: (BuildContext ctx, item) {
                return InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhotoViewer(
                              ApiCalls.urlMain + dataAlbum[item]['image'],
                              dataAlbum[item]['id'],
                              widget.accessToken
                          )
                      ),
                    );
                  },
                  child: Container(
                    width: width * 0.3,
                    height: width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Methods.getImage(ApiCalls.urlMain + dataAlbum[item]['image'], 'placeholder'),
                      ),
                    ),
                  ),
                );
              }
            ),
    );
  }
}