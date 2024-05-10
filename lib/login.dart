import 'package:bike_in/Admin%20page/fetch.dart';
import 'package:bike_in/signup.dart';
import 'package:bike_in/splash2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn(BuildContext context) async {
    try {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter your email')),
        );
        return;
      }
      if (password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter your password')),
        );
        return;
      }
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null && userCredential.user!.email == "admin@gmail.com") {
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const adminn()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign-in Successful')),
        );
      } else {
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Spa()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign-in Successful as User')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 150),
                child: Icon(
                  Icons.directions_bike_outlined,
                  color: Colors.black,
                  size: 150,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 400,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(30),
                    hintText: 'E-mail',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                width: 400,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(30),
                    hintText: ' password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              TextButton(
                onPressed: () => _signIn(context),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(LinearBorder.none)
                ),
                child: const SizedBox(
                  height: 60,
                  width: 350,
                  child: Center(
                    child: Text(
                      "L O G I N",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const Signup()
                  ));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                ),
                child: const Text(
                  "SIGN UP ?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9.0),
                      child: Text(
                        "OR",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 120),
                    child: Image(
                      image: AssetImage("asset/image/insta.jpeg"),
                      height: 70,
                      width: 70,
                    ),
                  ),
                  SizedBox(width: 5),
                  Image(
                    image: AssetImage("asset/image/fb2.png"),
                    height: 70,
                    width: 70,
                  ),
                  SizedBox(width: 5),
                  Image(
                    image: AssetImage("asset/image/ggl.png"),
                    height: 40,
                    width: 70,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              const Text("I agree with the"),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "terms and condition and privacy policy",
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
