import 'dart:convert';

import 'package:exactus/authentication/register.dart';
import 'package:exactus/screens/viewUsers.dart';
import 'package:exactus/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../connect.dart'; 
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var signInKey =  GlobalKey<FormState>();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  Future<void> signin() async {
    var data={
      "email":emailcontroller.text,
      "password":passwordcontroller.text,
    };
    var response=await post(Uri.parse('${con}signin.php'),body: data);
    print(response.body);
    print(response.statusCode);
    if(response.statusCode==200){
      if(jsonDecode(response.body)['message']=='user successfully logged in'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signin Success')),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ViewUsers()));


    }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Signin Failed')));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));


      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height:MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.amber,Colors.white70],begin:Alignment.topCenter ),
          ),
          child: Form(
            key: signInKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image:AssetImage('assets/imgexactus.png'),height:250,),
                    SizedBox(height: 10,),
                    const Text('Welcome Back',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
                    const SizedBox(height: 10,),
                    const Text('Login to your account',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                    const SizedBox(height: 80,),

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
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: passwordcontroller,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          label:Text("Password"),
                        ),

                        validator: (value){
                          return Validate.passwordValidator(value!);
                        }

                    ),
                    SizedBox(height: 40,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: (){
                          print('Pressed login button');
                      if (signInKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        setState(() {
                          signin();
                        });
                      }

                    }, child: Text('Login')),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account ?"),
                        SizedBox(width: 5,),
                        InkWell(
                          onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                          },
                            child: Text("SignUp",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),))
                      ],
                    )
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

