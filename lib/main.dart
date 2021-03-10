
import 'package:flutter/material.dart';
import 'package:sqlite/add_data.dart';

import 'Data/insta_data/dBHelper.dart';
import 'Data/insta_data/photo.dart';
import 'Data/insta_data/utility.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Photo> images;
  DBHelper dbHelper;

  @override
  void initState() {
    super.initState();

    dbHelper = DBHelper();
    refreshImages();
  }

  refreshImages()
  {
    setState(() {
      dbHelper.getPhotos().then((value) {
        setState(() {
          images=List();
          images.addAll(value);
        });
      });
    });
  }

  gridView() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 1,
        childAspectRatio:5,
        children: images.map((photo) {
          return Column(
            children: [
              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    photo.photo_name != 'null' ?
                    Container(
                        width: 75.0,
                        height: 75.0,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Utility.imageFromBase64String(photo.photo_name),
                          ),
                        )
                    ): Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 75,
                      height: 75,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'assets/user_no_img.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(photo.user_name,style: TextStyle(fontSize: 18.0),),
                  ],
                ),
              )
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sq_lite'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Add_data(),)).then((value) => refreshImages());
            },
            icon: Icon(Icons.add)
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: images != null ? gridView() : Container(),
          ),
        ],
      ),
    );
  }
}


