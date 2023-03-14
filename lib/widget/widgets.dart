import 'package:flutter/material.dart';
import 'package:wemeet_dapps/shared/constants.dart';

// to go back to current page by click specific button
void nextScreenPop(context) {
 Navigator.pop(context);    
}

//to remove the current page and go to other page
void nextScreenRemoveUntil(context, page) {
  Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => page), (route) => false);
}

//to replace the place and go to front page after the current page
void nextScreenReplacement(context, page) {
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
}

//to push the page 
void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

//for input textbox in login
final textInputDecoration = InputDecoration(
    labelStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
       fontSize: 20,
    ),
    filled: true,
    fillColor: Colors.white,

    enabledBorder: OutlineInputBorder (
        borderSide: BorderSide(color: Constants().secondaryColor, width: 3,),
    ),
    errorBorder: OutlineInputBorder (
       borderSide: BorderSide(color: Constants().secondaryColor, width: 3),
    ), 

     focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 3)
    ),
);

//for input textbox in profile
final textInputDecorationMain = InputDecoration(
    labelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
         fontSize: 20,
    ),

    filled: true,

    enabledBorder: OutlineInputBorder (
     
        borderSide: BorderSide(color: Color(0xffC0C0C0), width: 2,),
    ),
     errorBorder: OutlineInputBorder (
       borderSide: BorderSide(color: Constants().secondaryColor, width: 1),
    ), 

    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffC0C0C0), width: 3)
    ),
);

//for input textbox for search bar
final inputTextDecorationSearch = InputDecoration(
    labelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
         fontSize: 20,
    ),
    filled: true,
    
    enabledBorder: OutlineInputBorder (
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xffC0C0C0), width: 2,),
    ),
      focusedBorder: OutlineInputBorder(
      borderRadius:BorderRadius.circular(10),
      borderSide: BorderSide(color: Color(0xffC0C0C0), width: 2)
    ),
);

//for input textbox for number of student
final textInputDecorationNumberStudent = InputDecoration(
    labelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 20,
    ),

    filled: true,

    enabledBorder: OutlineInputBorder (
 borderSide: BorderSide(color: Color(0xffC0C0C0), width: 3,),
    ),
     errorBorder: OutlineInputBorder (
       borderSide: BorderSide(color: Constants().secondaryColor, width: 1),
    ), 

    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffC0C0C0), width: 3)
    ),
);
