import 'package:flutter/material.dart';
import 'package:my_promotions_app/utils/permission.dart';
import 'package:readsms/readsms.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _plugin = Readsms();
  String sms = 'no sms';

  @override
  void initState() {
    super.initState();
    requestSmsPermission().then((value) {
      if (value) {
        _plugin.read();
        _plugin.smsStream.listen((event) {
          setState(() {
            sms = event.body;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _plugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('new sms: $sms')
            ],
          ),
        ),
      ),
    );
  }
}
