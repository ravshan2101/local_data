import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:local_data/model/user.dart';
import 'package:local_data/servic/hive_servic.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('pdp_online');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  void dologin() {
    String useername = usernamecontroller.text.toString().trim();
    String password = passwordcontroller.text.toString().trim();

    var user = User(username: useername, password: password);

    HiveDB().storeUser(user);

    var user2 = HiveDB().loadUser();
    print(user2.username);
    print(user2.password);

    // box.put("useername", useername);
    // box.put("password", password);

    // String id = box.get("useername");
    // String pw = box.get('password');
    // print(id);
    // print(pw);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernamecontroller,
                decoration: InputDecoration(hintText: "Username"),
              ),
              TextField(
                controller: passwordcontroller,
                decoration: InputDecoration(hintText: "Password"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    dologin();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 17),
                  ))
            ],
          )),
    );
  }
}
