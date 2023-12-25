part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthIn extends AuthState {
  final String login;

  AuthIn({required this.login});
}