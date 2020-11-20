import 'dart:convert';

import 'package:dio/dio.dart';

class SanketApi {
  String _baseUrl = "https://sanketproject.herokuapp.com/";
  Future<dynamic> getImageDetail(String imageLocation, String filename) async {
    final url = "predict";

    print(_baseUrl + url);

    var dio = Dio();
    print(imageLocation);
    FormData formData = new FormData.fromMap({
      "image": await MultipartFile.fromFile(imageLocation, filename: filename)
    });

    print("$_baseUrl$url");

    var response = await dio.post(
      _baseUrl + url,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.data['result']);
      if (response.data['result'] == null) {
        return "Can't able to Do now";
      }
      return response.data['result'];
    } else {
      throw Exception("Error Occured");
    }
  }
}
