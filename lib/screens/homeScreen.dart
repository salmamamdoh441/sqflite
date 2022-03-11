
import 'package:flutter/material.dart';
import 'package:taskapp/helper/db_helper.dart';
import 'package:taskapp/models/taskModel.dart';
import 'package:taskapp/screens/addTask.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task>tasksList;

  @override

  updateList()
  {
    setState(() {
    DataBaseHelper db=DataBaseHelper();
    db.getAllTasks().then((value){
      setState(() {
        tasksList=value;

      });
    });
    });
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>Navigator.pushNamed(context, AddTaskScreen.id),
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.add),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [

                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SmartCode ',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Tasks',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Container(
height: MediaQuery.of(context).size.height*.88,
                width:double.infinity ,
                child: FutureBuilder(

                  future: updateList(),
                  builder: (context,snapshots){
                    if(tasksList==null)
                    {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                      itemCount: tasksList.length,
                      itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.deepPurpleAccent[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:ListTile(
                        title: Text(tasksList[index].title,
                          style:TextStyle(color: Colors.white,
                          decoration:tasksList[index].status=='1'?
                          TextDecoration.lineThrough:TextDecoration.none
                          ,fontSize: 20) ,),
                        subtitle: Text(tasksList[index].date
                        ,style: TextStyle(color: Colors.white),),
                        trailing: Checkbox(

                          onChanged: (value)
                          {


  setState(() {
    if(tasksList[index].status=='0')
    {
      tasksList[index].status='1';
    }
    else
      {
        tasksList[index].status='0';
      }
    print('dsfs');
    DataBaseHelper().updateTask(tasksList[index]);
  });




                          },
                          value: tasksList[index].status=='0'?false:true,
                        ),
                      ),
                    ),
                  ),
              );
            });}
                ))
          ],
        ),
      ),
    );
  }
}
