import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var nameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<String> getData(String mykey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(mykey) ?? "nothing got";
  }

  Future<bool?> put(String myKey, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(myKey, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Pref'),
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    label: const Text('Name'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ), // TextField
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<String>(
                  future: getData("theKey"),
                  builder: (context, snapshot) {
                    return Text(snapshot.data ?? "no data");
                  }),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      put("theKey", nameController.text);
                    });
                  },
                  child: const Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
