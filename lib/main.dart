import 'package:flutter/material.dart';
import 'package:soril1/logged.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Handle login logic here
      String username = _usernameController.text;
      String password = _passwordController.text;
      print('Username: $username, Password: $password');
      // Add your login logic here
    }
  }

  void _navigateToRegister() {
    // Placeholder for registration navigation
    print('Navigating to register page');
    // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('КОВИД-19'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Ebarimt',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Хэрэглэгчийн нэвтрэх код',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Нэрээ оруулна уу';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Нууц үг',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'нууц үг оруулна уу';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        "Нэвтрэх",
                        style: TextStyle(fontSize: 21),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.cyan),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size.fromHeight(50),
                        ),
                      ),
                      onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => DashboardScreen()));
                        },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextButton(
                      onPressed: _navigateToRegister,
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(fontSize: 21),
                        ),
                        overlayColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.transparent;
                            }
                            return null;
                          },
                        ),
                      ),
                      child: Text("Бүртгүүлэх"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
