import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:logos/blocs/bloc.dart';
import 'package:logos/models/order.dart';

import '../../../styles.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  MapController _mapController = MapController();
  String error;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
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
      child: GestureDetector(
        onTap: (){
          _mapController.move(LatLng(59.913532, 30.337160), 13);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(45),
              boxShadow: [BoxShadow(color: blackColor.withOpacity(0.5), blurRadius: 6)]),
          child: Center(
            child: Image.asset(
              "assets/navigation.png",
              width: 25,
            ),
          ),
        ),
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

  Widget map() {
    List<Order> orders = [
      Order(59.933409426899935, 30.33400425872196, "Садовая ул. 20", "#143-912"),
      Order(59.93010081819922, 30.344840383142127, "Рубинштейна ул. 20", "#173-438"),
      Order(59.92678784725718, 30.347750579923286, "Большая Московская ул. 6", "#563-087"),
      Order(59.926591612230894, 30.350336229413642, "Достоевского ул. 4", "#692-314"),
      Order(59.960827, 30.277379, "улица Красного Курсанта, 30", "#429-895"),
      Order(59.946347, 30.264322, "13-я линия Васильевского острова, 72", "#821-325"),
      Order(59.915008, 30.328341, "Можайская улица, 29", "#789-325"),
      Order(59.917152, 30.320916, "Серпуховская улица, 1", "#821-654"),
      Order(59.913532, 30.337160, "набережная Обводного канала, 66", "#123-325"),
      Order(59.917658, 30.335765, "улица Марата, 90", "#821-987"),
    ];
    return Container(
            alignment: Alignment.center,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(59.913532, 30.337160),
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://1.base.maps.api.here.com/maptile/2.1/maptile/newest/reduced.day/{z}/{x}/{y}/256/png8?app_id=wH3fRkM7VQNDr4QAqFhi&app_code=wV9adGXFnerl052QiUC50A",
                ),
                MarkerLayerOptions(
                  markers: [
                    ...List.generate(orders.length, (index) {
                      return Marker(
                        width: 30.0,
                        height: 30.0,
                        point: LatLng(
                            orders[index].latitude, orders[index].longitude),
                        builder: (ctx) => GestureDetector(
                              child: Image.asset(
                                "assets/logo.png",
                                width: 25,
                              ),
                            ),
                      );
                    }),
                    Marker(
                      width: 15.0,
                      height: 15.0,
                      point: LatLng(59.913532, 30.337160),
                      builder: (ctx) => GestureDetector(
                            child: Container(height: 15, width: 15, decoration: BoxDecoration(color: blueColor, borderRadius: BorderRadius.circular(45))),
                          ),
                    )
                  ],
                ),
              ],
            ),
          );
  }

  void onPositionChanged(MapPosition position, a, b) {
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

  @override
  bool get wantKeepAlive => true;
}
