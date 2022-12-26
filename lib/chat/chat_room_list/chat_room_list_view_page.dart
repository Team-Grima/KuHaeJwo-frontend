import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/chat/chat_room/chat_room_view_page.dart';

import 'package:pet_app/chat/chat_room_list/chat_room_list_controller.dart';
import 'package:get/get.dart';
import 'package:pet_app/chat/chat_room_list/user_list_page.dart';
import 'package:pet_app/common/image_loader.dart';

import '../../common/common.dart';

class ChatRoomListViewPage extends StatelessWidget {
  const ChatRoomListViewPage({Key? key}) : super(key: key);
  static const url = '/chat-list';

  @override
  Widget build(BuildContext context) {
    ChatRoomListController controller = Get.put(ChatRoomListController());

    return Scaffold(
        backgroundColor: CommonColor.white,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: controller.user.value == null
                  ? null
                  : () {
                      Get.to(() => const UsersPage());
                    },
            ),
          ],
          backgroundColor: CommonColor.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.user.value == null ? null : controller.logout,
          ),
          // systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Center(
            child: Text(
              '채팅',
              style: CommonTextStyle(color: CommonColor.black, fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        body: controller.user.value == null
            ? Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  bottom: 200,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not authenticated'),
                    TextButton(
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     fullscreenDialog: true,
                        //     builder: (context) => L,
                        //   ),
                        // )
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              )
            : StreamBuilder<List<types.Room>>(
                stream: FirebaseChatCore.instance.rooms(),
                initialData: const [],
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        bottom: 200,
                      ),
                      child: const Text('No rooms'),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final room = snapshot.data![index];

                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ChatRoomViewPage(room: room));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.r,
                            vertical: 8.r,
                          ),
                          child: room.users.length == 1
                              ? Column(
                                  children: const [Text('알 수 없음')], // 상대가 채팅방 나간 경우.
                                )
                              : Column(
                                  children: [
                                    Row(
                                      children: [
                                        _buildAvatar(room),
                                        Text(
                                          room.name ?? '',
                                          style: CommonTextStyle(color: CommonColor.black, fontSize: 14, fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "",
                                      // room.lastMessages!.last.type == String ? room.lastMessages?.last.type.toString() ?? "" : "text",
                                      style: CommonTextStyle(color: CommonColor.black, fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    },
                  );
                },
              ));
  }

  Widget _buildAvatar(types.Room room) {
    var color = Colors.transparent;

    if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
          (u) => u.id != Get.find<ChatRoomListController>().user.value!.uid,
        );

        // color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found.
      }
    }

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: ImageLoader(
        url: room.imageUrl ?? "",
        height: 24.r,
        width: 24.r,
      ),
      // child: CircleAvatar(
      //   backgroundColor: hasImage ? Colors.transparent : color,
      //   backgroundImage: hasImage ? : null,
      //   radius: 20,
      //   child: !hasImage
      //       ? Text(
      //           name.isEmpty ? '' : name[0].toUpperCase(),
      //           style: const TextStyle(color: Colors.white),
      //         )
      //       : null,
      // ),
    );
  }
}
