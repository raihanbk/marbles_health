part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeSaveComponentEvent extends HomeEvent {
  final String label;
  final String info;
  final List settings;

  HomeSaveComponentEvent(
      {required this.label, required this.info, required this.settings});
}

class HomeAddComponentEvent extends HomeEvent {}

class HomeRemoveEvent extends HomeEvent {
  final int index;

  HomeRemoveEvent({
    required this.index
});
}
