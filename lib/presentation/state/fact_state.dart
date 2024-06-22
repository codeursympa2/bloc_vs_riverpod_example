import 'package:bloc_vs_riverpod_example/Data/models/fact.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FactState extends Equatable {
  const FactState();

  @override
  List<Object> get props => [];
}

class FactInitialState extends FactState {}

//Requete en cours de traitement barre de progression
class FactLoadingState extends FactState {}

//Récupération des données réussie
class FactLoadedState extends FactState {
  final Fact fact;

  const FactLoadedState(this.fact);
}

//Echec de la recupération affichage d'un message
class FactErrorState extends FactState {
  final String error;

  const FactErrorState(this.error);
}

//Pas de connexion internet
class FactNoInternetState extends FactState {}

