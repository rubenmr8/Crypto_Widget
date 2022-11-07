import 'package:flutter/material.dart';
import 'data_model.dart';
import 'repository.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstScreen(),
      backgroundColor: Color.fromRGBO(11, 12, 54, 1),
    );
  }
}

class CoinLogoWidget extends StatelessWidget {
  final DataModel coin;
  final value;

  const CoinLogoWidget({
    Key? key,
    required this.coin,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("value from coin logo widget");
    print(value);
    var coinIconUrl =
        "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/";
    TextTheme textStyle = Theme.of(context).textTheme;

    return Container(
      // padding: const EdgeInsets.only(left: 16.0),
      height: 96.0,
      width: 96.0,
      //78 Remaining
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 50.0,
              width: 50.0,
              child: CachedNetworkImage(
                imageUrl: ((coinIconUrl + coin.symbol + ".png").toLowerCase()),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    SvgPicture.asset('assets/icons/dollar.svg'),
              )),
          const SizedBox(height: 4.0),
          Text(
            coin.symbol,
            style: textStyle.subtitle1,
          ),
          const SizedBox(height: 2.0),
          Text(
            "\$" + coin.quoteModel.usdModel.price.toStringAsFixed(2),
            style: TextStyle(color: Colors.white),
            // style: textStyle.subtitle2,
          ),
        ],
      ),
    );
  }
}

class CoinListWidget extends StatelessWidget {
  final List<DataModel> coins;

  const CoinListWidget({
    Key? key,
    required this.coins,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var coin = coins[0];
    var coin1 = coins[1];
    var coin2 = coins[10];
    var coin3 = coins[9];
    var coinPrice1 = coin.quoteModel.usdModel;
    var coinPrice2 = coin1.quoteModel.usdModel;
    var coinPrice3 = coin2.quoteModel.usdModel;
    var coinPrice4 = coin3.quoteModel.usdModel;
    var coinLastUpdate = coin.lastUpdated;

    var date1 = coinLastUpdate.split('T')[0];
    var timestamp = coinLastUpdate.split('T')[1].split('.')[0];
    var year = date1.substring(0, 4);
    var month = date1.substring(5, 7);
    var day = date1.substring(8, 10);

    print('year month day ***************');
    print('$year $month $day');

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Text(
              "Crypto Currency",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Expanded(
            child: Container(
              height: 200,
              width: 500,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: coinPrice1.percentChange_24h
                                      .toString()
                                      .contains('-')
                                  ? Colors.red
                                  : Colors.green,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          child: CoinLogoWidget(
                              coin: coin, value: coinPrice1.percentChange_24h)),
                      Container(
                          decoration: BoxDecoration(
                              color: coinPrice2.percentChange_24h
                                      .toString()
                                      .contains('-')
                                  ? Colors.red
                                  : Colors.green,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          child: CoinLogoWidget(
                              coin: coin3,
                              value: coinPrice2.percentChange_24h)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: coinPrice3.percentChange_24h
                                    .toString()
                                    .contains('-')
                                ? Colors.red
                                : Colors.lightGreen,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        child: CoinLogoWidget(
                            coin: coin1, value: coinPrice3.percentChange_24h),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: coinPrice4.percentChange_24h
                                    .toString()
                                    .contains('-')
                                ? Colors.red
                                : Colors.green,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        child: CoinLogoWidget(
                            coin: coin2, value: coinPrice4.percentChange_24h),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        timestamp,
                        style: Theme.of(context).textTheme.headline5,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day + "/" + month + "/" + year,
                        style: Theme.of(context).textTheme.headline5,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late Future<BigDataModel> _futureCoins;
  late Repository repository;

  @override
  void initState() {
    repository = Repository();
    _futureCoins = repository.getCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BigDataModel>(
      future: _futureCoins,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var coinsData = snapshot.data!.dataModel;
            return CoinListWidget(coins: coinsData);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
