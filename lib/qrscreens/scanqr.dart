

import 'package:charta/functions/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanScreen extends StatefulWidget {
  String? qrstring;
  ScanScreen({ Key? key,this.qrstring}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var qRstring ='Not Scanned';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(qRstring,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30
              ),
            ),
            ElevatedButton(onPressed:(){scanQR();

            } , child: Text('Scan QR Code')),
            ElevatedButton(onPressed: (){Database().Scanreadpaper(qRstring, context);}, child: Text('Redirect'))
          ],
        ),
      ),
    );
  }
  Future<void> scanQR() async{
    try {
      FlutterBarcodeScanner.scanBarcode(
          '#2A99CF', 'Cancel', true, ScanMode.QR
      ).then((value) => setState((){
        qRstring=value;
        widget.qrstring=qRstring;

      }));

    }
    on PlatformException catch(e){
      setState(() {
        qRstring='Try Again';
      });
    }

    catch (e) {
      setState(() {
        qRstring='Unable to Scan';
      });
    }


  }
}