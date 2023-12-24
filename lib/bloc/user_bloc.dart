import 'package:flutter/material.dart';
import 'package:suitmedia_quest/logic/model/remote_data.dart';
import 'package:suitmedia_quest/logic/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final RemoteData remoteData;
  UserBloc(this.remoteData) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final result = await remoteData.getDataUser();
        emit(UserLoaded(data: result.data));
      } catch (error) {
        emit(UserError(error.toString()));
      }
    });
  }
}
