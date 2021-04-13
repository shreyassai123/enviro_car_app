import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart';
import 'dart:io';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  String _error;
  String _username;
  String _email;
  String _token;
  var response;
  Future<void> postUser(String username, String password, String email) async {
    var url = Uri.parse("https://envirocar.org/api/stable/users");
    response = await http.post(url, body: json.encode({
      "acceptedPrivacy": true,
      "acceptedTerms": true,
      "name": _username,
      "mail": _email,
      "token": _token,
    }),
      headers: {
        'Content-type' : 'application/json',
      }
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Text("EnviroCar App", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              _error!=null ? SizedBox(
                width: double.infinity,
                child: Container(
                    padding: EdgeInsets.all(10),

                    color: Colors.amber,
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber_sharp),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(_error, style: TextStyle(fontSize: 17),),
                        ),
                        Spacer(),
                        TextButton(onPressed: (){
                          setState(() {
                            _error=null;
                          });
                        },
                            child: Text("X", style: TextStyle(color: Colors.black),))
                      ],
                    )
                ),
              ) : Container(),
              Text('Register', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          shape: BoxShape.rectangle,
                          border: new Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (username){
                              _username = username;
                            },
                            decoration: InputDecoration(
                              hintText: "Username",
                              border: InputBorder.none,
                            ),
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          shape: BoxShape.rectangle,
                          border: new Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (email){
                              _email = email;
                            },
                            decoration: InputDecoration(

                              hintText: "Email",
                              border: InputBorder.none,
                            ),
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          shape: BoxShape.rectangle,
                          border: new Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            obscureText: true,
                            onChanged: (password){
                              _token = password;
                            },
                            decoration: InputDecoration(

                              hintText: "Password",
                              border: InputBorder.none,
                            ),
                          ),
                        )
                    ),
                  ),
                  Container(
                      color: Colors.blue,
                      child: TextButton(
                          onPressed: () async{
                        await postUser(_username, _token, _email);

                        setState(() {
                          _error = null;
                          if(response.statusCode==201){
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginPage();
                                },
                              ),
                            );
                          }
                          else{
                            setState(() {
                              _error = json.decode(response.body)['message'];
                            });
                          }

                        });
                      },
                          child: Text("REGISTER", style: TextStyle(color: Colors.black),)
                      )
                  ),
                  TextButton(

                      onPressed: (){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  }, child: Text('Login'))
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
