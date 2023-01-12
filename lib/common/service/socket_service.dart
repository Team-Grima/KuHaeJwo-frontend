import 'package:get/get.dart';
import 'package:kuhaejwo_app/common/common.dart';
import 'package:kuhaejwo_app/common/service/auth_service.dart';
import 'package:kuhaejwo_app/pages/chat/chat_room/chat_room_controller.dart';
import 'package:kuhaejwo_app/pages/chat/chat_room_list/chat_room_list_controller.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() => _instance;
  SocketService._internal() {
    Common.logger.d('HttpServiceManager._internal() called!!!');
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      socket.emit('initializing', {
        "data": {"userId": AuthService().userAuthInfo.value!.id!.toString()}
      });

      // socket.emit("getStoreAdmin", {"id": 1});
    });

    socket.on('event', (data) {
      Common.logger.d(data);
      // if (data["type"] == "data") {
      //   if (documentChangeListenerMap.containsKey(DocumentTopic.fromString(data["documentTopic"]))) {
      //     for (var i in documentChangeListenerMap[DocumentTopic.fromString(data["documentTopic"])] ?? <Function>[]) {
      //       i(data["data"]);
      //     }
      //   }
      // }
    });

    socket.on('server_to_user', (data) {
      Common.logger.d(data);
      try {
        Get.find<ChatRoomController>().setChatMsg(ChatModel(
          sender: BigInt.parse(data['sender']),
          msg: data['msg'],
          createdAt: data['createdAt'],
          msgId: BigInt.parse(data["msgId"]),
        ));
      } catch (e) {
        Common.logger.e(e);
      }
    });
    socket.on('chatRoomRes', (data) {
      Common.logger.d(data);
      try {
        List<ChatRoomModel> chatRooms = [];
        for (var i in data["data"]) {
          chatRooms.add(ChatRoomModel(
            userList: [BigInt.parse(i["userList"][0]), BigInt.parse(i["userList"][1])],
            createdAt: i["createdAt"],
            chatRoomId: BigInt.parse(i["chatRoomId"]),
            // lastMessage: i["lastMessage"],
            // userLastRead: i["userLastRead"],
          ));
        }

        Get.find<ChatRoomListController>().setChatRooms(chatRooms);
      } catch (e) {
        Common.logger.e(e);
      }
    });
    socket.on('chatRoomCreated-chatRoomRes', (data) {
      Common.logger.d(data);
      try {
        List<ChatRoomModel> chatRooms = [];
        for (var i in data["data"]) {
          chatRooms.add(ChatRoomModel(
            userList: [BigInt.parse(i["userList"][0]), BigInt.parse(i["userList"][1])],
            createdAt: i["createdAt"],
            chatRoomId: BigInt.parse(i["chatRoomId"]),
            // lastMessage: i["lastMessage"],
            // userLastRead: i["userLastRead"],
          ));
        }

        Get.find<ChatRoomListController>().setChatRooms(chatRooms);
      } catch (e) {
        Common.logger.e(e);
      }
    });

    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  Socket socket = io(
      'https://ku.woojin-dev.kro.kr',
      OptionBuilder()
          .setTransports(["websocket"]) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build());

  Map<DocumentTopic, List<Function>> documentChangeListenerMap = <DocumentTopic, List<Function>>{};

  Function subscribeDocumentTopic(DocumentTopic documentTopic, void Function(Map<String, dynamic> result) callback) {
    if (!documentChangeListenerMap.containsKey(documentTopic) || documentChangeListenerMap[documentTopic] == null) {
      documentChangeListenerMap[documentTopic] = <Function>[];
    }
    if (documentChangeListenerMap.containsKey(documentTopic) && documentChangeListenerMap[documentTopic] != null) {
      documentChangeListenerMap[documentTopic]!.add(callback);
    }
    return callback;
  }

  void request(String requestTopic, dynamic data) {
    socket.emit(requestTopic, data);
  }
}

enum DocumentTopic {
  storeAdmin("storeAdmin");

  final String key;
  const DocumentTopic(this.key);

  @override
  String toString() => key;

  static DocumentTopic? fromString(String key) {
    switch (key) {
      case "storeAdmin":
        return DocumentTopic.storeAdmin;
    }
    return null;
  }
}

extension DocumentTopicString on String {
  DocumentTopic? get documentTopic => DocumentTopic.fromString(this);
}

enum RequestTopic {
  sendMessage("sendMessage"),
  creaeChatRoom("creaeChatRoom");

  final String key;
  const RequestTopic(this.key);

  @override
  String toString() => key;

  static RequestTopic? fromString(String key) {
    switch (key) {
      case "sendMessage":
        return RequestTopic.sendMessage;
      case "creaeChatRoom":
        return RequestTopic.creaeChatRoom;
    }
    return null;
  }
}

extension SubsribeExtension on Function? {
  dispose() {
    if (this == null) return;
    SocketService socketService = Get.find<SocketService>();
    for (var i in socketService.documentChangeListenerMap.values) {
      i.remove(this);
    }
  }
}
