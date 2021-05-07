import 'package:flutter/material.dart';

String? dropdownValues = 'Select Group';
String? SelectedValue = '';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: DropdownButton<String>(
            dropdownColor: Colors.blueGrey,
            value: dropdownValues,
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.grey,
            ),
            onChanged: (String? newValues) {
              setState(() {
                dropdownValues = newValues!;
                SelectedValue = newValues;
                print(SelectedValue);
              });
            },
            items: <String>['Select Group','A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

