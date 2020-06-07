import 'dart:convert';

import 'package:http/http.dart' as http;
const baseURL='https://rest.coinapi.io/v1/exchangerate/';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future<List<String>> getCoinData(String currencyType) async{
    final String BTCURL= baseURL+'BTC'+'/'+currencyType;
    final String ETHURL= baseURL+'ETH'+'/'+currencyType;
    final String LTCURL= baseURL+'LTC'+'/'+currencyType;

    var BTCresponse=await http.get(BTCURL,headers: {'X-CoinAPI-Key':'F936BBDF-1C80-4535-9765-B90DA20B2961','Content-Type':'application/json'});
    var ETHresponse=await http.get(ETHURL,headers: {'X-CoinAPI-Key':'F936BBDF-1C80-4535-9765-B90DA20B2961','Content-Type':'application/json'});
    var LTCresponse=await http.get(LTCURL,headers: {'X-CoinAPI-Key':'F936BBDF-1C80-4535-9765-B90DA20B2961','Content-Type':'application/json'});

    var BTCjsonResponse=jsonDecode(BTCresponse.body);
    var ETHjsonResponse=jsonDecode(ETHresponse.body);
    var LTCjsonResponse=jsonDecode(LTCresponse.body);


    if(BTCjsonResponse['error']==Null && ETHjsonResponse['error']==Null && LTCjsonResponse['error']==Null) {
      String BTCcurrencyRate = BTCjsonResponse['rate'].toString();
      String ETHcurrencyRate = ETHjsonResponse['rate'].toString();
      String LTCcurrencyRate = LTCjsonResponse['rate'].toString();

      print(BTCjsonResponse);
      return [BTCcurrencyRate, ETHcurrencyRate, LTCcurrencyRate];
    }
    else{
      String err="Too many requests!";
      return [err, err, err];
    }
  }


}
