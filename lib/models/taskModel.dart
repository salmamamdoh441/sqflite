import 'package:taskapp/constants.dart';

class Task {
  int id;
  String title;
  String status;
  String description;
  String piority;
  String date;

  Task({this.date,this.title, this.id, this.description, this.piority, this.status});

  toJson()
  {
    return
      {cid :id,
     ctitle :title,
        cdesc:description,
        cpiority:piority,
        cstatus:status,
        cdate:date
      };
  }
  Task.fromJson(Map<String ,dynamic >map)
  {
    id =map[cid];
    title =map[ctitle];
    description=map[cdesc];
    status =map[cstatus];
    piority =map[cpiority];
    date =map [cdate];
  }

}