import 'package:bloc_vs_riverpod_example/domain/repositories/api_repository.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/bloc/fact_event.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/fact_state.dart';
import 'package:bloc/bloc.dart';
class FactBloc extends Bloc<FactEvent,FactState>{
  final ApiRepository _apiRepository;

  FactBloc( this._apiRepository,) : super(FactInitialState()) {
    on<LoadFactEvent>( // Declenchement de l'événement
          (event, emit) async {
        emit(FactLoadingState()); // on emet traitement de la requête on emet les données
        final fact = await _apiRepository.fetchFact();
        if (fact.success) { //en cas de succès
          emit(
            FactLoadedState(fact.data!),
          );
        } else { //En cas d'echec on emet le message d'erreur
          emit(
            FactErrorState(fact.error!),
          );
        }
      },
    );
    //
    on<NoInternetEvent>(
        (event ,emit) async{
          emit(FactNoInternetState());
        },
    );
  }

}