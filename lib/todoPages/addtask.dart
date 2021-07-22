import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linkopedia/main.dart';
import 'package:linkopedia/tododatabase/helper.dart' ;
import 'package:linkopedia/tododatabase/model.dart';
import 'dart:async';
import 'package:intl/intl.dart';



class AddTask extends StatefulWidget{

   Task todo;

  AddTask(this.todo);

  @override
  State<StatefulWidget> createState() {
      return AddTaskState(this.todo);
  }

}

class AddTaskState extends State<AddTask>{
  DatabaseHelper helper = DatabaseHelper();

  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
   Task todo;


  AddTaskState(this.todo);



  @override
  Widget build(BuildContext context) {

     titleController.text= todo.title!;
     desController.text= todo.description!;




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
              todo.title = titleController.text;
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

    final description = Container(
      padding: EdgeInsets.only(left: 10,right: 10),
      width: 400,
      child: Center(
        child: TextFormField(
          controller: desController,
          maxLines: 8,
          maxLength: 400,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          enableInteractiveSelection: true,
          onChanged: (value){
            (value!=null)?todo.description=desController.text:todo.description = '';
          },
          style: TextStyle(color: Colors.deepPurple,fontSize: 20),
          obscureText: false,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),

              hintText: "Description......",

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



    final save = MaterialButton(
      color: Color.fromRGBO(76, 40, 122, 48),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      onPressed: ()  {



        if(titleController.text!=null){
          todo.date = DateFormat.yMMMd().format(DateTime.now());
          
          setState(() {
            _save();

          });

        }
        
        else{
          dialog('Title cannot be empty');

        }
        },

      child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 20),),
    );



    return Scaffold(
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

                    description,

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
    );
  }

  Future<bool> _onPressed() async{
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    return true;
  }

  void _save() async{

      moveBack();

      int result;

      if(todo.id != null){
        result = await helper.updateTodo(todo);
      }
      else{
        result = await helper.insertTodo(todo);
      }


      if(result != 0){
        (todo.id != null) ? dialog('Task has been successfully updated') : dialog('Task has been successfully saved');
      }
      else {
        (todo.id != null) ? dialog('Task has not been updated') : dialog('Task has not been saved');
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

