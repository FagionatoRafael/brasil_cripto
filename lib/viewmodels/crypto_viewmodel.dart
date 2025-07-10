import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/crypto_model.dart';
import '../services/crypto_service.dart';

class CryptoViewModel extends ChangeNotifier {
  final CryptoService _service = CryptoService();
  List<CryptoModel> cryptos = [];
  List<CryptoModel> favorites = [];

  bool isLoading = false;
  String errorMessage = '';

  List<FlSpot> chartData = [];

  CryptoViewModel() {
    loadFavorites();
  }

  bool isValidQuery(String query) {
    final regex = RegExp(r'^[a-zA-Z0-9\s\-]{1,50}$');
    return regex.hasMatch(query.trim());
  }

  Future<void> searchCryptos(String query) async {
    isLoading = true;
  errorMessage = '';
  notifyListeners();

  try {
  cryptos = await _service.search(query);
  } catch (e) {
  errorMessage = 'Erro ao buscar criptomoedas: $e';
  cryptos = [];
  } finally {
  if (cryptos.isEmpty || !isValidQuery(query)) errorMessage = 'Nenhuma criptomoeda encontrada';
  isLoading = false;
  notifyListeners();
  }
  }

  Future<void> fetchChartData(String coinId, {int days = 7}) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final data = await _service.fetchChartData(coinId, days: days);

      if (data['prices'] == null) throw Exception('Sem dados');

      // Timestamp do primeiro ponto
      final base = data['prices'].first[0].toDouble();
      chartData = data['prices'].map<FlSpot>((p) {
        // Converte o timestamp em milissegundos para dias (relativo ao primeiro ponto)
        final x = (p[0].toDouble() - base) / 1000 / 60 / 60 / 24;
        return FlSpot(x, p[1].toDouble());
      }).toList();
    } catch (e) {
      errorMessage = 'Erro ao carregar gráfico';
      chartData = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool isFavorite(CryptoModel crypto) {
    return favorites.any((c) => c.id == crypto.id);
  }

  void toggleFavorite(CryptoModel crypto) {
    if (isFavorite(crypto)) {
      favorites.removeWhere((c) => c.id == crypto.id);
    } else {
      favorites.add(crypto);
    }
    saveFavorites();
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList =
    favorites.map((crypto) => jsonEncode(crypto.toJson())).toList();
    prefs.setStringList('favorites', jsonList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList('favorites');
    if (jsonList != null) {
      favorites = jsonList
          .map((jsonStr) => CryptoModel.fromJson(jsonDecode(jsonStr)))
          .toList();
      notifyListeners();
    }
  }
}
