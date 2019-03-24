import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static BaseOptions _options = new BaseOptions(
    baseUrl: 'https://siam-api.herokuapp.com',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  Dio client = new Dio(_options);

  void setApiHeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      client.options.headers['Authorization'] = 'Bearer $token';
    } else {
      clearAuthToken();
    }
  }

  void setAuthToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    setApiHeader();
  }

  void clearAuthToken() async {
    print('CLEAR AUTH TOKEN');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    client.options = _options;
    prefs.clear();
  }

  dynamic post(String path, {dynamic data}) async {
    try {
      final response = await client.post(
        path,
        data: data,
      );
      return response.data;
    } on DioError catch (e) {
      print('Error happened:');
      print(e.response.data);
      throw new Exception(e.response.data['message']);
    }
  }

  dynamic get(String path) async {
    try {
      final response = await client.get(path);
      return response.data;
    } on DioError catch (e) {
      print('Error happened:');
      print(e.response.data);
      throw new Exception(e.response.data['message']);
    }
  }
}

final api = Api();
