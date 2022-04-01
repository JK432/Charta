import 'package:charta/functions/Signin.dart';
import 'package:charta/screens/Crudscreens/Scraporderpaper.dart';
import 'package:charta/screens/Detailpage/Scraperpaperdetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charta/functions/Signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../functions/colorfunction.dart';
import '../../functions/database.dart';
import '../Detailpage/Paperdetailspage.dart';

class Scrapperpage extends StatefulWidget {
  static const String routeName = '/scraperpage';
  const Scrapperpage({Key? key}) : super(key: key);

  @override
  _ScrapperpageState createState() => _ScrapperpageState();
}

class _ScrapperpageState extends State<Scrapperpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: AppBar(title: const Text("Home"),actions: [

        TextButton(onPressed: (){
        final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
        provider.logout();

      }, child:Text("Logout",style: TextStyle(color: Colors.white),),),

        TextButton(onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScraperOrder()));
        }, child:Text("myorders",style: TextStyle(color: Colors.white),),),


      ],),
      body:Center(
        child: StreamBuilder<List<Product>>(
            stream: Database().ReadScraperpaper(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {

                return Text('Something went Wrong');
              } else if (snapshot.hasData) {
                final paper = snapshot.data!;

                return ListView(
                  children: <Widget>[
                    Container(
                      height: 100,
                      color: Colors.red,
                    ),
                    const Text("Your Papers",
                        style: TextStyle(fontSize: 40))
                  ] +
                      paper.map((buildPaper)).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),);
  }

  Widget buildPaper(Product paper) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: someColor().generateMaterialColor(Palette.container),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          tileColor: Color.fromRGBO(168, 255, 243, 0),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          leading: CircleAvatar(
            child: Text('${paper.usedpersent}%'),
          ),
          title: Text('${paper.usedpersent}% used'),
          subtitle: Text(
              '${paper.usedpersent}% used ${paper.quantity} kg Available\n${paper.Adress}\n${Database().timeAgo(paper.uploadeddateandtime.toDate())}'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Scraperpaperdetails(
                      url1: paper.url1,
                      url2: paper.url2,
                      productid: paper.productid,
                      quantity: paper.quantity,
                      uploadeddateandtime: paper.uploadeddateandtime,
                      uploaderid: paper.uploaderid,
                      usedpersent: paper.usedpersent,lon: paper.lon,lat:paper.lat ,adress:paper.Adress ,
                    )));
          },
        ),
      ),
    );
  }



}
