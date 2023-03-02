import 'dart:io';


import 'package:dbassignment/Models/get_profile_pic.dart';
import 'package:dbassignment/Models/student_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  File? _image;
  final prof = ProfilePic();


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


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          height: 570,
          width: 1300,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(120.0),
              topLeft: Radius.circular(120.0),
            ),
            color: Colors.blueGrey,
          ),
          padding: EdgeInsets.all(30.00),
          child: SingleChildScrollView(
            child:Column(
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

            ) ,
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

