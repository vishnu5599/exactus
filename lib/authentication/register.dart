import 'package:exactus/authentication/login.dart';
import 'package:exactus/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../connect.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var signUpKey =  GlobalKey<FormState>();
  TextEditingController namecontroller=TextEditingController();
  TextEditingController addresscontroller=TextEditingController();
  TextEditingController countrycontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  Future<void> signup()  async {
    var data={
      "name":namecontroller.text,
      "address":addresscontroller.text,
      "country":countrycontroller.text,
      "phonenumber":phonecontroller.text,
      "email":emailcontroller.text,
      "password":passwordcontroller.text,
    };
    var response=await post(Uri.parse('${con}signup.php'),body: data);
    print(response.body);
    print(response.statusCode);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height:MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.amber,Colors.white70],begin:Alignment.topCenter ),
            ),
            child: Form(
              key: signUpKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 15,),
                      Image(image:AssetImage('assets/register2.png'),height:200,),
                      SizedBox(height: 10,),
                      const Text('Register',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
                      const SizedBox(height: 10,),
                      const Text('Create an Account',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                      const SizedBox(height: 35,),
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
                      SizedBox(height: 10,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          onPressed: (){
                        if (signUpKey.currentState!.validate()) {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          signup();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      }, child: Text('SignUp')),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account ?"),
                          SizedBox(width: 5,),
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                              },
                              child: Text("SignIn",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}

