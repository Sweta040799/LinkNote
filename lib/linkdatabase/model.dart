class Link{
  int? _id;
  String? _title;
  String? _url;
  String? _date;

  Link(this._title,this._url,this._date);

  Link.withId(this._id,this._title,this._url,this._date);

  int? get id => _id;
  String? get title => _title;
  String? get url => _url;
  String? get date => _date;

  set title(String? newtitle){
    this._title = newtitle;
  }

  set url(String? newurl){
    this._url = newurl;
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
    map['url'] = _url;
    map['date'] = _date;

    return map;
  }

  //Extracting Task object from map
  Link.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._url = map['url'];
    this._date = map['date'];
  }

}