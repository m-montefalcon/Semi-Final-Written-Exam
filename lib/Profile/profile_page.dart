import 'dart:io';


import 'package:dbassignment/Models/get_profile_pic.dart';
import 'package:dbassignment/Models/student_models.dart';
import 'package:dbassignment/Profile/educ_profile.dart';
import 'package:dbassignment/my_home.dart';
import 'package:dbassignment/pages/header_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../Auth/auth.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  File? _image;
  final prof = ProfilePic();

  final User? user = Auth().currentUser!;

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
    print(Auth().currentUser?.email);
    Auth().signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  late List<Map<String, dynamic>> _lastRow;


  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(source: source);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        return;
      }
      _image = File(pickedImage.path);
    });
  }

  double _drawerIconSize = 24;
  double _drawerFontSize = 17;



    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Profile Page",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Theme
                        .of(context)
                        .primaryColor, Theme
                        .of(context)
                        .accentColor,
                    ]
                )
            ),
          ),

        ),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Theme
                          .of(context)
                          .primaryColor
                          .withOpacity(0.2),
                      Theme
                          .of(context)
                          .accentColor
                          .withOpacity(0.5),
                    ]
                )
            ),
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [ Theme
                          .of(context)
                          .primaryColor, Theme
                          .of(context)
                          .accentColor,
                      ],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text("Dumduma",
                      style: TextStyle(fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home_filled, size: _drawerIconSize, color: Theme
                      .of(context)
                      .accentColor,),
                  title: Text(
                    'Home Page', style: TextStyle(fontSize: 17, color: Theme
                      .of(context)
                      .accentColor),),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const MyHome()));
                  },
                ),
                ListTile(
                  leading: Icon(
                      Icons.account_circle_rounded, size: _drawerIconSize,
                      color: Theme
                          .of(context)
                          .accentColor),
                  title: Text('Profile Page',
                    style: TextStyle(fontSize: _drawerFontSize, color: Theme
                        .of(context)
                        .accentColor),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
                  },
                ),
                Divider(color: Theme
                    .of(context)
                    .primaryColor, height: 1,),
                ListTile(
                  leading: Icon(
                      Icons.school, size: _drawerIconSize, color: Theme
                      .of(context)
                      .accentColor),
                  title: Text('Student Educational Information',
                    style: TextStyle(fontSize: _drawerFontSize, color: Theme
                        .of(context)
                        .accentColor),),
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EducProfile()),);
                  },
                ),
                Divider(color: Theme
                    .of(context)
                    .primaryColor, height: 1,),
                ListTile(
                  leading: Icon(
                    Icons.logout_rounded, size: _drawerIconSize, color: Theme
                      .of(context)
                      .accentColor,),
                  title: Text('Logout',
                    style: TextStyle(fontSize: _drawerFontSize, color: Theme
                        .of(context)
                        .accentColor),),
                  onTap: () {
                    signOut();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: _image != null ? FileImage(
                          _image!) as ImageProvider : prof.primaryImage,
                    ),
                    SizedBox(height: 20,),
                    Text('Meinardz C. Montefalcon', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text('General Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                            alignment: Alignment.topLeft,
                            child: Center(
                              child: Text(
                                "User Information",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      ...ListTile.divideTiles(
                                        color: Colors.grey,
                                        tiles: [
                                          ListTile(
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 4),
                                            leading: Icon(Icons.my_location),
                                            title: Text("Location"),
                                            subtitle: Text("Cagayan de Oro"),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.email),
                                            title: Text("Email"),
                                            subtitle: Text("mmontefalconschlprps@gmail.com"),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.phone),
                                            title: Text("Phone"),
                                            subtitle: Text("09916010389"),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.person),
                                            title: Text("Contact me at"),
                                            subtitle: Text(
                                                "www.facebook.com/meinardz.montefalcon"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),


      );
    }
  }
/*Column(
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: _image != null ? FileImage(
                          _image!) as ImageProvider : prof.primaryImage,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Text("Student General Information",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ListTile(
                      title: Text("Name"),
                      trailing: Text("Meinardz C. Montefalcon"),
                    ),
                    const ListTile(
                      title: Text("Section"),
                      trailing: Text("IT3R2"),
                    ),
                    const ListTile(
                      title: Text("Age"),
                      trailing: Text("21"),
                    ),
                    const ListTile(
                      title: Text("Address"),
                      trailing: Text("Bugo Cagayan de Oro City"),
                    ),
                    const ListTile(
                      title: Text("Contact Number"),
                      trailing: Text("09916010389"),
                    ),

                  ],

                )*/

