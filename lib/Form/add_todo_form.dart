

// ignore_for_file: non_constant_identifier_names

import 'package:dbassignment/Database/db_handler.dart';
import 'package:dbassignment/my_home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/models.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({Key? key}) : super(key: key);

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {

  var FormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DBHelper? dbHelper;
  late Future<List<TodoModel>> datalist;
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async{
    datalist = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
              )
          ),
        ),
      ),
      body: Form(
        key: FormKey,
          child: ListView(
            padding: const EdgeInsets.all(30.00),
            children: [
              TextFormField(


                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "E.g Clean house chores",
                  hintText: "Todo Title",
                ),


                validator: (value){
                  return value == null || value.isEmpty ? "Enter Title" : null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: descController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "E.g Clean house chores at 8:00 P.M",
                    hintText: "Todo Description"
                ),
                validator: (value){
                  return value == null || value.isEmpty ? "Enter Description" : null;
                },
              ),
              const SizedBox(height: 320),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple
                ),
                  onPressed:(){
                    if(FormKey.currentState!.validate()){
                      dbHelper!.insert(TodoModel(
                        title: titleController.text,
                        desc: descController.text,
                        dateAndTime: DateFormat('yMd')
                            .add_jm()
                            .format(DateTime.now()).toString()
                      ));

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHome()
                          )
                      );
                      print(titleController.text);
                      titleController.clear();
                      descController.clear();
                      print("DATA INSERTED");
                    }

                  },
                  child: const Text("Submit")
              )
            ],
          )
      ),

    );
  }
}
