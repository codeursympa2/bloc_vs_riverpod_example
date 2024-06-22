import 'package:bloc_vs_riverpod_example/Data/models/api_response.dart';
import 'package:bloc_vs_riverpod_example/Data/models/fact.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/fact_state.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/state_notifier/state_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_vs_riverpod_example/domain/repositories/api_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import '../consts.dart';
import 'fact_state_notifier_test.mocks.dart';

@GenerateMocks([ApiRepository])
void main() {
  final mockApiRepo=MockApiRepository();
  final fact= Fact(id:"1",text: "Lorem");

    stateNotifierTest(
        "Emet un tableau vide [] lorsque aucune méthode n'est appellée",
        build: () => FactsNotifier(mockApiRepo),
        expect: ()=> [], // Retour attendu
        actions: (FactsNotifier stateNotifier){} // On ne fait rien aucune methode n'est appellé
    );

    stateNotifierTest<FactsNotifier,FactState>(
        "Quand la requete réussie",
        build: ()=> FactsNotifier(mockApiRepo),
        setUp: () async{
          when(mockApiRepo.fetchFact()).thenAnswer(
              (value)async {
                return ApiResponse(
                  success: true,
                  data: fact
                );
              }
          );
        },
        actions: (FactsNotifier stateNotifier) {
          stateNotifier.load();
        },
        expect: ()=> [
          FactLoadingState(),
          FactLoadedState(fact)
        ],
        tearDown: (){
          reset(mockApiRepo);
        },
      verify: (FactsNotifier stateNotifier) {
          return verify(mockApiRepo.fetchFact()).called(1);
      }
    );

    stateNotifierTest(
        "Quand la requete échoue",
        actions: (FactsNotifier stateNotifier){
          stateNotifier.load();
        },
        build: () => FactsNotifier(mockApiRepo),
        setUp: () async {
          when(mockApiRepo.fetchFact()).thenAnswer(
              (value)async{
                return ApiResponse(
                  success: false,
                  data: null,
                  error: message
                );
              }
          );
        },
        expect: ()=> [
          FactLoadingState(),
          const FactErrorState(message)
        ],

    );


}