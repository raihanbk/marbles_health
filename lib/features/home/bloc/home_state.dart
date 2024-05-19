part of 'home_bloc.dart';

abstract class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadedSuccessState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeSaveState extends HomeState {
  final List saved;

  HomeSaveState({
    required this.saved
});
}