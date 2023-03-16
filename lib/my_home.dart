import 'dart:io';

import 'package:dbassignment/Auth/auth.dart';
import 'package:dbassignment/Database/db_handler.dart';
import 'package:dbassignment/Form/add_todo_form.dart';
import 'package:dbassignment/Form/edit_todo_form.dart';
import 'package:dbassignment/Profile/educ_profile.dart';
import 'package:dbassignment/Profile/home_profile.dart';
import 'package:dbassignment/Profile/profile_page.dart';
import 'package:dbassignment/pages/login_page.dart';
import 'package:dbassignment/pages/registration_page.dart';
import 'package:dbassignment/pages/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'Models/models.dart';
class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  File? image;
  final User? user = Auth().currentUser!;
  Future<void> signOut()async{
    FirebaseAuth.instance.signOut();
    print(Auth().currentUser?.email);
    await Auth().signOut();
    Navigator.pop(context);
  }
  Future pickImage() async{
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTempHolder = File(image.path);

      setState(() {
        this.image = imageTempHolder;
        Navigator.pop(context, this.image);
      });
    } on PlatformException catch (e) {
      print("Failed");
      // TODO
    }
  }
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
  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey,

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
      drawer: Drawer(
        child: Container(
          decoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).accentColor.withOpacity(0.5),
                  ]
              )
          ) ,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text("Dumduma",
                    style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home_filled, size: _drawerIconSize, color: Theme.of(context).accentColor,),
                title: Text('Home Page', style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHome()));
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Profile Page', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.school, size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Student Educational Information',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EducProfile()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  signOut();
                  Navigator.of(context).popUntil((route) => route.isFirst);

                },
              ),
            ],
          ),
        ),
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
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple,
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

      floatingActionButton: FloatingActionButton.extended(

        onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  const AddTodoForm()
                )
            );
          },
          icon: const Icon(Icons.edit),
          label: const Text("Add Reminder")
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //     onPressed: (){
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) =>  const AddTodoForm()
      //           )
      //       );
      //
      //     },
      //     child: const Icon(Icons.add)
      // ),
    );
  }
}
