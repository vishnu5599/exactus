import 'dart:convert';

import 'package:exactus/screens/viewUsers.dart';
import 'package:exactus/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../connect.dart';

class EditPage extends StatefulWidget {
  var id;
  var name;
  var address;
  var email;
  var country;
  var phonenumber;
  EditPage({Key? key,
    this.id,
    this.name,
    this.address,
    this.email,
    this.country,
    this.phonenumber,}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var editKey =  GlobalKey<FormState>();
  TextEditingController namecontroller=TextEditingController();
  TextEditingController addresscontroller=TextEditingController();
  TextEditingController countrycontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  Future<void> edit() async {
    var data = {
      "std_id": widget.id,
      "name": namecontroller.text,
      "email": emailcontroller.text,
      "address": addresscontroller.text,
      "country": countrycontroller.text,
      "phonenumber": phonecontroller.text,
    };
    var response = await post(Uri.parse('${con}edit.php'), body: data);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
    }
  }

  @override
  void initState() {

      namecontroller.text = widget.name;
      addresscontroller.text = widget.address;
      countrycontroller.text = widget.country;
      emailcontroller.text = widget.email;
      phonecontroller.text = widget.phonenumber;

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height:MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.amber,Colors.white70],begin: Alignment.topCenter),
          ),
          child: Form(
            key: editKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text("Edit Details",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),
                    SizedBox(height: 25,),
                    TextFormField(
                        controller: namecontroller,
                        keyboardType: TextInputType.text,
                        decoration:const InputDecoration(
                          prefixIcon: Icon(Icons.person),
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
                          prefixIcon: Icon(Icons.house),
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
                          prefixIcon: Icon(Icons.location_pin),
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
                          prefixIcon: Icon(Icons.phone),
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
                          prefixIcon: Icon(Icons.email),
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

                    ElevatedButton(onPressed: (){
                      if (editKey.currentState!.validate()) {
                        setState(() {
                          edit();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewUsers()));
                        });


                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('edit failed')));

                      }
                    }, child: Text('Update')),
                    SizedBox(height: 10,),

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
