import 'package:flutter/material.dart';

class DialogExample extends StatefulWidget {
  const DialogExample({super.key, this.withFix = false});

  final bool withFix;

  @override
  State<DialogExample> createState() => _DialogExampleState();
}

class _DialogExampleState extends State<DialogExample> {
  void _onPressed() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(.3),
      builder: (context) {
        return Center(
          child: Material(
            child: SizedBox(
              height: 250,
              width: 250,
              child: widget.withFix ? _dialogContentHack : _dialogContent,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: _onPressed,
      child: Text(widget.withFix ? 'Show Dialog Fix' : 'Show Dialog'),
    );
  }

  Widget get _dialogContent => const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Form field one',
              ),
            ),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Form field two',
              ),
            ),
          ],
        ),
      );

  Widget get _dialogContentHack => Stack(
        children: [
          Positioned.fill(
            child: Semantics(hidden: true),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Form field one',
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Form field two',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
