import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import '../../../styles.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
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
          children: <Widget>[map(), orderInfo(), location(), topTable()],
        ),
      ),
    );
  }

  Widget topTable() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          height: 50,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(45)),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Center(
                    child: Icon(
                      Icons.assignment_turned_in,
                      color: whiteColor,
                      size: 20,
                    )),
              ),
              SizedBox(width: 10),
              Text("Доставлено 5 заказов. Осталось - ", style: genTextStyle(blackColor.withOpacity(0.25), 11.5)),
              Text("10 заказов", style: genTextStyle(blackColor, 11.5, FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget location() {
    return Positioned(
      left: 10,
      bottom: 150,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(45),
            boxShadow: [BoxShadow(color: blackColor.withOpacity(0.5), blurRadius: 6)]),
        child: Center(child: Icon(Icons.navigation, color: blueColor)),
      ),
    );
  }

  Widget orderInfo() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        margin: EdgeInsets.only(bottom: 15, left: 3, right: 3),
        elevation: 2,
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
                          Text("Московский 123", style: genTextStyle(blackColor, normalSize, FontWeight.w500)),
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
                          Text("Московский 123", style: genTextStyle(blackColor, normalSize, FontWeight.w500)),
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

  Widget map() {
    return Container(
      alignment: Alignment.center,
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(51.5, -0.09),
          zoom: 13.0,
          maxZoom: 15,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
            "https://1.base.maps.api.here.com/maptile/2.1/maptile/newest/normal.day.mobile/{z}/{x}/{y}/256/png8?app_id=wH3fRkM7VQNDr4QAqFhi&app_code=wV9adGXFnerl052QiUC50A",
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 30.0,
                height: 30.0,
                point: LatLng(51.5, -0.09),
                builder: (ctx) => GestureDetector(child: FlutterLogo()),
              ),
            ],
          ),
        ],
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
}
