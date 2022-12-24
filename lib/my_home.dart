import 'package:dbassignment/Database/db_handler.dart';
import 'package:dbassignment/Form/add_todo_form.dart';
import 'package:dbassignment/Form/edit_todo_form.dart';
import 'package:flutter/material.dart';
import 'Models/models.dart';
class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  DBHelper? dbHelper;
  late Future<List<TodoModel>> dataList;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async{
    dataList = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: const Text("Todo"),
        centerTitle: true,

      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                future: dataList,
                builder: (context, AsyncSnapshot<List<TodoModel>>snapshot){
                  if(!snapshot.hasData || snapshot.data == null){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if (snapshot.data!.isEmpty){
                    return const Center(
                      child: Text("No Data Found"),
                    );
                  }
                  else{
                    return ListView.builder(
                      padding: const EdgeInsets.all(5),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index){
                        int todoId = snapshot.data![index].id!.toInt();
                        String todoTitle = snapshot.data![index].title.toString();
                        String todoDesc = snapshot.data![index].desc.toString();
                        String todoDateAndTime = snapshot.data![index].dateAndTime.toString();
                        return Dismissible(
                            key: ValueKey<int>(todoId),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.redAccent,
                              child: const Icon(Icons.delete_forever, color : Colors.white),
                            ),
                          onDismissed: (DismissDirection direction){
                              print("DATA DELETED");
                              setState(() {
                                dbHelper!.delete(todoId);
                                dataList = dbHelper!.getDataList();
                                snapshot.data!.remove(snapshot.data![index]);
                              });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.blueGrey,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 1
                                )
                              ]
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.all(10),
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      todoTitle,
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                  ),

                                  subtitle: Text(
                                      todoDesc,
                                      style: const TextStyle(
                                          fontSize: 17
                                      ),
                                  ),
                                ),

                                 const Divider(
                                  color: Colors.black,
                                  thickness: 0.5,
                                ),

                                 Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 10
                                    ),

                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        todoDateAndTime,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.italic
                                        ),

                                      ),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => EditTodoForm(
                                                    todoId: todoId,
                                                    todoTitle: todoTitle,
                                                    todoDesc: todoDesc,
                                                    update: true,

                                                  )
                                              )
                                          );
                                        },
                                        child: const Icon(Icons.edit),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                        );




                      }

                    );
                  }
                }
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  const AddTodoForm()
                )
            );

          },
          child: const Icon(Icons.add)
      ),
    );
  }
}
