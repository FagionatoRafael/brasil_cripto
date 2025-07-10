import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/crypto_viewmodel.dart';
import '../widgets/crypto_tile.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CryptoViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Pesquisar Criptomoedas')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              maxLength: 50,
              controller: _controller,
              decoration: InputDecoration(
                  labelText: 'Digite nome ou símbolo',
                  counterText: ''
              ),
              onFieldSubmitted: viewModel.searchCryptos,
            ),
          ),
          if (viewModel.isLoading)
            Expanded(
                child: Center(
                    child: CircularProgressIndicator()
                ),
            )
          else if (viewModel.errorMessage.isNotEmpty)
            Expanded(
              child: Center(
                child: Text(
                  viewModel.errorMessage,
                  style: TextStyle(
                      color: Colors.red,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )

          else
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.cryptos.length,
                itemBuilder: (_, i) {
                  final crypto = viewModel.cryptos[i];
                  return  CryptoTile(
                    crypto: crypto,
                    isFavorite: viewModel.isFavorite(crypto),
                    onTap: () => viewModel.toggleFavorite(crypto),
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}

