// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Database/db_handler.dart';
import '../Models/models.dart';
import '../my_home.dart';

class EditTodoForm extends StatefulWidget {
  int? todoId;
  String? todoTitle;
  String? todoDesc;
  String? dateAndTime;
  bool? update;

  EditTodoForm({
    super.key,
    this.todoId,
    this.todoTitle,
    this.todoDesc,
    this.dateAndTime,
    this.update
  });


  @override
  State<EditTodoForm> createState() => _EditTodoFormState();
}

class _EditTodoFormState extends State<EditTodoForm> {

  var FormKey = GlobalKey<FormState>();
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
    final  titleController = TextEditingController(text: widget.todoTitle);
    final  descController = TextEditingController(text: widget.todoDesc);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit"),
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
                     if (widget.update == true){
                       dbHelper!.update(TodoModel(
                           id: widget.todoId,
                           title: titleController.text,
                           desc: descController.text,
                           dateAndTime: DateFormat('yMd')
                               .add_jm()
                               .format(DateTime.now()).toString()
                       ));
                     }else{
                       dbHelper!.insert(TodoModel(
                           title: titleController.text,
                           desc: descController.text,
                           dateAndTime: DateFormat('yMd')
                               .add_jm()
                               .format(DateTime.now()).toString()
                       ));
                     }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHome()
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
