import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marbles_health/features/home/bloc/home_bloc.dart';
import 'package:marbles_health/features/home/widgets/component.dart';

import '../../../model/components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {
        switch (state.runtimeType) {
          case HomeSaveState:
            final savedState = state as HomeSaveState;
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Saved Components'),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: state.saved.map((e) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all()
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e['label']),
                                Text(e['info']),
                                Text('${'Settings: '+(e['settings'] as List).join()}'),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                        savedState.saved.clear();
                      },
                          child: const Text('OK')),
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                      }, child: const Text('Cancel'))
                    ],
                  );
                });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Task'),
            elevation: 10,
            actions: [
              IconButton(
                  onPressed: saveAllComponents, icon: const Icon(Icons.save))
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ...components
                      .map((e) => ComponentWidget(component: e, index: components.indexOf(e), homeBloc: homeBloc,)),
                  ElevatedButton(
                      onPressed: () {
                        homeBloc.add(HomeAddComponentEvent());
                      },
                      child: const Text('Add'))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void saveAllComponents() {
    for (var component in components) {
      final label = component.labelController.text;
      final info = component.infoController.text;
      final settings = component.checkBox
          .where((element) => element['isChecked'] == true)
          .map((e) => e['title'].toString())
          .toList();
      homeBloc.add(HomeSaveComponentEvent(
        label: label.isEmpty ? 'Empty Label' : label,
        info: info.isEmpty ? 'Empty Info' : info,
        settings: settings.isEmpty ? ['Empty'] : settings,
      ));
      // component.labelController.clear();
      // component.infoController.clear();
    }
  }
}
