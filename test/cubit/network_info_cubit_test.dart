import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/network/network_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_cubit_test.mocks.dart';

//Test quand la connectivité change

class MockNetworkInfoCubit extends MockCubit<ConnectivityResult>
    implements NetworkInfoCubit {}

@GenerateMocks([Connectivity])
void main() {
  test('Les differentes types de conexion emisent lorsque la connexion change', () {
    final _connectivityService = MockConnectivity();
    final _cubit = MockNetworkInfoCubit();

    //Emission lors de l'écoute
    whenListen(
      _cubit,
      Stream.fromIterable([
        ConnectivityResult.mobile,
        ConnectivityResult.none,
        ConnectivityResult.wifi,
      ]),
      initialState: ConnectivityResult.wifi, // etat initial
    );

    //Spécification du comportement
    when(_connectivityService.onConnectivityChanged)
        .thenAnswer((realInvocation) {
      return Stream.fromIterable([
        ConnectivityResult.mobile,
        ConnectivityResult.none,
        ConnectivityResult.wifi,
      ] as Iterable<List<ConnectivityResult>>);
    });

    //Validation des émissions du cubit avec expectLater
    expectLater(
      _cubit.stream,
      emitsInOrder(
        [
          ConnectivityResult.mobile,
          ConnectivityResult.none,
          ConnectivityResult.wifi
        ],
      ),
    );
  });

}