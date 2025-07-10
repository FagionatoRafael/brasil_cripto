import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/crypto_model.dart';
import '../viewmodels/crypto_viewmodel.dart';
import './widgets/chart_widget.dart';

class CryptoDetailsPage extends StatefulWidget {
  final CryptoModel crypto;

  const CryptoDetailsPage({super.key, required this.crypto});

  @override
  State<CryptoDetailsPage> createState() => _CryptoDetailsPageState();
}

class _CryptoDetailsPageState extends State<CryptoDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<CryptoViewModel>(context, listen: false);
      viewModel.fetchChartData(widget.crypto.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CryptoViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.crypto.name),
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.errorMessage.isNotEmpty
          ? Center(child: Text(viewModel.errorMessage))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.crypto.image,
                  width: 64,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Preço atual: \$${widget.crypto.currentPrice}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Volume de mercado: \$${widget.crypto.marketCap ?? '---'}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              const Text(
                'Gráfico (7 dias)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ChartWidget(chartData: viewModel.chartData),
            ],
          ),
        ),
      ),
    );
  }
}
