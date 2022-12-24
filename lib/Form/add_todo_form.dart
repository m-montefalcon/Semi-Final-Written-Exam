

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
        centerTitle: true,
        title: const Text("FORM"),
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
                  labelText: "E.g Clean house chores",
                  hintText: "Todo Title"
                ),
                validator: (value){
                  return value == null || value.isEmpty ? "Enter Title" : null;
                },
              ),
              TextFormField(
                controller: descController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: const InputDecoration(
                    labelText: "E.g Clean house chores at 8:00 P.M",
                    hintText: "Todo Description"
                ),
                validator: (value){
                  return value == null || value.isEmpty ? "Enter Description" : null;
                },
              ),
              const SizedBox(height: 400),
              ElevatedButton(
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
