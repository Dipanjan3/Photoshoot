import 'package:http/http.dart' as http;

import 'Methods.dart';

class ApiCalls {

  static String urlMain = 'https://photoshot.prisminfoways.com/';

  static String urlHomePage = urlMain + 'api/homepage';
  static String urlLogin = urlMain + 'api/login';
  static String urlCategory = urlMain + 'api/category_list';
  static String urlAlbum = urlMain + 'api/category_images';

  static var headersJSON = {
    'Content-Type': 'application/json'
  };

  static getHomepageData() async {
    try {
      var request = http.Request('POST', Uri.parse(urlHomePage));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseHomePage = await response.stream.bytesToString();
        return responseHomePage;

      } else {
        Methods.showError(response.reasonPhrase);
        return null;
      }
    } on Exception catch(e) {
      Methods.showError('$e');
      return null;
    }
  }

  static getUserData(eventID) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(urlLogin));

      request.fields.addAll({
        'event_id': eventID
      });

      request.headers.addAll(headersJSON);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseLogin = await response.stream.bytesToString();
        return responseLogin;

      } else {
        Methods.showError(response.reasonPhrase);
        return null;
      }
    } on Exception catch(e) {
      Methods.showError('$e');
      return null;
    }
  }

  static getCategoryData(accessToken) async {
    try {

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };

      var request = http.Request('POST', Uri.parse(urlCategory));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseCategory = await response.stream.bytesToString();
        return responseCategory;

      } else {
        Methods.showError(response.reasonPhrase);
        return null;
      }
    } on Exception catch(e) {
      Methods.showError('$e');
      return null;
    }
  }

  static getAlbumData(categoryID, accessToken) async {
    try {

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };

      var request = http.MultipartRequest('POST', Uri.parse(urlAlbum));

      request.fields.addAll({
        'id': '$categoryID'
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      print(headers);

      if (response.statusCode == 200) {
        var responseCategory = await response.stream.bytesToString();
        return responseCategory;

      } else {
        Methods.showError(response.reasonPhrase);
        return null;
      }
    } on Exception catch(e) {
      Methods.showError('$e');
      return null;
    }
  }

}