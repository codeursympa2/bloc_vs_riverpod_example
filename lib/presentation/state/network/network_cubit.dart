import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bloc/bloc.dart';



// Cubit est un outil puissant et simple pour la gestion de l'état dans les applications Flutter,
// idéal pour les cas d'utilisation qui ne nécessitent pas la complexité complète de Bloc.
class NetworkInfoCubit extends Cubit<ConnectivityResult> {
    NetworkInfoCubit(Connectivity _connectivityService)
        : super(ConnectivityResult.wifi) {
        _connectivityService.onConnectivityChanged.listen((event) {
            connectionChanged(event as ConnectivityResult);
        });
    }

    //emition de la connectivité en cas de changement
    void connectionChanged(ConnectivityResult result) {
       emit(result);
    }

}

//Vérification si on est connecté au wifi
bool isConnected(ConnectivityResult connection) {
    return connection != ConnectivityResult.none;
}