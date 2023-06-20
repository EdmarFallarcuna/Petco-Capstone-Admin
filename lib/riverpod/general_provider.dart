

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_controller.dart';


final mainPageProvider = Provider<int>((ref) {
  final int user = ref.watch(authControllerProvider);

  if(user==-1){
    return -1;
  }else if(user==0){
    return 0;
  }else if(user==1){
    return 1;
  }else if(user==2){
    return 2;
  }else{
    return -1;
  }


});
final withUserPageProvider = StateProvider<int>((ref) =>0);
final withOutUserPageProvider = StateProvider<int>((ref) =>0);