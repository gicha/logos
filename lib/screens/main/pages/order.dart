import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:logos/blocs/bloc.dart';
import 'package:logos/services/utils.dart';
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
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                map(),
                title(),
                info(),
              ],
            ),
            orderInfo(),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget submitButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 55,
        margin: EdgeInsets.only(bottom: 20),
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: greenColor,
              borderRadius: BorderRadius.circular(45),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(child: Text("Подтвердить доставку", style: genTextStyle(whiteColor, 12, normalWeight))),
          ),
          onTap: () {
            MainBloc.getInstance().dispatch(MainConfirmEvent());
          },
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: MediaQuery.of(context).size.height * .12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Номер заказа", style: genTextStyle(blackColor.withOpacity(0.325))),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text("#123-765", style: genTextStyle(blueColor, 26, FontWeight.w700)),
                  SizedBox(width: 25),
                  badgePhone(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget badgePhone() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 0.0),
        child: GestureDetector(
          onTap: () {
            Utils.launchUrl("tel:+79992193928");
          },
          child: Container(
            width: 120,
            height: 35,
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45), border: Border.all(color: blackColor.withOpacity(0.15))),
            child: Row(
              children: <Widget>[
                Icon(Icons.phone, size: 20, color: blueColor),
                SizedBox(width: 7),
                Text("Позвонить", style: genTextStyle(blackColor, normalSize, FontWeight.w500)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget info() {
    return Container(
      padding: EdgeInsets.only(left: 30, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          stringInfo("Клиент", "Романов Николай Андреевич"),
          stringInfo("Товар", "Тайяки в бочках"),
        ],
      ),
    );
  }

  Widget stringInfo(title, data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 15),
        Text(title, style: genTextStyle(blackColor.withOpacity(0.2))),
        SizedBox(height: 15),
        Text(data, style: genTextStyle(blackColor, normalSize, FontWeight.w500)),
        SizedBox(height: 10),
        Container(height: 1, width: MediaQuery.of(context).size.width - 60, color: blackColor.withOpacity(0.05)),
      ],
    );
  }

  Widget orderInfo() {
    return Align(
      alignment: Alignment.topCenter,
      child: Card(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .22, left: 3, right: 3),
        elevation: 4,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 25),
          child: Row(
            children: <Widget>[
              leftWay(),
              SizedBox(width: 25),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Точка отправки", style: genTextStyle(blackColor.withOpacity(0.25), smallSize)),
                          SizedBox(height: 4),
                          Text("Садовая ул. 20", style: genTextStyle(blackColor, normalSize, FontWeight.w500)),
                        ],
                      ),
                    ),
                    Container(height: 1, width: double.infinity, color: blackColor.withOpacity(0.05)),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Точка доставки", style: genTextStyle(blackColor.withOpacity(0.25), smallSize)),
                          SizedBox(height: 4),
                          Text("Рубинштейна ул. 20", style: genTextStyle(blackColor, normalSize, FontWeight.w500)),
                          SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftWay() {
    return Column(
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: blueColor, borderRadius: BorderRadius.circular(45)),
        ),
        Container(
          width: 2,
          height: 7,
          color: blackColor.withOpacity(0.1),
        ),
        SizedBox(height: 3),
        Container(
          width: 2,
          height: 7,
          color: blackColor.withOpacity(0.1),
        ),
        SizedBox(height: 3),
        Container(
          width: 2,
          height: 7,
          color: blackColor.withOpacity(0.1),
        ),
        SizedBox(height: 3),
        Container(
          width: 2,
          height: 7,
          color: blackColor.withOpacity(0.1),
        ),
        SizedBox(height: 3),
        Container(
          width: 2,
          height: 7,
          color: blackColor.withOpacity(0.1),
        ),
        SizedBox(height: 3),
        Container(
          width: 2,
          height: 4,
          color: blackColor.withOpacity(0.1),
        ),
        Container(
          width: 10,
          height: 10,
          color: blueColor,
        ),
      ],
    );
  }

  Widget map() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .3,
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(51.5, -0.09),
          zoom: 13.0,
          maxZoom: 15,
          interactive: false,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://1.base.maps.api.here.com/maptile/2.1/maptile/newest/reduced.day/{z}/{x}/{y}/256/png8?app_id=wH3fRkM7VQNDr4QAqFhi&app_code=wV9adGXFnerl052QiUC50A",
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 30.0,
                height: 30.0,
                point: LatLng(51.5, -0.09),
                builder: (ctx) => GestureDetector(child: Image.asset(
                  "assets/logo.png",
                  width: 25,
                )),
              ),
              Marker(
                width: 30.0,
                height: 30.0,
                point: LatLng(51.505, -0.092),
                builder: (ctx) => GestureDetector(child: Image.asset(
                  "assets/logo.png",
                  width: 25,
                ),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
