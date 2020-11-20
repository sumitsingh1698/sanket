import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanket/api/sanketapi.dart';

class HomepageView extends StatefulWidget {
  @override
  _HomepageViewState createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  File _image;
  String result = "";

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showResult(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    title: new Text('About Photo : '),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        result == "nothing" ? "No result found" : '$result',
                        style: TextStyle(
                            color: result == "nothing"
                                ? Colors.red
                                : Theme.of(context).primaryColor,
                            fontSize: result == "nothing" ? 20 : 50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Sanket",
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      body: Container(
          child: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "S",
                                style: TextStyle(
                                  fontSize: 70,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Text(
                                "anket",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 55,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          )),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Sanket a sign language app.\n\nIt is suitable for beginner and parents of deaf children.\n\nIt has sign language Alphabets, number and common conversation sentences as well as it translates sign language through hand gesture/image to text.",
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 17.5),
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (_image == null) {
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      title: Text("No Image Selected",
                                          style: TextStyle(
                                            color: Colors.red,
                                          )),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(
                                                "Please Select Image !!!\n\n -> Click on The Camara Icon\n -> Select Photo or Click Photo\n -> Check Photo \n\n Enjoy our services "),
                                          ],
                                        ),
                                      ),
                                    ));
                              } else {
                                List listString = List<String>();

                                listString = _image.path.split("/");
                                print(listString[listString.length - 1]);
                                SanketApi()
                                    .getImageDetail(_image.path,
                                        listString[listString.length - 1])
                                    .then((resultValue) {
                                  Navigator.pop(context);
                                  result = resultValue;

                                  _showResult(context);
                                });
                                showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    content: Container(
                                      width: 50.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "Check Photo",
                              style: TextStyle(color: Colors.orange),
                            ),
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // Text(_image != null ? "${_image.path}" : ''),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xffFDCF09),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                _image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
