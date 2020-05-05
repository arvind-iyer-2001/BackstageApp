import 'package:backstage/Providers&Services/auth.dart';
import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading 
      ? Center(
        child: Container(
          height: 200,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text("   Loading...")
            ],
          ),
        ),
      )
      : Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: AuthCard(),
          ),
        ),
      );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin{

  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),

    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0,-1.5),
      end: Offset(0,0)
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInToLinear
      )
    );
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear
      )
    );
    _slideAnimation.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      await AuthService().signInWithEmailAndPassword(_authData['email'],_authData['password']);
    } else {
      await AuthService().registerWithEmailAndPassword(_authData['email'],_authData['password']);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
        height: _authMode == AuthMode.Signup 
        ? 360 
        : 300,
        // height: _heightAnimation.value.height,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.Signup 
          ? 360 
          : 300
        ),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _authMode == AuthMode.Signup
                ? Text(
                  'Sign Up', 
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).primaryColor
                  ),
                )
                : Text(
                  'Sign In', 
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).primaryColor
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return value.isEmpty || !value.contains('@') 
                    ? 'Invalid email!'
                    : null ;
                    
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    return value.isEmpty || value.length < 5
                    ? 'Password is too short!'
                    : null ;
                    
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup 
                    ? 60 
                    : 0,
                    maxHeight: _authMode == AuthMode.Signup 
                      ? 120 
                      :   0
                    ),
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: TextFormField(
                          enabled: _authMode == AuthMode.Signup,
                          decoration: InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: _authMode == AuthMode.Signup
                              ? (value) {
                                  return value != _passwordController.text
                                  ? 'Passwords do not match!'
                                  : null ;
                                }
                              : null,
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

