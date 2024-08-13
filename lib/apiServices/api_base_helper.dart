import 'dart:io';
import 'dart:developer';
import 'package:cleanup_mobile/apiServices/app_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:logger/logger.dart';

var logger = Logger();

class ApiBaseHelper {
  final String _baseUrl = "https://webpristine.com/cleanup/public";
  Future<dynamic> get(
    String url,
    Map<String, String>? headers,
  ) async {
    logger.i('Api Get, url ${_baseUrl + url}');
    dynamic responseJson;
    try {
      final response = await http.get(
          Uri.parse(
            _baseUrl + url,
          ),
          headers: headers);
      // log("response of get api ${response.body}");

      responseJson = _returnResponse(
        response,
      );
    } on SocketException {
      throw FetchDataException(
        message: 'No Internet connection',
      );
    }

    return responseJson;
  }

  Future<dynamic> post(
    String url,
    dynamic body,
    Map<String, String>? headers,
  ) async {
    logger.i(
      'Api Post, url ${_baseUrl + url}',
    );

    dynamic responseJson;
    try {
      final response = await http.post(
          Uri.parse(
            _baseUrl + url,
          ),
          body: body,
          headers: headers);
      // log("response of post api ${response.body}");
      responseJson = _returnResponse(
        response,
      );
    } on SocketException {
      throw FetchDataException(
        message: 'No Internet connection',
      );
    }

    return responseJson;
  }

  Future<dynamic> put(
    String url,
    dynamic body,
  ) async {
    log('Api Put, url $url');
    dynamic responseJson;
    try {
      final response = await http.put(
        Uri.parse(
          _baseUrl + url,
        ),
        body: body,
      );
      //  log("response is ${response.body}");

      responseJson = _returnResponse(
        response,
      );
    } on SocketException {
      throw FetchDataException(
        message: 'No Internet connection',
      );
    }
    return responseJson;
  }

  Future<dynamic> delete(
    String url,
  ) async {
    log(
      'Api delete, url $url',
    );
    dynamic apiResponse;
    try {
      final response = await http.delete(
        Uri.parse(
          _baseUrl + url,
        ),
      );
      apiResponse = _returnResponse(
        response,
      );
      //  logger.e("response of delete api ${response.body}");
    } on SocketException {
      throw FetchDataException(
        message: 'No Internet connection',
      );
    }

    return apiResponse;
  }
}

dynamic _returnResponse(
  http.Response response,
) {
  logger.d(response.statusCode);
  switch (response.statusCode) {
    case 200:
      return json.decode(
        response.body.toString(),
      );

    case 400:
      var responseJson = json.decode(
        response.body.toString(),
      );
      return responseJson;
    case 401:
      throw TokenExpired(message: json.decode(response.body)["error"]);
    case 422:
      throw InvalidInputException(
        message: (response.body),
      );

    case 404:
      var responseJson = jsonDecode(response.body)["error"];

      throw NotFoundException(
        message: responseJson,
      );
    case 500:
      var responseJson = json.decode(
        response.body,
      );
      throw Handle500Exception(
        message: responseJson,
      );
    case 201:
      var responseJson = json.decode(
        response.body.toString(),
      );
      return responseJson;
    default:
      throw FetchDataException(
        message:
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
      );
  }
}
