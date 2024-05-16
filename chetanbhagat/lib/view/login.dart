import 'package:chetan_bhagat/view/auth.dart';
import 'package:chetan_bhagat/view/flashscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userName = TextEditingController();

  bool isSignUp = false;

  void _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = _emailController.text;
    String password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      await prefs.setString('username', username);
      await prefs.setString('password', password);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter valid credentials'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void signUp() async {
    await AuthService().registration(
        email: _emailController.text, password: _passwordController.text);
    setState(() {});
  }

  void login() async {
    await AuthService().login(
        email: _emailController.text, password: _passwordController.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: Colors.lightBlueAccent,
        child: GestureDetector(
            onTap: () {
              isSignUp = !isSignUp;
              _emailController.clear();
              _passwordController.clear();
              _userName.clear();
              setState(() {});
            },
            child: isSignUp
                ? const Text(
                    "Already an user ? ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                : const Text("Create User",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF021C4F),
        centerTitle: true,
        elevation: 2,
        title: Text(
          isSignUp ? 'Sing Up' : 'LogIn ',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/about icon.png"),
              ),
              const SizedBox(
                height: 90,
              ),
              isSignUp
                  ? TextField(
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                      controller: _userName,
                      decoration: const InputDecoration(
                          labelText: 'User Name',
                          labelStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          suffixIcon: Icon(Icons.person)),
                    )
                  : const Offstage(),
              TextField(
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    suffixIcon: Icon(Icons.mail)),
              ),
              TextField(
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.password))),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: !isSignUp
                    ? () async {
                        final message = await AuthService().login(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        if (message!.contains('Success')) {
                          _login();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const FlashScreen()));
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                          ),
                        );
                      }
                    : () async {
                        final message = await AuthService().registration(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        if (message!.contains('Success')) {
                          _login();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const FlashScreen()));
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                          ),
                        );
                      },
                child: Text(
                  isSignUp ? 'Sign Up' : 'Login',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
