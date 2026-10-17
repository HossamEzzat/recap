import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/auth_respostiry.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRespostiry authRespostiry;
  AuthCubit(this.authRespostiry) : super(AuthInitial());

  login({required String email, required String password}) {
    emit(AuthLoading());
    try {
      authRespostiry.login(email: email, password: password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String address,
    required String phone,
  }) {
    emit(AuthLoading());
    try {
      authRespostiry.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        address: address,
        phone: phone,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  logout() async {
    await authRespostiry.logout();
    emit(AuthInitial());
  }
}
