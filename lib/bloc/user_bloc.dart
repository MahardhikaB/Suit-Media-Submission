import 'package:flutter/material.dart';
import 'package:suitmedia_quest/logic/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<SelectUser>((event, emit) {
      emit(UserLoaded(event.user));
    });
  }
}
