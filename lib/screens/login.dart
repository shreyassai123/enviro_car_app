import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'home.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  String _error;
  String _username;
  String _token;
  var _userInfo;
  var response;
  Future<void> getResp(String username, String password) async{
    var url= Uri.parse("https://envirocar.org/api/stable/users");
    var temp = base64Encode('$username:$password'.codeUnits);
    response = await http.get(url, headers: {"Authorization": "Basic "+temp});

  }

  Future<void> getUser(String username, String password) async{
    var url= Uri.parse("https://envirocar.org/api/stable/users/$username");
    var temp = base64Encode('$username:$password'.codeUnits);
    _userInfo = await http.get(url, headers: {"Authorization": "Basic "+temp});
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
              Text('Login', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                      child: TextButton(onPressed: () async{
                        await getResp(_username, _token);
                        await getUser(_username, _token);
                        setState(() {
                          _error = null;
                          if(response.statusCode==200){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomePage(userInfo: json.decode(_userInfo.body));
                                },
                              ),
                            );
                          }
                          else if(response.statusCode==403){
                            setState(() {
                              _error = json.decode(response.body)['message'];
                            });
                          }
                        });
                      },
                          child: Text("LOGIN", style: TextStyle(color: Colors.black),)
                      )
                  ),
                  TextButton(onPressed: (){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return RegisterPage();
                        },
                      ),
                    );
                  }, child: Text('Register'))
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
