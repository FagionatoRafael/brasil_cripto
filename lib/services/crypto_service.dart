import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import '../models/crypto_model.dart';

class CryptoService {
  Future<List<CryptoModel>> search(String query) async {
    final searchUrl = Uri.https('api.coingecko.com', '/api/v3/search', {
      'query': query.trim(),
    });
    final searchResponse = await http.get(searchUrl);

    if (searchResponse.statusCode != 200) {
      throw Exception('Erro na busca');
    }

    final decoded = jsonDecode(searchResponse.body);
    final coinIds = (decoded['coins'] as List)
        .map((e) => e['id'] as String)
        .take(10)
        .toList();

    if (coinIds.isEmpty) return [];

    final marketUrl = Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=${coinIds.join(',')}',
    );

    final marketResponse = await http.get(marketUrl);

    if (marketResponse.statusCode != 200) {
      throw Exception('Erro ao buscar dados de mercado');
    }

    final List data = jsonDecode(marketResponse.body);
    return data.map((e) => CryptoModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> fetchChartData(String coinId, {int days = 7}) async {
    final url = Uri.parse('https://api.coingecko.com/api/v3/coins/$coinId/market_chart?vs_currency=usd&days=$days');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao buscar dados do gráfico');
    }
  }

}
