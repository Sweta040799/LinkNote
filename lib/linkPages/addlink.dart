import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:linkopedia/linkdatabase/linkhelper.dart';
import 'package:linkopedia/linkdatabase/model.dart';
import 'package:linkopedia/main.dart';

class AddLink extends StatefulWidget{

  Link link;

  AddLink(this.link);


  @override
  State<StatefulWidget> createState() => AddLinkState(this.link);

}

class AddLinkState extends State<AddLink>{
  DatabaseHelper helper = DatabaseHelper();

  TextEditingController titleController = TextEditingController();
  TextEditingController urlController = TextEditingController();
   Link link;

  AddLinkState(this.link);

  @override
  Widget build(BuildContext context) {

    titleController.text = link.title!;
    urlController.text = link.url!;

    final title = Container(
      padding: EdgeInsets.only(left: 10,right: 10),
      width: 400,
      child: Center(
        child: TextFormField(
          controller: titleController,
          maxLength: 35,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          enableInteractiveSelection: true,
          validator: (value)=> (value==null || value.isEmpty) ? "Title can't be empty":null,
          onChanged: (value){
            link.title = titleController.text;
          },


          style: TextStyle(color: Colors.deepPurple,fontSize: 20),
          obscureText: false,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),

              hintText: "Title",

              hintStyle: TextStyle(color: Colors.deepPurple,fontSize: 20),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.deepPurple, width:2.0),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width:2.0),
                  borderRadius: BorderRadius.circular(5.0)
              )
          ),
        ),
      ),
    );



    final Url = Container(
      padding: EdgeInsets.only(left: 10,right: 10),
      width: 400,
      child: Center(
        child: TextFormField(
          enableInteractiveSelection: true,
          toolbarOptions: ToolbarOptions(
            copy: true,
            cut: true,
            paste: true,
            selectAll: true
          ),
          controller: urlController,
          validator: (value)=> (value==null || value.isEmpty) ? "Title can't be empty":null,
          onChanged: (value){
            link.url = urlController.text;
          },

          style: TextStyle(color: Colors.deepPurple,fontSize: 20),
          obscureText: false,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),

              hintText: "URL",

              hintStyle: TextStyle(color: Colors.deepPurple),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.deepPurple, width:2.0),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width:2.0),
                  borderRadius: BorderRadius.circular(5.0)
              )
          ),
        ),
      ),
    );

    final save = MaterialButton(
      color: Color.fromRGBO(76, 40, 122, 48),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      onPressed: ()  {


        if(titleController.text!=null){
          link.date = DateFormat.yMMMd().format(DateTime.now());

          setState(() {
            _save();

          });

        }

        else{
          dialog("Enter Valid detail");
        }
      },
      child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 20),),
    );



    return WillPopScope(
      onWillPop: _onPressed,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Icon(Icons.arrow_back)),
            title: Text("Link-N-Note",style: TextStyle(color: Colors.white),),
            backgroundColor: Color.fromRGBO(76, 40, 122, 48),
          ),
          body:Form(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 40,),

                      title,
                      SizedBox(height: 20),

                      Url,


                      SizedBox(height: 50,),

                      Container(
                        padding: EdgeInsets.only(left: 100,right: 100),
                        child:  save,
                      )


                    ],
                  ),
                ),
              )
          )
      ),
    );
  }

  Future<bool> _onPressed() async{
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    return true;
  }

  void _save() async{

    moveBack();

    int result;

    if(link.id != null){
      result = await helper.updateLink(link);
    }
    else {
      result = await helper.insertLink(link);
    }

    if(result!=0){
      (link.id != null) ? dialog("Link has been successfully updated") : dialog("Link has been successfully saved");
    }
    else{
      (link.id != null) ? dialog("Link has not been updated") : dialog("Link has not been saved");
    }
  }



  void moveBack() {
    Navigator.pop(context, true);
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