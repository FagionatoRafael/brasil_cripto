import 'package:brasilcripto/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/crypto_viewmodel.dart';
import 'views/main_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CryptoViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
        theme: appTheme,
      ),
    ),
  );
}

