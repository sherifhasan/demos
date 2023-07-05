import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const getRandomDogImage = 'https://dog.ceo/api/breeds/image/random';

Future<String?> getRandomDogPhoto() async {
  Response response;
  Dio client = Dio();

  try {
    response = await client.get(getRandomDogImage);

    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      return response.data['message'].toString();
    }
  } on DioError catch (e) {
    debugPrint(e.response.toString());
    return null;
  } finally {
    client.close();
  }
  return null;
}
