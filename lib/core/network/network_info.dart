import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl({required Connectivity connectivity})
      : _connectivity = connectivity;

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await _connectivity.checkConnectivity();
    // Check if the device is connected to any network (Wi-Fi, mobile, etc.)
    // ignore: unrelated_type_equality_checks
    return connectivityResult != ConnectivityResult.none;
  }
}

final connectivityProvider = Provider<Connectivity>(
  (ref) => Connectivity(),
);

final networkInfoProvider = Provider<NetworkInfo>(
  (ref) {
    final connectivity = ref.watch(connectivityProvider);
    return NetworkInfoImpl(connectivity: connectivity);
  },
);