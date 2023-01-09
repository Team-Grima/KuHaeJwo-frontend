import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/service/auth_service.dart';
import 'package:kuhaejwo_app/common/service/socket_service.dart';

class ChatRoomListController extends GetxController {
  SocketService socketService = SocketService();
  TextEditingController chatRoomIdController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  RxList<String> messageList = <String>[].obs;
  RxList<ChatModel> chatList = <ChatModel>[].obs;
  @override
  void onInit() {
    // super.onInit();
    // socketService.request(requestTopic, data)
    // socketService.request(requestTopic, data)
  }
  send() {
    socketService.request(RequestTopic.sendMessage, {
      "msg": messageController.text,
      "room_id": chatRoomIdController.text,
    });
    addChat(
        ChatModel(sender: AuthService().userAuthInfo.value?.name, msg: messageController.text, createdAt: DateTime.now().millisecondsSinceEpoch.toString()));
  }

  addChat(ChatModel chat) {
    chatList.add(chat);
    chatList.sort((a, b) {
      return a.createdAt?.compareTo(b.createdAt ?? "") ?? -1;
    });
  }

  clear() {
    chatList.clear();
  }
}

class ChatModel {
  String? sender;
  String? createdAt;
  String? msg;
  ChatModel({this.sender, this.createdAt, this.msg});
}
