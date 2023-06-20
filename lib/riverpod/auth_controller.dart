import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



final authControllerProvider = StateNotifierProvider<AuthController, int>(
  (ref) => AuthController(ref),
);


class AuthController extends StateNotifier<int> {
  final Ref ref;
  Timer? _timer;

  AuthController(this.ref) : super(0) {

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        state = 1;
      } else {
        FirebaseFirestore.instance.collection('admin').doc(user.uid).snapshots().listen((event) {
          Map<String,dynamic>? map=event.data();
          if(map==null){
            state=1;
          }else{
            state = 2;
          }
        }).onError((error, stackTrace){
          state=-1;
        });

      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  void signOut() async {
    FirebaseAuth.instance.signOut();
    state = 1;
  }
}
