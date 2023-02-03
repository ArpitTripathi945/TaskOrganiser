import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? taskcount;
  String? taskdata;
  DateTime? time;

  TaskModel({this.taskcount, this.taskdata, this.time});

  //receiving data from server
  factory TaskModel.fromMap(map) {
    return TaskModel(
      taskcount: map['taskcount'],
      taskdata: map['taskdata'],
      time: (map['time'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskcount': taskcount,
      'taskdata': taskdata,
      'time': time,
    };
  }
}
