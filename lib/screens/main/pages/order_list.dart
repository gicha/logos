import 'package:flutter/material.dart';
import 'package:logos/models/order.dart';
import 'package:logos/styles.dart';
import 'package:logos/widgets/custom_behavor.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Order> orders = [
    Order(59.933409426899935, 30.33400425872196, "Садовая ул. 20", "#143-912"),
    Order(59.93010081819922, 30.344840383142127, "Рубинштейна ул. 20", "#173-438"),
    Order(59.92678784725718, 30.347750579923286, "Московская ул. 6", "#563-087"),
    Order(59.926591612230894, 30.350336229413642, "Достоевского ул. 4", "#692-314"),
    Order(59.960827, 30.277379, "ул. Красного, 30", "#429-895"),
    Order(59.946347, 30.264322, "13-я линия В.О., 72", "#821-325"),
    Order(59.915008, 30.328341, "Можайская ул., 29", "#789-325"),
    Order(59.917152, 30.320916, "Серпуховская ул., 1", "#821-654"),
    Order(59.913532, 30.337160, "н. Обводного к., 66", "#123-325"),
    Order(59.917658, 30.335765, "ул. Марата, 90", "#821-987"),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          backgroundColor: whiteColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Список заказов", style: genTextStyle(blueColor, bigSize)),
            ],
          ),
        ),
        backgroundColor: whiteColor,
        body: SafeArea(
          child: ScrollConfiguration(
            behavior: CustomBehavior(),
            child: SingleChildScrollView(
              child: Container(
                child: Column(children: <Widget>[
                  SizedBox(height: 30.0),
                  ...List.generate(orders.length, (index) {
                    return orderInfoItem(index);
                  })
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget badgePhone() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 0.0),
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
    );
  }

  Widget orderInfoItem(index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: whiteColor,
      margin: EdgeInsets.only(left: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          leftWay(index <= 5, index >= 5),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 30, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Text(orders[index].title, style: genTextStyle(blackColor, 15, normalWeight), maxLines: 4,),
                            width: MediaQuery.of(context).size.width*.35,

                          ),
                          badgePhone()
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(height: 1, width: double.infinity, color: blackColor.withOpacity(0.05)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget leftWay(bool isCircle, bool isActive) {
    return Column(
      children: <Widget>[
        SizedBox(height: 3),
        Container(
          width: 20,
          height: 20,
          decoration: isCircle
              ? BoxDecoration(
                  color: isActive ? blueColor : blackColor.withOpacity(0.1), borderRadius: BorderRadius.circular(45))
              : BoxDecoration(color: isActive ? blueColor : blackColor.withOpacity(0.1)),
        ),
        ...line(),
        ...line(),
        ...line(),
        ...line(),
        ...line(),
      ],
    );
  }

  List<Widget> line() {
    return [
      SizedBox(height: 3),
      Container(
        width: 2,
        height: 8,
        color: blackColor.withOpacity(0.1),
      )
    ];
  }
}
