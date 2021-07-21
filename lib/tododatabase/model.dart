class Task{
  int? _id ;
  String? _title ;
  String? _description ;
  String? _date ;

  Task(this._title,this._date,this._description);

  Task.withId(this._id,this._title,this._date,this._description);

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get date => _date;

  set title(String? newtitle){
       this._title = newtitle;
  }

  set description(String? newdes){
    this._description = newdes;
  }

  set date(String? newdate){
    this._date = newdate;
  }

  Map<String, dynamic> toMap(){
      var map = Map<String, dynamic>();

      if(id != null){
        map['id'] = _id;
      }
      map['title'] = _title;
      map['description'] = _description;
      map['date'] = _date;

      return map;
  }


   Task.fromMapObject(Map<String, dynamic> map){
       this._id = map['id'];
       this._title = map['title'];
       this._description = map['description'];
       this._date = map['date'];
   }

}