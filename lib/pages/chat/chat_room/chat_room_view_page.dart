// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:kuhaejwo_app/pages/chat/chat_room/chat_room_controller.dart';

class ChatRoomViewPage extends StatelessWidget {
  const ChatRoomViewPage({Key? key}) : super(key: key);
  static const url = '/chat';

  @override
  Widget build(BuildContext context) {
    ChatRoomController controller = Get.put(ChatRoomController());
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Chat'),
        // actions: [
        //   IconButton(onPressed: controller.addUser, icon: Icons(add())
        // ],
      ),
      body: Obx(
        () => Column(
          children: [
            TextField(
              controller: controller.messageController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: controller.sendMsg,
                  child: const Text("send"),
                ),
                TextButton(
                  onPressed: controller.clear,
                  child: const Text("clear"),
                ),
              ],
            ),
            ...List.generate(
                controller.chatList.length,
                (index) => Row(
                      mainAxisAlignment:
                          controller.chatList[index].sender == controller.authService.userAuthInfo.value?.id ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        Text(controller.chatList[index].sender.toString()),
                        const Text("| "),
                        Text(controller.chatList[index].msgId.toString()),
                        const Text("| "),
                        Text(controller.chatList[index].msg),
                        const Text("| "),
                        Text(DateTime.fromMillisecondsSinceEpoch(int.tryParse(controller.chatList[index].createdAt) ?? 0).toIso8601String().split("T")[1]),
                      ],
                    ))
          ],
        ),
      ),
    );
  }

  // void _handleMessageTap(BuildContext _, types.Message message) async {
  //   if (message is types.FileMessage) {
  //     var localPath = message.uri;

  //     if (message.uri.startsWith('http')) {
  //       try {
  //         final updatedMessage = message.copyWith(isLoading: true);
  //         FirebaseChatCore.instance.updateMessage(
  //           updatedMessage,
  //           room.id,
  //         );

  //         final client = http.Client();
  //         final request = await client.get(Uri.parse(message.uri));
  //         final bytes = request.bodyBytes;
  //         final documentsDir = (await getApplicationDocumentsDirectory()).path;
  //         localPath = '$documentsDir/${message.name}';

  //         if (!File(localPath).existsSync()) {
  //           final file = File(localPath);
  //           await file.writeAsBytes(bytes);
  //         }
  //       } finally {
  //         final updatedMessage = message.copyWith(isLoading: false);
  //         FirebaseChatCore.instance.updateMessage(
  //           updatedMessage,
  //           room.id,
  //         );
  //       }
  //     }

  //     // await OpenFilex.open(localPath);
  //   }
  // }

  // void _handlePreviewDataFetched(
  //   types.TextMessage message,
  //   types.PreviewData previewData,
  // ) {
  //   final updatedMessage = message.copyWith(previewData: previewData);

  //   FirebaseChatCore.instance.updateMessage(updatedMessage, room.id);
  // }

  // void _handleSendPressed(types.PartialText message) {
  //   FirebaseChatCore.instance.sendMessage(
  //     message,
  //     room.id,
  //   );
  // }

  // void _setAttachmentUploading(bool uploading) {
  //   setState(() {
  //     _isAttachmentUploading = uploading;
  //   });
  // }
}

  // void _handleFileSelection() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.any,
  //   );

  //   if (result != null && result.files.single.path != null) {
  //     _setAttachmentUploading(true);
  //     final name = result.files.single.name;
  //     final filePath = result.files.single.path!;
  //     final file = File(filePath);

  //     try {
  //       final reference = FirebaseStorage.instance.ref(name);
  //       await reference.putFile(file);
  //       final uri = await reference.getDownloadURL();

  //       final message = types.PartialFile(
  //         mimeType: lookupMimeType(filePath),
  //         name: name,
  //         size: result.files.single.size,
  //         uri: uri,
  //       );

  //       FirebaseChatCore.instance.sendMessage(message, widget.room.id);
  //       _setAttachmentUploading(false);
  //     } finally {
  //       _setAttachmentUploading(false);
  //     }
  //   }
  // }

  // void _handleImageSelection() async {
  //   final result = await ImagePicker().pickImage(
  //     imageQuality: 70,
  //     maxWidth: 1440,
  //     source: ImageSource.gallery,
  //   );

  //   if (result != null) {
  //     _setAttachmentUploading(true);
  //     final file = File(result.path);
  //     final size = file.lengthSync();
  //     final bytes = await result.readAsBytes();
  //     final image = await decodeImageFromList(bytes);
  //     final name = result.name;

  //     try {
  //       final reference = FirebaseStorage.instance.ref(name);
  //       await reference.putFile(file);
  //       final uri = await reference.getDownloadURL();

  //       final message = types.PartialImage(
  //         height: image.height.toDouble(),
  //         name: name,
  //         size: size,
  //         uri: uri,
  //         width: image.width.toDouble(),
  //       );

  //       FirebaseChatCore.instance.sendMessage(
  //         message,
  //         widget.room.id,
  //       );
  //       _setAttachmentUploading(false);
  //     } finally {
  //       _setAttachmentUploading(false);
  //     }
  //   }
  // }

