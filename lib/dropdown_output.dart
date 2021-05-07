import 'package:flutter/material.dart';
import 'alerts.dart';

String? dropdownValuesOutput = 'Select Group';
String? SelectedValueOutput = '';

class DropDownOutput extends StatefulWidget {
  @override
  _DropDownOutputState createState() => _DropDownOutputState();
}

class _DropDownOutputState extends State<DropDownOutput> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: DropdownButton<String>(
            value: dropdownValuesOutput,
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.grey,
            ),
            onChanged: (String? newValues) {
              setState(() {
                SelectedValueOutput = newValues;
                dropdownValuesOutput = newValues;
                checker(context, dropdownValuesOutput);
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

void checker(BuildContext context, String? dropdownValuesOutput) {
  if (SelectedValueOutput == 'Select Group'){
    ErrorAlert(context, 'Select a blood group', 'Without a selected blood group donors data cannot be shown');
  }
}

