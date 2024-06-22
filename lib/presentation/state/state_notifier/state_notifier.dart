import 'package:bloc_vs_riverpod_example/domain/repositories/api_repository.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/fact_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Pour acceder à notre fact via le provider riverpod
final factsNotifierProvider = StateNotifierProvider<FactsNotifier,FactState>(
  (ref) => FactsNotifier(
    ApiRepository(),
  ),
);



class FactsNotifier extends StateNotifier<FactState>{
    final ApiRepository _apiRepository;

    FactsNotifier(this._apiRepository) : super(FactInitialState());

    void load() async{
      //Puisque les widgets seront à l'ecoute ils seront automatiquement notifié du changement de l'état
      state=FactLoadingState(); // Traitement
      final fact =await _apiRepository.fetchFact();

      //On check
      if(fact.success){
        //en cas de succès on change l'etat
        state=FactLoadedState(fact.data!);
      }else{ 
        //En cas d'echec on renvoie l'errreur avec le message de la requete
        state=FactErrorState(fact.error!);
      }

    }
}

