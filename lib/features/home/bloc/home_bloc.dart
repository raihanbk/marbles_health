import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:marbles_health/features/home/model/component_model.dart';
import 'package:meta/meta.dart';

import '../../../model/components.dart';
import '../../../model/saved_list.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeSaveComponentEvent>(homeSaveComponentEvent);
    on<HomeAddComponentEvent>(homeAddComponentEvent);
    on<HomeRemoveEvent>(homeRemoveEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) {
    components.add(ComponentModel());
    emit(HomeLoadedSuccessState());
  }

  FutureOr<void> homeSaveComponentEvent(
      HomeSaveComponentEvent event, Emitter<HomeState> emit) {
    final label = event.label ?? '';
    final info = event.info ?? '';
    final settings = event.settings ?? '';
    savedList.add({'label': label, 'info': info, 'settings': settings});
    emit(HomeSaveState(saved: savedList));
    emit(HomeLoadedSuccessState());
  }

  FutureOr<void> homeAddComponentEvent(
      HomeAddComponentEvent event, Emitter<HomeState> emit) {
    components.add(ComponentModel());
    emit(HomeLoadedSuccessState());
  }

  FutureOr<void> homeRemoveEvent(
      HomeRemoveEvent event, Emitter<HomeState> emit) {
    if (event.index >= 1 && event.index < components.length) {
      components.removeAt(event.index);
      savedList.removeAt(event.index);
    }
    emit(HomeLoadedSuccessState());
  }
}
