import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:logos/blocs/bloc.dart';
import 'package:logos/services/api.dart';

abstract class AuthFormEvent {}

class EmailAuthFormEvent extends AuthFormEvent {
  final String email;
  EmailAuthFormEvent(this.email);
}

class PasswordAuthFormEvent extends AuthFormEvent {
  final String password;
  PasswordAuthFormEvent(this.password);
}

class SubmitAuthFormEvent extends AuthFormEvent {
  SubmitAuthFormEvent();
}

class AuthFormState {
  final String email, password;
  final bool isEmailValid, isPasswordValid;
  final bool isSubmitEnabled;
  final bool isError;
  AuthFormState([
    this.email,
    this.password,
    this.isEmailValid,
    this.isPasswordValid,
    this.isSubmitEnabled = false,
    this.isError = false,
  ]);
  AuthFormState copyWith({
    String email,
    String password,
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isError,
  }) {
    return AuthFormState(
      email ?? this.email,
      password ?? this.password,
      isEmailValid ?? this.isEmailValid,
      isPasswordValid ?? this.isPasswordValid,
      isSubmitEnabled,
      isError ?? this.isError,
    );
  }
}

class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState> {
  @override
  AuthFormState get initialState => AuthFormState();

  @override
  Stream<AuthFormState> mapEventToState(AuthFormEvent event) async* {
    if (event is EmailAuthFormEvent && event.email != currentState.email) {
      bool isEmailValid = validateEmail(event.email);
      yield currentState.copyWith(
        email: event.email,
        isEmailValid: isEmailValid,
        isSubmitEnabled: currentState.isPasswordValid != null && isEmailValid && currentState.isPasswordValid,
        isError: false,
      );
    }

    if (event is PasswordAuthFormEvent && event.password != currentState.password) {
      bool isPasswordValid = event.password.length > 0;
      yield currentState.copyWith(
        password: event.password,
        isPasswordValid: isPasswordValid,
        isSubmitEnabled: currentState.isEmailValid != null && currentState.isEmailValid && isPasswordValid,
        isError: false,
      );
    }
    if (event is SubmitAuthFormEvent) {
      yield currentState.copyWith(isSubmitEnabled: null, isError: null);
      try {
        var token = await Api.login(currentState.email, currentState.password);
        InitBloc.getInstance().dispatch(LoginInitEvent(token));
      } catch (de) {
        if (de is DioError) yield currentState.copyWith(isError: true);
      }
    }
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return regex.hasMatch(value);
}
