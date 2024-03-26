import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureWidget extends StatefulWidget {
  final void Function(File imageFile) onSignatureChanged;

  const SignatureWidget({Key? key, required this.onSignatureChanged}) : super(key: key);

  @override
  _SignatureWidgetState createState() => _SignatureWidgetState();
}

class _SignatureWidgetState extends State<SignatureWidget> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  Future<void> _exportSignature() async {
    try {
      final Uint8List? data = await _controller.toPngBytes();
      final File tempFile = File('${DateTime.now().millisecondsSinceEpoch.toString()}.png');
      await tempFile.writeAsBytes(data!);
      widget.onSignatureChanged(tempFile);
    } catch (e) {
      print('Error exporting signature: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Signature(
            controller: _controller,
            height: 200,
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.clear();
                });
              },
              child: Text('Clear'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.undo();
                });
              },
              child: Text('Undo'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.redo();
                });
              },
              child: Text('Redo'),
            ),
            ElevatedButton(
              onPressed: () {
                _exportSignature();
              },
              child: Text('Export Signature'),
            ),
          ],
        ),
      ],
    );
  }
}


