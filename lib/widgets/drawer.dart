import 'package:flutter/material.dart';
import 'package:logos/blocs/bloc.dart';
import 'package:logos/styles.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              ListTile(
                title: Text("Главная"),
                leading: Icon(Icons.home),
              ),
            ]),
          ),
          Container(
            color: blueColor,
            child: ListTile(
              title: Text("Выйти", style: genTextStyle(whiteColor, 18, boldWeight)),
              leading: Icon(Icons.exit_to_app, color: whiteColor),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Вы уверены, что хотите выйти?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "ОТМЕНА",
                            style: genTextStyle(blackColor, 18, boldWeight),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text("ВЫЙТИ", style: genTextStyle(redColor, 18, boldWeight)),
                          onPressed: () {
                            Navigator.of(context).pop();
                            InitBloc.getInstance().dispatch(LogoutInitEvent());
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
