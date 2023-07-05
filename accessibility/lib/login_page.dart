import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          textScaleFactor: MediaQuery.textScaleFactorOf(context),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 300.0,
                child: Semantics(
                  textField: true,
                  label: 'Eingabefeld E-Mail-Adresse',
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bitte geben Sie eine gültige E-Mail-Adresse ein';
                      }
                      if (!RegExp(r'^[a-zA-Z\d.]+@[a-zA-Z\d]+\.[a-zA-Z]+')
                          .hasMatch(value)) {
                        return 'Bitte geben Sie eine gültige E-Mail-Adresse ein';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 300.0,
                child: Semantics(
                  textField: true,
                  label: 'Passwort-Eingabefeld',
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bitte geben Sie Ihr Passwort ein';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Semantics(
                label: 'Login-Schaltfläche',
                button: true,
                child: ElevatedButton(
                  onPressed: () {
                    _submit(context);
                  },
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: MediaQuery.textScaleFactorOf(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
      );
    }
  }
}
