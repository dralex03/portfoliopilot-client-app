import 'dart:async';

import '../models/asset.dart';

class DashboardController {
  Future<List<Asset>> loadAssets(String portfolioId) async {
    var completer = Completer<List<Asset>>();

    List<Asset> assetList = List.empty();
    assetList = List.of([
      const Asset(
          '0',
          'Tesla',
          '1800€ (+300€)',
          '3 Stück',
          '600€',
          '500€',
          true
      ),
      const Asset(
          '1',
          'Tesla',
          '1800€ (+300€)',
          '3 Stück',
          '600€',
          '500€',
          true
      ),
      const Asset(
          '2',
          'Tesla',
          '1800€ (+300€)',
          '3 Stück',
          '600€',
          '500€',
          true
      )
    ]);
    completer.complete(assetList);

    await Future.delayed(const Duration(seconds: 1));

    return completer.future;
  }
}