import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import 'assinatura.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 4,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );
  var data;

  Future<void> _criarImagem(context) async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) => Assinatura(_controller)),
    );
    setState(() {
      data = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Assinatura em Flutter'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _criarImagem(context);
                  },
                  child: Card(
                      shape:
                          RoundedRectangleBorder(side: new BorderSide(color: Colors.black87, width: 2.0), borderRadius: BorderRadius.circular(4.0)),
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: data != null
                            ? Image.memory(data)
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Clique aqui para assinar"),
                              ),
                      )),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.clear();
                  data = null;
                });
              },
              child: Icon(Icons.clear)),
        ),
      ),
    );
  }
}
