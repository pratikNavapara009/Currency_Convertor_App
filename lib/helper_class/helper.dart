import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model_class/model.dart';

class Apihelper {
  Apihelper._();

  static final Apihelper apihelper = Apihelper._();

  Future<Currency?> fetchData(
      {required String from, required String to, required int amount}) async {
    String api =
        "https://api.exchangerate.host/convert?from=$from&to=$to&amount=$amount";
    http.Response res = await http.get(Uri.parse(api));
    if (res.statusCode == 200) {
      Map decodedData = jsonDecode(res.body);
      Currency currency = Currency.fromMap(data: decodedData);
      return currency;
    }
  }
}
