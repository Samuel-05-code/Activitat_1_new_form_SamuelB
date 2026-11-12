import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Recuperar el valor d''un camp de text',
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});
  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  // 1. SimpleDialog
  void _mostraSimpleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('SimpleDialog'),
          contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          children: <Widget>[
            Text(myController.text),
          ],
        );
      },
    );
  }

  // 2. AlertDialog amb un botó
  void _mostraAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog'),
          content: Text(myController.text),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // 3. SnackBar
  void _mostraSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(myController.text)),
    );
  }

  // 4. ModalBottomSheet
  void _mostraBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(myController.text),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Tancar BottomSheet'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Botó flotant reutilitzable amb color propi
  Widget _fab(String tag, String tooltip, Color color, IconData icona,
      VoidCallback onPressed) {
    return FloatingActionButton(
      heroTag: tag,
      backgroundColor: color,
      foregroundColor: Colors.white,
      tooltip: tooltip,
      onPressed: onPressed,
      child: Icon(icona),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar el valor d\'un camp de text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _fab('simple', 'SimpleDialog', Colors.red, Icons.chat_bubble_outline,
              _mostraSimpleDialog),
          const SizedBox(height: 12),
          _fab('alert', 'AlertDialog', Colors.green, Icons.warning_amber,
              _mostraAlertDialog),
          const SizedBox(height: 12),
          _fab('snack', 'SnackBar', Colors.purple, Icons.notifications_none,
              _mostraSnackBar),
          const SizedBox(height: 12),
          _fab('sheet', 'BottomSheet', Colors.orange, Icons.text_fields,
              _mostraBottomSheet),
        ],
      ),
    );
  }
}
