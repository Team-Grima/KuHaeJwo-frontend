import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_app/firebase_options.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatRoomListController extends GetxController {
  final bool _error = false;

  Rxn<User> user = Rxn(null);

  @override
  void onInit() {
    super.onInit();
    initializeFlutterFire();
  }

  void initializeFlutterFire() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: "test1@gmail.com", password: "asdfasdf");
    user.value = userCredential.user;
    createUser(userCredential);

    // FirebaseAuth.instance.authStateChanges().listen((User? usr) {
    //   user.value = usr;
    // });
  }

  void createUser(UserCredential userCredential) async {
    await FirebaseChatCore.instance.createUserInFirestore(
      types.User(
        firstName: 'asdfasdf',
        id: userCredential.user?.uid ?? "error-user", // UID from Firebase Authentication
        imageUrl: 'https://i.pravatar.cc/300',
        lastName: 'Doe',
      ),
    );
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
