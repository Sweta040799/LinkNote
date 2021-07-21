import 'package:flutter/material.dart';

class TodoDetail extends StatefulWidget{

  late String title;
  late String des;
  late String date;
  TodoDetail(this.title,this.des,this.date);
  @override
  State<StatefulWidget> createState() => TodoState(this.title,this.des,this.date);
}

class TodoState extends State<TodoDetail>{
  late String title;
  late String des;
  late String date;

  TodoState(this.title,this.des,this.date);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Center(
         child: Container(
           padding: EdgeInsets.only(top: 200,left: 20,right: 20),
           alignment: Alignment.center,
           child: Column(
             children: [

               Expanded(
                 flex: 1,
                   child: Padding(
                       padding: EdgeInsets.only(top: 50),
                       child: Text(title,
                         style: TextStyle(color: Colors.deepPurple,fontSize:25,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,))
               ),

//               SizedBox(height: 10,),

               Container(
                 padding: EdgeInsets.only(left: 50,right: 50),
                 child: Divider(
                   color: Colors.deepPurple,
                   height: 10,
                 ),
               ),

               SizedBox(height: 10,),

               Expanded(
                   flex: 2,
                   child: Padding(
                       padding: EdgeInsets.only(top: 20),
                       child: Text(des,
                           style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w300,fontSize: 20),textAlign: TextAlign.center))
               ),
               SizedBox(height: 30,),

               Expanded(
                   flex: 2,
                   child: Text("Created on \n ${date}",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w300,fontSize: 15),textAlign: TextAlign.center)
               )

             ],
           ),
         ),
       ),
     );
  }

}