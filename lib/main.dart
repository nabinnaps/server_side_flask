import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIOPage extends StatefulWidget {
  @override
  _SocketIOPageState createState() => _SocketIOPageState();
}

class _SocketIOPageState extends State<SocketIOPage> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  void connectToSocket() {
    socket = IO.io('http://127.0.0.1:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.connect();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  void sendMessage() {
    // For example:
    socket.emit('message_event', ['Your message here']);
    print("sending ........");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SocketIO Client UI'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: sendMessage,
              child: Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocketIO Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SocketIOPage(),
    );
  }
}

