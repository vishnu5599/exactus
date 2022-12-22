import 'package:flutter/material.dart';
class Validate {
  static String? nameValidator(String value){
    if(value.toString()==""){
      return 'Invalid name';
    }else{
      return null;
    }
  }
  static String? addressValidator(String value){
    if(value.toString()=="" || value.length < 3){
      return 'Invalid address';
    }else{
      return null;
    }
  }
  static String? phoneValidator(String value){

      if(value.toString()==""||value.length < 10){
      return 'Invalid phone-number';
    }else{
      return null;
    }
  }
  static String? emailValidator(String value){
  var pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);

  if(value.toString()=="" || !(regex.hasMatch(value))){
      return 'Invalid email';
    }else{
      return null;
    }
  }
  static String? countryValidator(String value){
    if(value.toString()==""){
      return 'Invalid country';
    }else{
      return null;
    }
  }
  static String? passwordValidator(String value){
    if (value.length < 6) {
      return 'Must be more than 6 charater';
    }
    if(value.toString()==""){
      return 'Invalid password';
    }else{
      return null;
    }
  }
}