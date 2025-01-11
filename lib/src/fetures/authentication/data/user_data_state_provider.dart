import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user/user.dart';

class UserStateNotifier extends StateNotifier<User?> {
  UserStateNotifier() : super(null);

  void setUser(User user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }

  void updateUser({String? userId, String? userRole, String? csrf, String? jwt}) {
    state = User(
      id: userId ?? state?.id,
      role: userRole ?? state?.role,
      csrf: csrf ?? state?.csrf,
      jwt: jwt ?? state?.jwt,
    );
  }
}

final userStateProvider = StateNotifierProvider<UserStateNotifier, User?>((ref) {
  return UserStateNotifier();
});