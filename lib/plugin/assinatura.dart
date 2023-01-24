import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class Assinatura extends StatefulWidget {
  final SignatureController _controller;

  Assinatura(this._controller);

  @override
  _AssinaturaState createState() => _AssinaturaState();
}

class _AssinaturaState extends State<Assinatura> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campo de assinatura'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: Signature(
                controller: widget._controller,
                height: 600,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          TextButton(
              onPressed: () async {
                Uint8List data = await widget._controller.toPngBytes();

                Navigator.pop(context, data);
              },
              child: Text('Concluir'))
        ],
      ),
    );
  }
}
