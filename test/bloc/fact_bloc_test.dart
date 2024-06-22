import 'package:bloc_vs_riverpod_example/Data/models/api_response.dart';
import 'package:bloc_vs_riverpod_example/Data/models/fact.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/bloc/fact_bloc.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/bloc/fact_event.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/fact_state.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_vs_riverpod_example/domain/repositories/api_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import '../consts.dart';
import 'fact_bloc_test.mocks.dart';

@GenerateMocks([ApiRepository])
void main() {
  //Notre repo avec Mock
  final mockApiRepo= MockApiRepository();
  final fact = Fact(id: "1", text: 'Test');

  blocTest<FactBloc, FactState>(
    "le BLoC émet un état vide lorsqu'aucun événement n'est ajouté",
    build: () => FactBloc(mockApiRepo), //instance de FactBloc en utilisant un mock (mockApiRepo) comme dépendance
    expect: () => const <FactState>[],  //BLoC émette une liste vide (const <FactState>[]) lorsqu'il n'y a pas d'événements ajoutés
  );

  blocTest(
      "Le BloC emet FactLoadingState, FactLoadedState quand l'api renvoie true.",
      build: () => FactBloc(mockApiRepo),
      //Configuration de l'état initial
      setUp:  () async {
        when(mockApiRepo.fetchFact()).thenAnswer(
            (value) async{
              return ApiResponse(
                success: true,
                data: fact
              );
            }
        );
      },
    //Declenchement du comportement des actions
    act: (FactBloc bloc){
        bloc.add(LoadFactEvent());
    },
   //Liste d'etats à retourner (resultat)
    expect: ()=>[
      FactLoadingState(),
      FactLoadedState(fact)
    ],
    //Apres les tests on initialise notre repo
    tearDown: (){
        reset(mockApiRepo);
    },
    //On verifie que notre repo est appellé une fois
    verify: (FactBloc bloc) => verify(mockApiRepo.fetchFact()).called(1)

  );

  blocTest(
      "Quand l'Api renvoie false à la requete",
      build: ()=> FactBloc(mockApiRepo),
      setUp: () async{
        when(mockApiRepo.fetchFact()).thenAnswer(
            (value) async{
              return ApiResponse(
                success: false,
                error: message,
                data: null
              );
            }
        );
      },
    act: (FactBloc bloc){
        bloc.add(LoadFactEvent());
    },
    expect: ()=> [
      FactLoadingState(),
      const FactErrorState(message)
    ],
    tearDown: () {
        reset(mockApiRepo);
    },
    verify: (FactBloc bloc){
        return verify(mockApiRepo.fetchFact()).called(1);
    }
  );

}