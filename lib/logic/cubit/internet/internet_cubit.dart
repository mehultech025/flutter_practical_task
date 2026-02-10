import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetCubit extends Cubit<bool> {
  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  InternetCubit() : super(true) {
    _emitInitialInternetState();

    _subscription = _connectivity.onConnectivityChanged.listen(
          (List<ConnectivityResult> results) {
        emit(_hasInternet(results));
      },
    );
  }

  bool _hasInternet(List<ConnectivityResult> results) {
    return results.isNotEmpty &&
        !results.contains(ConnectivityResult.none);
  }

  Future<void> _emitInitialInternetState() async {
    final results = await _connectivity.checkConnectivity();
    emit(_hasInternet(results));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
