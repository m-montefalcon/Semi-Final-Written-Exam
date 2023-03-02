import 'package:flutter/material.dart';

class EducProfile extends StatefulWidget {
  const EducProfile({Key? key}) : super(key: key);

  @override
  State<EducProfile> createState() => _EducProfileState();
}

class _EducProfileState extends State<EducProfile> {
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
              const SizedBox(
                height: 10,
              ),
              Center(
                child: IconButton(
                    iconSize: 120,
                    onPressed: (){},
                    icon: Icon(Icons.school, color: Colors.white)
                ),
              ),
              const Center(
                child: Text("Educational Background",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Center(
                child: Text("Primary",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text("Suntingon Elementary School")
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text("Secondary",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text("Bugo National High School")
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text("Senior High School",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text("PHINMA Cagayan de Oro College")
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text("Tertiary",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text("         University of Science and \n Technology of Southern Philippines")
              ),


            ],

          ) ,
        ),
      ),
    );
  }
}
