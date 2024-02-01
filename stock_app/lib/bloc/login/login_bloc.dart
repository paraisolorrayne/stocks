import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/bloc/login/login_event.dart';
import 'package:stock_app/bloc/login/login_state.dart';
import 'package:stock_app/repository/login/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final FlutterSecureStorage storage;

  LoginBloc({required this.userRepository, required this.storage})
      : super(LoginInitial()) {
    on<Submitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final token = await userRepository.authenticate(
          email: event.email,
          password: event.password,
        );
        if (token != null) {
          // Save the token securely
          await storage.write(key: 'authentication_token', value: token);
          emit(LoginSuccess(token: token));
        } else {
          // Handle the case where token is null
          emit(LoginFailure(error: 'Authentication failed, token was null'));
        }
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });
  }
}
