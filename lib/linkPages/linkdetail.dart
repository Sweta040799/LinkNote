import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkDetail extends StatefulWidget{

  late String title;
  late String url;
  late String date;
  LinkDetail(this.title,this.url,this.date);
  @override
  State<StatefulWidget> createState() => LinkState(this.title,this.url,this.date);
}

class LinkState extends State<LinkDetail>{
  late String title;
  late String url;
  late String date;


  LinkState(this.title,this.url,this.date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 20,right: 20,top: 100),
            alignment: Alignment.topCenter,
            child: Column(
              children: [

                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height/8,
                    padding: EdgeInsets.only(top: 20),
                    child: Text(title,style: TextStyle(color: Colors.deepPurple,fontSize:25,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                  ),
                ),

                SizedBox(height: 10,),

                Container(
                  height: MediaQuery.of(context).size.height/16,
                  padding: EdgeInsets.only(left: 50,right: 50),
                  child: Divider(
                    color: Colors.deepPurple,
                    height: 10,
                  ),
                ),

                SizedBox(height: 10,),

                Container(
                  height: MediaQuery.of(context).size.height/3,
                  padding: EdgeInsets.only(left: 25,right: 25),
                  child: Linkify(
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    linkStyle: TextStyle(
                      color: Colors.purpleAccent,
                    ),
                    text: '${url}',
                    onOpen: (value){
                      launch(url);
                    } ,
                  ),
                ),
                SizedBox(height: 90,),

                Container(
                  height: MediaQuery.of(context).size.height/8,
                  child: Text(
                      "Created on \n ${date}",
                      style: TextStyle(color: Colors.deepPurple,
                          fontWeight: FontWeight.w300,fontSize: 15),
                      textAlign: TextAlign.center),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

}