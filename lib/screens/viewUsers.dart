import 'dart:convert';

import 'package:exactus/authentication/login.dart';
import 'package:exactus/screens/addUser.dart';
import 'package:exactus/screens/editUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../connect.dart';

class ViewUsers extends StatefulWidget {
  const ViewUsers({Key? key}) : super(key: key);

  @override
  State<ViewUsers> createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {
  Future<void> view() async {
    var response = await get(Uri.parse('${con}view.php'));
    print(response.body);
    print(response.statusCode);
    return jsonDecode(response.body);
  }
var delid;
  Future<void> del() async {
    setState(() {
      
    });
    var data = {
      "id": delid
    };
    var response = await post(Uri.parse('${con}del.php'), body: data);
    print(response.body);
    print(response.statusCode);
  }
  signOut() async {
    await 
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white70,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddUser()));
        },
        child: Icon(Icons.add,color: Colors.black,size: 30,),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Students',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
        centerTitle: true,
        actions: [IconButton(onPressed: (){
          setState(() {
            signOut();
          });
        }, icon: Icon(Icons.logout))],
      ),
      body: Container(
        height:MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:[Colors.amber,Colors.white70],begin: Alignment.topCenter),
        ),
        child: FutureBuilder(
            future: view(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                              radius: 25,
                              child: Icon(
                                Icons.person,
                                size: 30,
                              )),
                          title: Text(snapshot.data![index]['name']),
                          subtitle: Text(snapshot.data![index]['email']),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditPage(
                                                    id: snapshot.data![index]
                                                        ['id'],
                                                    name: snapshot.data![index]
                                                        ['name'],
                                                    address:
                                                        snapshot.data![index]
                                                            ['address'],
                                                    email: snapshot.data![index]
                                                        ['email'],
                                                    country:
                                                        snapshot.data![index]
                                                            ['country'],
                                                    phonenumber: snapshot
                                                        .data![index]['number'],
                                                  )));
                                    },
                                    icon: Icon(Icons.edit)),
                                IconButton(onPressed: (){

                                  setState(() {
                                    delid=snapshot.data![index]['id'];
                                    del();
                                  });


                                }, icon: Icon(Icons.delete,
                                color: Colors.red,),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
