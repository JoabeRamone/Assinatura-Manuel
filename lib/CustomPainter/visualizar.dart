import 'package:flutter/material.dart';

class Visualizar extends StatelessWidget {

  final data;

  Visualizar(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Assinatura'),),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Image.memory(data),
          ),
        ),
      ),
    );
  }
}
