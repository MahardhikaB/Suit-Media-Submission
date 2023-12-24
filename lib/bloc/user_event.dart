part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class SelectUser extends UserEvent {
  final User user;

  SelectUser(this.user);
}
