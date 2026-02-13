import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practical_task/logic/cubit/internet/internet_cubit.dart';
import 'package:flutter_practical_task/services/notification_services.dart';
import 'package:flutter_practical_task/utils/constants/fonts/label_keys.dart';
import 'package:hive/hive.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final InternetCubit internetCubit;

  LoginCubit(this.internetCubit) : super(LoginInitial());

  Future<void> submitUser({
    required String name,
    required String email,
    required String password,
  }) async {
    if (!internetCubit.state) {
      emit(LoginError(noInternetKey));
    } else if (name.isEmpty) {
      emit(LoginError("Name cannot be empty!."));
    } else if (email.isEmpty) {
      emit(LoginError("Email address cannot be empty!."));
    } else if (password.isEmpty) {
      emit(LoginError("password can not be empty!."));
    } else {
      try {
        emit(LoginLoading());

        await FirebaseFirestore.instance.collection('todo_users').add({
          'name': name,
          'email': email,
          'password': password,
          'createdAt': DateTime.now(),
        });
        NotificationService.showNotification(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title: welcomeKey,
          body: successfullyLoginKey,
        );
        Hive.box('auth').put('isLogin', true);
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    }
  }
}
