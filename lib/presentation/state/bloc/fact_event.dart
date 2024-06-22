import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FactEvent extends Equatable {
  const FactEvent();
}

//Est déclenché lorsque l'appareil est connecté à Internet et que le bouton est enfoncé.
class LoadFactEvent extends FactEvent {
  @override
  List<Object> get props => [];
}

//Est déclenché lorsqu'il n'y a pas de connexion Internet.
class NoInternetEvent extends FactEvent {
  @override
  List<Object?> get props => [];
}