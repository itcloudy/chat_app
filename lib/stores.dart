// Copyright 2018 itcloudy@qq.com.  All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_flux/flutter_flux.dart';

class Coin {
  final String id;
  final String name;
  final String symbol;
  final double price;

  Coin({this.id, this.name, this.symbol, this.price});

  Coin.formJson(Map json)
      : id = json['id'],
        name = json['name'],
        price = double.parse(json['price_usd']),
        symbol = json['symbol'];
}

class CoinRepo {
  Future<Stream<Coin>> getCoins() async {
    String url = "https://api.coinmarketcap.com/v1/ticker/";

    var client = http.Client();
    var streameRes = await client.send(http.Request('get', Uri.parse(url)));
    return streameRes.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((body) => (body as List))
        .map((json) => Coin.formJson(json));
  }
}

class CoinStore extends Store {
  final repo = CoinRepo();
  final List<Coin> _coins = <Coin>[];

  CoinStore(){
    triggerOnAction(loadCoinsAction,(nothing) async{
      var stream = await repo.getCoins();
      if(_coins.isEmpty){
        stream.listen((coin)=>_coins.add(coin));
      }else{
        _coins.clear();
        stream.listen((coin)=>_coins.add(coin));

      }
    });
  }

  List<Coin> get coins => List<Coin>.unmodifiable(_coins);
}

final Action loadCoinsAction = Action();
final StoreToken coinStoreToken = StoreToken(CoinStore());

