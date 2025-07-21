import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'coin_data.dart';
// Example currency list (make sure you have this in coin_data.dart if you're importing it)

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String exchangeRate = '?';
  bool isLoading = false;

  void getExchangeRate(String from, String to) async {
    setState(() {
      isLoading = true;
    });

    String URL =
        "https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_RdCnNoED6jWhs73AOXVKMBoQIjkNR638ul0NhgNS";

    try {
      http.Response response = await http.get(Uri.parse(URL));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        double fromRate = data['data'][from];
        double toRate = data['data'][to];

        double conversionRate = toRate / fromRate;

        setState(() {
          exchangeRate = conversionRate.toStringAsFixed(2);
        });
      } else {
        setState(() {
          exchangeRate = 'Error!';
        });
        print('Request failed: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        exchangeRate = 'Error!';
      });
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getExchangeRate(selectedCurrency, 'INR');
  }

  Widget buildCard() {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.all(18),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 28.0),
        child: Text(
          isLoading ? 'Loading..' : '1 $selectedCurrency = $exchangeRate INR',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
      ),
    );
  }

  Widget buildPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      scrollController: FixedExtentScrollController(
        initialItem: currenciesList.indexOf(selectedCurrency),
      ),
      onSelectedItemChanged: (int index) {
        setState(() {
          selectedCurrency = currenciesList[index];
        });
        getExchangeRate(selectedCurrency, 'INR');
      },
      children: currenciesList
          .map(
            (currency) => Text(currency, style: TextStyle(color: Colors.white)),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildCard(),
          Container(
            height: 150,
            color: Colors.lightBlue,
            padding: EdgeInsets.only(bottom: 30),
            child: buildPicker(),
          ),
        ],
      ),
    );
  }
}
