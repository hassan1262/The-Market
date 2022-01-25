import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_market_application/providers/product_provider.dart';
import 'package:super_market_application/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


bool islogin = true;
var email, password;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}


class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String phone = '';
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // setPref(String uid, dynamic email) async {
  //   try {
  //     // print('1 $uid');
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('uid', uid.toString());
  //     await prefs.setString('email', email.toString());
  //     // print('2 ${uid.toString()}');
  //   } catch (e) {
  //     print('err ${e.toString()}');
  //   }
  // }

  Future signinWithGoogle() async {
    await _googleSignIn.signOut();
    // hold entered data
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    // return auth token
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken:
            googleSignInAuthentication.accessToken); // access google services

    UserCredential? userCredential =
        await _auth.signInWithCredential(authCredential);

  
  }

  SignIn() async {
    var formdata = _formkey.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
              context: context, title: "error", body: Text("wrong email"))
            ..show();
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
              context: context, title: "error", body: Text("Wrong password"))
            ..show();
        }
      }
    } else {
      print("not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Container(
                width: 200.0,
                height: 280.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/logo.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Text(
                'Login to your account',
                style: TextStyle(
                  color: green,
                  fontSize: fontSizeH,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (val) {
                        email = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "email is too long";
                        }
                        if (val.length < 6) {
                          return "email is too short";
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: green,
                        ),
                        prefixIcon: Icon(
                          Icons.person_outlined,
                          color: green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        password = val;
                      },
                      validator: (val) {
                        if (val!.length > 12) {
                          return "password is too long";
                        }
                        if (val.length < 4) {
                          return "password is can't be less than 4 ";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: green,
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outlined,
                          color: green,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () async {
                            await Provider.of<ProductProviders>(context,
                                    listen: false)
                                .load();
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/add_product', (route) => false);
                          },
                          child: Text(
                            'Forget Password ?',
                            style: TextStyle(
                              fontSize: fontSizeS,
                              color: black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var check = await SignIn();
                        if (check != null) {
                          Navigator.of(context).pushReplacementNamed("/Home");
                        }
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: fontSizeM,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: green,
                        padding: EdgeInsets.symmetric(
                            horizontal: 35.0, vertical: 15.0),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      'or sign in with',
                      style: TextStyle(
                        fontSize: fontSizeM,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await signinWithGoogle();
                        Navigator.pushNamed(context, '/add_product');
                      } catch (e) {
                        print('Error');
                        return null;
                      }
                        },
                    child: Image.asset(
                      'assets/google.png',
                      height: 70,
                    ),
                    style: btnStyle,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset(
                      'assets/facebook.png',
                      height: 70,
                    ),
                    style: btnStyle,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset(
                      'assets/twitter.png',
                      height: 70,
                    ),
                    style: btnStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  'Don\'t have an account ? Sign up',
                  style: TextStyle(
                    fontSize: fontSizeS,
                    color: black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
