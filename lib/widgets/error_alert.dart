import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog({BuildContext context, String text, Function function}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Container(
            height: 120,
            width: 120,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                    color: Theme.of(context).backgroundColor,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Image(
//                  color: Theme.of(context).accentColor,
                      height: 70.0,
                      width: 90.0,
                      image: AssetImage("assets/images/icon-app.png"),
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
//              Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor,image: DecorationImage(image: ExactAssetImage("assets/images/smalllogo.png"),fit: BoxFit.cover)),
//                height: 60,
//                width: 60,)
//
                  ),
                  Text(text ?? "",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Cairo",
                          fontSize: 16))
                ],
              ),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                "ok",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Cairo",
                    color: Theme.of(context).primaryColor),
              ),
              onPressed: function ?? () => Navigator.pop(context),
            )
          ],
        );
      });
}
