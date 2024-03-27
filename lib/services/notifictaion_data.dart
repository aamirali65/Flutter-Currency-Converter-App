import 'dart:convert';
import 'package:http/http.dart' as http;

class ExchangeRateApiClient {
  static const String _baseUrl = 'https://exchange-rate-api1.p.rapidapi.com/latest';
  static const Map<String, String> _headers = {
    'X-RapidAPI-Key': '6bddb63741msh6b5483235df9bfap1d575cjsn4ded1770c150',
    'X-RapidAPI-Host': 'exchange-rate-api1.p.rapidapi.com',
  };

  static Future<Map<String, dynamic>> getLatestExchangeRates({String baseCurrency = 'USD'}) async {
    final Uri uri = Uri.parse(_baseUrl).replace(queryParameters: {'base': baseCurrency});
    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load exchange rates: ${response.statusCode}');
    }
  }
}