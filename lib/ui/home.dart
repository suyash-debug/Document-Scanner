import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_genius_scan/flutter_genius_scan.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
import 'package:project_show/utils/constant.dart';
import 'package:project_show/utils/firebase_auth.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 5.0,
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/logos/logout.svg"),
            onPressed: () {
              AuthProvider().logOut();
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.orange,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.orange,
              elevation: 5,
              textColor: Colors.white,
              onPressed: () {
                FlutterGeniusScan.scanWithConfiguration({
                  'source': 'camera',
                  'multiPage': true,
                }).then((result) {
                  String pdfUrl = result['pdfUrl'];
                  OpenFile.open(pdfUrl.replaceAll("file://", '')).then(
                      (result) => debugPrint('result'),
                      onError: (error) => displayError(context, error));
                }, onError: (error) => displayError(context, error));
              },
              child: Text(
                "START SCANNING",
                style: kLabelStyle,
              ),
            ))
          ],
        ),
      ),
    );
  }

  void displayError(BuildContext context, PlatformException error) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.message)));
  }
}
