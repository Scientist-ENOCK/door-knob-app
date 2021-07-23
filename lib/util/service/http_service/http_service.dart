import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  Future<http.Response> httpGet(String url) async {
    var uri = Uri.parse(url);
    http.Response response = await http.get(uri, headers: headers);
    return response;
  }

  Future<http.Response> httpPost(
      String url,  Map<String, String> postData) async {
    var uri = Uri.parse(url);
    http.Response response =
        await http.post(uri, headers: headers, body: json.encode(postData));
    return response;
  }
}
