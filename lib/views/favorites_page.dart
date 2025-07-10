import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/crypto_viewmodel.dart';
import '../widgets/crypto_tile.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CryptoViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Favoritos')),
      body: viewModel.favorites.isEmpty
          ? Center(child: Text('Nenhuma criptomoeda favorita'))
          : ListView.builder(
        itemCount: viewModel.favorites.length,
        itemBuilder: (_, i) {
          final crypto = viewModel.favorites[i];
          return CryptoTile(
            crypto: crypto,
            isFavorite: viewModel.isFavorite(crypto),
            onTap: () => viewModel.toggleFavorite(crypto),
          );
        },
      ),
    );
  }
}
