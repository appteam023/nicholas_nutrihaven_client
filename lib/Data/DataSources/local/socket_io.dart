import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../remote/api_constant.dart';

class SocketConnect {
  static IO.Socket socket = IO.io('http://rootroom.testdevlink.net:3012',
      IO.OptionBuilder().setTransports(['websocket']).build());

  static connectionBuild() {
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('error', (error) => print('error in socket $error'));
    // socket.on('privateMessage', (data) {
    //   print("onMessage Function: $data");
    // });
    // socket.on('chatList', (data) => print('$data'));
    // socket.emit('register', {'id': ApiConstants.userData!.id});
    // socket.onAny((event, data) => print('event: $event, data $data'));
    // socket.on('event', (data) => print(data));
    socket.onDisconnect((err) => print('disconnect $err'));
    // socket.on('fromServer', (server) => print("server : $server"));
    socket.onConnectError((err) => print("ConnectError ==> $err"));
    // messageList.add(message);
    // update();
  }
}
