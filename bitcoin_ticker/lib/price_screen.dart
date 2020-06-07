import 'package:bitcointicker/coin_data.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;



class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currencySelectedAndroid="USD";
  String currencySelectedIOS;
  String BTC,ETH,LTC;

  DropdownButton getDropDownListItemsAndroid(){
    List<DropdownMenuItem<String>> currencylistitems=[];

    for(String currency in currenciesList)
    {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency,);
      currencylistitems.add(newItem);
    }

    return DropdownButton<String>(
        value:currencySelectedAndroid,
        items:currencylistitems,
        onChanged: (value) async{
          CoinData coinData=CoinData();
          List<String> currencyFromCoinData=await coinData.getCoinData(currencySelectedAndroid);
          setState((){
            currencySelectedAndroid=value;
            BTC=currencyFromCoinData[0];
            ETH=currencyFromCoinData[1];
            LTC=currencyFromCoinData[2];
          });
        });


  }

//  CupertinoPicker getDropDownListItemsIOS()
//  {
//        List<Text> currencylistitems=[];
//
//      for(String currency in currenciesList)
//      {
//      var newItem = Text(currency);
//      currencylistitems.add(newItem);
//      }
//
//      return CupertinoPicker(
//          itemExtent: 32.0,
//          backgroundColor: Colors.lightBlue,
//          onSelectedItemChanged: (selectedIndex) async
//          {
//            CoinData coinData=CoinData();
//            List<String> currencyFromCoinData=await coinData.getCoinData(currencySelectedIOS);
//            setState(() {
//              currencySelectedIOS=currenciesList[selectedIndex];
//              print(currencySelectedIOS);
//            });
//          },
//          children: currencylistitems
//      );


 // }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 10),
                    child:currencyCards('BTC',BTC),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(18.0, 0, 18.0, 10),
                    child:currencyCards('ETH',ETH)
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(18.0, 0, 18.0, 10),
                    child:currencyCards('LTC',LTC)
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child:(Platform.isIOS) ? getDropDownListItemsAndroid() : getDropDownListItemsAndroid(),
            ),
          ),
        ],
      ),
    );
  }

  Card currencyCards(String cryptoCurrency,String cryptoCurrencyRate){
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $cryptoCurrency = $cryptoCurrencyRate $currencySelectedAndroid',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
