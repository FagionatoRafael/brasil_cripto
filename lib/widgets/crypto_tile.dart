import 'package:flutter/material.dart';
import '../models/crypto_model.dart';
import '../views/crypto_details_page.dart';

class CryptoTile extends StatelessWidget {
  final CryptoModel crypto;
  final VoidCallback onTap;
  final bool isFavorite;

  const CryptoTile({
    required this.crypto,
    required this.onTap,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CryptoDetailsPage(crypto: crypto),
          ),
        );
      },
      leading: Image.network(crypto.image, width: 40),
      title: Text('${crypto.name} (${crypto.symbol.toUpperCase()})'),
      subtitle: Text('Preço: \$${crypto.currentPrice.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        onPressed: onTap,
      ),
    );
  }
}
