import 'package:exactus/screens/viewUsers.dart';
import 'package:exactus/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../connect.dart';
class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var addKey =  GlobalKey<FormState>();
  TextEditingController namecontroller=TextEditingController();
  TextEditingController addresscontroller=TextEditingController();
  TextEditingController countrycontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();

  Future<void> add()  async {
    var data={
      "name":namecontroller.text,
      "email":emailcontroller.text,
      "address":addresscontroller.text,
      "country":countrycontroller.text,
      "phonenumber":phonecontroller.text,

    };
    var response=await post(Uri.parse('${con}add.php'),body: data);
    print(response.body);
    print(response.statusCode);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height:MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.white,Colors.amber],begin:Alignment.topCenter,end: Alignment.bottomRight),
          ),
          child: Form(
            key: addKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image:AssetImage('assets/student1.png'),height:250,),
                    SizedBox(height: 50,),
                    Center(child: Text("Add Student",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
                    SizedBox(height: 55,),
                    TextFormField(
                      controller: namecontroller,
                        keyboardType: TextInputType.text,
                        decoration:const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          label:Text("Name"),
                        ),

                        validator: (value){
                          return Validate.nameValidator(value!);
                        }

                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                        controller: addresscontroller,

                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          label:Text("Address"),
                        ),

                        validator: (value){
                          return Validate.addressValidator(value!);
                        }

                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                        controller: countrycontroller,

                        keyboardType: TextInputType.text,
                        decoration:const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          label:Text("Country"),
                        ),

                        validator: (value){
                          return Validate.countryValidator(value!);
                        }

                    ),
                    SizedBox(height: 10,),

                    TextFormField(
                      controller: phonecontroller,
                        keyboardType: TextInputType.phone,
                        decoration:const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          label:Text("Phone Number"),
                        ),

                        validator: (value){
                          return Validate.phoneValidator(value!);
                        }

                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration:const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          label:Text("Email"),
                        ),


                        validator: (value){
                          return Validate.emailValidator(value!);
                        }

                    ),
                    SizedBox(height: 10,),
                    const SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            onPressed: (){
                          if (addKey.currentState!.validate()) {
                            setState(() {
                              add();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewUsers()));
                            });


                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Adding failed')),
                            );
                          }
                        }, child: Text('Add')),
                        const SizedBox(width: 20,),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                            onPressed: (){
                          Navigator.pop(context);
                        }, child: Text('Cancel'))

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}

