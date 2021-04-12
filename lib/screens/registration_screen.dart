import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';



class RegistrationScreen extends StatefulWidget {


  static const String id = "RegistrationScreen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  String massage = " Registration by your email and password" ;
  UserCredential user;
  String email ;
  String password;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

    backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: "logo",
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
               email=value;
              },
              decoration: ktextFieldDecoration.copyWith(hintText:"enter your Email" ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password=value;
              },
              decoration: ktextFieldDecoration.copyWith(hintText:"enter your password" ) ,
            ),
            SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),

                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    try {
                      user =await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                      if(user != null)
                      { Navigator.pushNamed(context,ChatScreen.id);}

                    } on FirebaseAuthException catch (e) {
                    if(user == null){
                    massage ="please enter Email and Password";
                    setState(() {});
                    }else if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                        massage ='The password provided is too weak.';
                        setState(() {
                        });
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                        massage='The account already exists for that email.';
                        setState(() {
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$massage",style: TextStyle(color: massage ==" Registration by your email and password"?Colors.blue:Colors.red ,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
