import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/service/auth_service.dart';
import 'package:kuhaejwo_app/common/service/socket_service.dart';
import 'package:kuhaejwo_app/pages/chat/chat_room_list/chat_room_list_controller.dart';

class ChatRoomController extends GetxController {
  SocketService socketService = SocketService();
  TextEditingController chatRoomIdController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  AuthService authService = AuthService();
  RxList<ChatModel> chatList = <ChatModel>[].obs;
  late ChatRoomModel chatRoomModel;
  @override
  void onInit() {
    super.onInit();
    chatRoomModel = Get.arguments as ChatRoomModel;
  }

  sendMsg() {
    socketService.request("sendMessage", {
      "msg": messageController.text,
      "chatRoomId": chatRoomModel.chatRoomId.toString(),
    });
  }

  setChatMsg(ChatModel chat) {
    chatList.add(chat);
    sortChatList();
  }

  sortChatList() {
    chatList.sort((a, b) {
      return a.createdAt.compareTo(b.createdAt);
    });
  }

  clear() {
    chatList.clear();
  }
}
