import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskapp/helper/db_helper.dart';
import 'package:taskapp/models/taskModel.dart';
import 'package:taskapp/widgets/customTextField.dart';

class AddTaskScreen extends StatefulWidget {
 static String id ='addTaskScreen';
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
 DataBaseHelper db =DataBaseHelper();
  GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  String title ='';
  String description='';
  String level ='';
  String pi;
  DateTime dateTime =DateTime.now();
  TextEditingController dateController=TextEditingController();
  DateFormat dateFormat=DateFormat('MM dd ,yyyy ');


  handleDatePicker()async{
    final DateTime date =await
    showDatePicker
      (

        initialEntryMode: DatePickerEntryMode.calendar,
        context: context,
        initialDate:
  dateTime,
        firstDate: DateTime(2000), lastDate: DateTime(2030));
    if(date !=null && date !=dateTime)
    {
      setState(() {
        dateTime=date;


      });

    setState(() {
      dateController.text=dateFormat.format(dateTime);
    });

    }
  }
  @override

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){FocusScope.of(context).unfocus();},
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    BackButton(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Add Task',style: TextStyle(color: Colors.black
                    ,fontSize: 40,fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                    children: [
                    CustomTextField(
                      title: 'Task Title',
                      onSaved: (v)
                      {
                        title =v;
                      },
                      validator: (input)
                      {
                        if(input.toString().isEmpty)
                        {
                          return 'Please Enter Title';
                        }
                      },
                    ),
                      SizedBox(
                        height: 25,
                      ),
                      Builder(
                        builder: (context)=>
                            CustomTextField(
                              controller: dateController,
                              onSaved: (v)
                              {
                                dateController.text=v;
                              },

                              title: 'Task Date',
                              tab:
                              handleDatePicker,

                            ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      CustomTextField(
                        title: 'Importance Level',
                        onSaved: (v){
                          pi=v;
                        },
                        validator: (input)
                        {
                          if(input.toString().isEmpty)
                          {
                            return 'Please Enter Level';
                          }
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      CustomTextField(
                        onSaved: (va){
                          description=va;
                        },
                        title: 'Task Description',
                        lines: 4,
                      ),


                    ],
                  )),
                ),
                GestureDetector(
                  onTap: ()async
                  {
                    _formKey.currentState.save();
await db.insertTask(Task(title: title,piority: pi,
date: dateController.text,description: description,status: '0'));
                  },
                  child: Container(
                    height: 70,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[500],
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Center(
                      child: Text
                        (
                        'Add Task',
                        style: TextStyle(color: Colors.white
                        ,fontSize: 20,
                        fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
