import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/service/auth_service.dart';
import 'package:kuhaejwo_app/common/service/socket_service.dart';
import 'package:kuhaejwo_app/pages/chat/chat_room/chat_room_view_page.dart';

class ChatRoomListController extends GetxController {
  SocketService socketService = SocketService();
  TextEditingController addController = TextEditingController();

  AuthService authService = AuthService();
  RxList<ChatModel> chatList = <ChatModel>[].obs;
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // super.onInit();
    // socketService.request(requestTopic, data)
    // socketService.request(requestTopic, data)
    getChatRooms();
  }

  getChatRooms() {
    socketService.request("getChatRoom", {"userId": authService.userAuthInfo.value?.id!.toString()});
  }

  setChatRooms(List<ChatRoomModel> list) {
    chatRoomList.clear();
    chatRoomList.addAll(list);
  }

  enterChatRoom(ChatRoomModel chatRoomModel) {
    Get.toNamed(ChatRoomViewPage.url, arguments: chatRoomModel);
  }

  createChatRoom() {
    String receiver = addController.text;
    socketService.request("createChatRoom", {"userId": receiver});
    getChatRooms();
  }

  addNewChatRoom() {
    getChatRooms();
  }
}

class ChatModel {
  BigInt sender;
  String createdAt;
  String msg;
  BigInt msgId;

// String? last message;
  ChatModel({
    required this.sender,
    required this.createdAt,
    required this.msg,
    required this.msgId,
  });
}

class ChatRoomModel {
  BigInt chatRoomId;
  List<BigInt> userList;
  String createdAt;
  Map<int, String>? userLastRead;
  MessageModel? lastMessage;
  ChatRoomModel({
    required this.chatRoomId,
    required this.userList,
    required this.createdAt,
    this.userLastRead,
    this.lastMessage,
    // required this.userLastRead,
    // required this.lastMessage,
  });
}

class MessageModel {
  BigInt messageId;
  BigInt chatRoomId;
  BigInt sender;
  String receiver;
  String msg;
  String createdAt;
  MessageModel({
    required this.messageId,
    required this.chatRoomId,
    required this.sender,
    required this.receiver,
    required this.msg,
    required this.createdAt,
  });
}

extension ListExtension on List {
  BigInt getOther(BigInt userId) {
    if (this[0] == null || this[1] == null) return userId;
    return this[0] == userId ? this[1] : this[0];
  }
}
