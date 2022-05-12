import 'package:flutter/material.dart';
import 'package:foods/model/user_model.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class EditPage extends StatelessWidget {
  static const String id="EditPage";
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  void dispose() {
    myController1.dispose();
    myController2.dispose();

    dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            // decoration: Decoration(
            //     color: Colors.lightBlueAccent.withOpacity(0.2),
            //     borderRadius: BorderRadius.circular(8)),
            // bevel: 20,
            // curveType: CurveType.concave,
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Consumer<UserModel>(builder: (context, myModel, child){
                  return Column(
                  children: <Widget>[SizedBox(height: 20,),
                    Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                          onTap: () {
                            // myModel.imagepick();
                            // myModel.pic=true;
                          },
                          // child: Container(height:150,
                          //   width: 150,
                          //   child: Hero(
                          //       tag: 'pro',
                          //       child: myModel.pic!=true?CircleAvatar(
                                  // backgroundImage:myModel.pic?FileImage(myModel.imported): AssetImage(myModel.propic),

                        //           backgroundColor: Colors.black,
                        //         ):CircleAvatar(radius: 135,backgroundColor: Colors.black,backgroundImage: FileImage(File(myModel.imagepath)),)),
                        //   ),
                        )
                        ),
                    SizedBox(
                      height: 30,
                    ),

                    Container(
                      width: 300,
                      child: TextField(
                        controller: myController1,

                        decoration: new InputDecoration(hintText: myModel.name,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.greenAccent, width: 5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 5.0),
                          ),
                        ),
                      ),
                    ),
                   SizedBox(height: 30,),
                    Container(
                      width: 300,
                      child: TextField(
                        controller: myController2,
                        decoration: new InputDecoration(hintText: myModel.phone.toString(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.greenAccent, width: 5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 5.0),
                          ),

                        ),
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    Consumer<UserModel>(builder: (context, myModel, child) {
                      return FlatButton(
                        child: Text(
                          'Save Changes',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          myModel.update(myController1.text!=''? myController1.text : myModel.name!, myController2.text!='' ?myController2.text: myModel.phone!) ;
                          Navigator.pop(context);
                        },
                        color: Color.fromRGBO(79, 32, 149, 100),
                      );}
                    ),
                    FlatButton(
                      child: Text(
                        'BACK',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {

                        Navigator.pop(context);
                      },
                      color: Color.fromRGBO(79, 32, 149, 100),
                    ),
                  ],
                );}
              ),
            ),
          ),
        ));
  }
}
