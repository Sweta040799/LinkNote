import 'dart:async';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linkopedia/linkPages/addlink.dart';
import 'package:linkopedia/linkPages/linkdetail.dart';
import 'package:linkopedia/linkdatabase/linkhelper.dart';
import 'package:linkopedia/linkdatabase/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:share/share.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class LinkMain extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LinkMainState();

}

class LinkMainState extends State<LinkMain>{

  DatabaseHelper helper = DatabaseHelper();
  late List<Link> todoList = [];
  late Link link;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    updateListView();

    if(todoList == null){
      todoList = <Link>[];
      updateListView();
    }


    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: (){
              SystemNavigator.pop();
            },
            child: Icon(Icons.arrow_back)
        ),

        title: Text("Link-O-Pedia",style: TextStyle(color: Colors.white)),

        backgroundColor: Color.fromRGBO(76, 40, 122, 48),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(76, 40, 122, 48),
        onPressed: () {
          getDetail(Link('','',''));
        },
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
      body: Container(
//          updateListView(),
          child: (count == 0)?Center(child: Text('Add Link to View Here\n\nSwipe left to Edit, Delete, Share',
            style:TextStyle(color: Colors.black26,fontSize: 18),textAlign: TextAlign.center,)):
          Padding(
              padding: EdgeInsets.only(top: 10),
              child: getTodoListView())
      ),
    );
  }

  void getDetail(Link link) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddLink(link)));

    if(result == true){
      updateListView();
    }
  }

  void getUpdate(Link link) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddLink(link)));

    if(result == true){
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = helper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Link>> todoListFuture = helper.getLinkList() as Future<List<Link>>;
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          this.count = todoList.length;
        });
      });
    });
  }

  void _delete(BuildContext context, Link link) async {
    int result = await helper.deleteLink(link.id!);
    if (result != 0) {
      dialog("The Link has been successfully deleted");
          updateListView();
    }
  }

  ListView getTodoListView(){
    return ListView.builder(
        itemCount: count,
        itemBuilder: (context, int position){
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  LinkDetail(this.todoList[position].title!,this.todoList[position].url!,this.todoList[position].date!)));
            },
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              secondaryActions: [
                IconSlideAction(
                  caption: "Edit",
                  color: Color.fromRGBO(67, 7, 122, 48),
                  icon: Icons.edit,
                  onTap: (){
                    Slidable.of(context);
                    getUpdate(this.todoList[position]);
                  },
//                  closeOnTap: ,
                ),
                IconSlideAction(
                  caption: "Delete",
                  color: Color.fromRGBO(77,24,128,50),
                  icon: Icons.delete,
                  onTap: (){
                    Slidable.of(context);
                    _delete(context, todoList[position]);
                  },
//                  closeOnTap: ,
                ),
                IconSlideAction(
                  caption: "Share",
                  color: Color.fromRGBO(96, 23, 128, 50),
                  icon: Icons.share,
                  onTap: (){
                    Slidable.of(context);
                    Share.share(this.todoList[position].url!);
                  },
//                  closeOnTap: ,
                )
              ],
              child: Card(
                color: Colors.white,
                shadowColor: Colors.deepPurple,
                elevation: 2.0,
                child: ListTile(
//                 leading: Icon(Icons.aarrowrrow_circle_down,size: 10,color:Colors.deepPurple),
                  title: Text((this.todoList[position].title!),
                    style: TextStyle(color: Colors.deepPurple,fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text((this.todoList[position].date!),
                    style: TextStyle(color: Colors.deepPurple,fontSize: 13,fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  void dialog(String str){

      showDialog(

          context: context,
          builder: (context){

            return GestureDetector(
              onTap: (){
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: AlertDialog(
                backgroundColor: Colors.black.withOpacity(0.6),
                title: Text(str,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            );
          });

  }

}

