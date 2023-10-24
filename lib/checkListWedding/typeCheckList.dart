import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class TypeCheckList extends StatefulWidget {
  const TypeCheckList({required this.title, required this.data});

  final String title;
  final List<String> data;

  @override
  State<TypeCheckList> createState() => _TypeCheckListState();
}

class _TypeCheckListState extends State<TypeCheckList> {

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.5
            )
          ),
          child: Text(widget.title, style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GroupButton(
            isRadio: false,
            buttons: widget.data,
            options: GroupButtonOptions(
              selectedColor: Colors.indigo.shade900,
            ),
          ),
        )
      ],
    );
  }
}
