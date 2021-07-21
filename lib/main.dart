import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linkopedia/linkPages/linkmain.dart';
import 'package:linkopedia/splashscreen.dart';
import 'package:linkopedia/todoPages/todomain.dart';


void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "LinkKeeper",
      home: Splash()
    )
  );
}

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>HomeState();
}

class HomeState extends State<Home>{

  int _currIndex = 0;

  final List<Widget> _children = [];
  List<Widget> _tabOption = [
        LinkMain(),
        TodoMain()
  ];

  void _onTapped(int index){
    setState(() {
        _currIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPressed,
      child: Scaffold(
        backgroundColor: Colors.white,

         body: _tabOption.elementAt(_currIndex),

        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white.withOpacity(0.7),
          onTap: _onTapped,

          currentIndex: _currIndex,
          selectedItemColor: Colors.white,
          backgroundColor: Color.fromRGBO(76, 40, 122, 48),
          items: [

            BottomNavigationBarItem(
                icon: Icon(Icons.add_link,size: 30,),
                title: Text("Links",)
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.notes_outlined,size: 30,),
                title: Text("Notes",)
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _onPressed() async{
    SystemNavigator.pop();
    return true;
  }

}


