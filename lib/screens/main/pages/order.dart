import 'package:flutter/material.dart';
import 'package:logos/styles.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title(),
            info(),
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      padding: EdgeInsets.only(left: 30, top: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            "assets/logo.png",
            width: MediaQuery.of(context).size.width * .18,
          ),
          SizedBox(width: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 15),
              Text("Номер заказа", style: genTextStyle(blackColor.withOpacity(0.325))),
              SizedBox(height: 5),
              Text("#123-765", style: genTextStyle(blueColor, 26, FontWeight.w700)),
              SizedBox(height: 7),
              Container(width: 35, height: 5, color: blackColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget info() {
    return Container(
      padding: EdgeInsets.only(left: 30, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15),
          Text("Клиент", style: genTextStyle(blackColor.withOpacity(0.25))),
          SizedBox(height: 15),
          Text("Романов Николай Андреевич", style: genTextStyle(blackColor, normalSize, FontWeight.w500)),
          SizedBox(height: 7),
            Container(height: 1, width: MediaQuery.of(context).size.width - 60, color: blackColor.withOpacity(0.05)),

        ],
      ),
    );
  }
}
