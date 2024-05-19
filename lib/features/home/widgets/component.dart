import 'package:flutter/material.dart';
import 'package:marbles_health/features/home/bloc/home_bloc.dart';
import 'package:marbles_health/features/home/model/component_model.dart';

class ComponentWidget extends StatefulWidget {
  final ComponentModel component;
  final int index;
  final HomeBloc homeBloc;
  const ComponentWidget({super.key, required this.component, required this.index, required this.homeBloc});

  @override
  State<ComponentWidget> createState() => _ComponentWidgetState();
}

class _ComponentWidgetState extends State<ComponentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(0, 1))
          ]),
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.index > 0 ? Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                widget.homeBloc.add(HomeRemoveEvent(index: widget.index));
              },
              child: const Text('remove'),
            ),
          ) : const SizedBox(),
          textField(label: 'Label *', hintText: 'label', controller: widget.component.labelController),
          textField(label: 'info-Text', controller: widget.component.infoController),
          const Text('Settings'),
          Row(
            children: widget.component.checkBox.map((e) {
              return Expanded(
                  child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(e['title']),
                      value: e['isChecked'],
                      onChanged: (value) {
                        setState(() {
                          e['isChecked'] = value;
                        });
                      }));
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget textField(
      {required String label, required TextEditingController controller, String? hintText}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
