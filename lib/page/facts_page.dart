
import 'package:bloc_vs_riverpod_example/domain/repositories/api_repository.dart';
import 'package:bloc_vs_riverpod_example/page/load_fact_button.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/bloc/fact_bloc.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/bloc/fact_event.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/fact_state.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/network/network_cubit.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/state_notifier/state_notifier.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//On remplace StatelessWidget par ConsumerWidget afin que notre build
// puisse recevoir le paramètre ref de riverpod
class FactsPage extends ConsumerStatefulWidget{
  const FactsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FactState();
}

class _FactState extends ConsumerState<FactsPage>{

  @override
  Widget build(BuildContext context) {
    final ApiRepository rep=ApiRepository();
    //Observation de l'etat avec riverpod
    final state = ref.watch(factsNotifierProvider);
    //Suivi de changement réseau de notre application
    return BlocBuilder<NetworkInfoCubit,ConnectivityResult>(
        builder: (context,connectivityState){
          return BlocProvider(
              create: (context) => FactBloc(rep),
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Random Facts"),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Pour riverpod
                    LoadFactButton(
                        title: "Load Random Fact avec River",
                        state: state,
                        isConnected: isConnected(connectivityState),
                        //On lance la recupération des facts aléatoire
                        onPressed: ()=> ref.read(factsNotifierProvider.notifier).load(),
                    ),
                    const SizedBox(height: 35,),
                    //Pour bloc
                    BlocBuilder<FactBloc, FactState>(
                        builder: (context,state){
                          return LoadFactButton(
                              title: "Load Random Fact avec Bloc",
                              state: state,
                              isConnected: isConnected(connectivityState),
                              onPressed: (){
                                //On lance la recupération des facts aléatoire en declenchant l'evenement LoadFactEvent
                                context.read<FactBloc>().add(LoadFactEvent());
                              },

                          );
                        }
                       ),



                  ],),
              ),
          );
        }
    );
  }

}