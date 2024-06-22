import 'package:bloc_vs_riverpod_example/page/fact_card.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/fact_state.dart';
import 'package:flutter/material.dart';

class LoadFactButton extends StatelessWidget{
  final FactState state;
  final Function()? onPressed;
  final bool isConnected;
  final String title;

  const LoadFactButton({
    super.key,
    required this.state,
    this.onPressed,
    required this.isConnected,
    required this.title

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
        //Si on est connecté au wifi on execute sinon rien
        onPressed : isConnected ? onPressed : null,
        child: Text(title)
        ),
        const SizedBox(height: 25,),
        //Si l'etat est en cours
        if (state is FactLoadingState)
        //Affichage de la barre de progession circulaire
          const Center(child: CircularProgressIndicator()),
        // Si on a finit le traitement
        if (state is FactLoadedState)
          FactCard(
            (state as FactLoadedState).fact,
          ),
      ],
    );
  }
}