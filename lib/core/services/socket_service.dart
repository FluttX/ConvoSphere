import 'dart:developer';

import 'package:convo_sphere/core/constants/app_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  late io.Socket _socket;
  final _storage = const FlutterSecureStorage();

  SocketService._internal() {
    initSocket();
  }

  Future<void> initSocket() async {
    String token = await _storage.read(key: 'token') ?? '';
    _socket = io.io(
      AppConstants.baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      log(' - socket connected: ${_socket.id}', name: 'SOCKET');
    });

    _socket.onDisconnect((_) {
      log(' - socket discounted!', name: 'SOCKET');
    });
  }

  io.Socket get socket => _socket;
}
