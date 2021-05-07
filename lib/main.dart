import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'dropdown_output.dart';
import 'getdata.dart';
import 'dropdown_input.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'alerts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PlasmaDonation());
}


final users = FirebaseFirestore.instance.collection('Donation');
// ignore: non_constant_identifier_names
String _name_controller = '';
// ignore: non_constant_identifier_names
int _number_controller = 0;
// ignore: non_constant_identifier_names
String _email_controller = '';
// ignore: non_constant_identifier_names



class PlasmaDonation extends StatefulWidget {
  @override
  _PlasmaDonationState createState() => _PlasmaDonationState();
}

void showTopSnackBar(
    BuildContext context,
    String message,
    Color color,
    ) =>
    showSimpleNotification(
      Text('Internet Connectivity Update'),
      subtitle: Text(message),
      background: color,
    );


request(snapshot){
  return MaterialApp(
    home: Scaffold(
      body: ListView(
        children: snapshot.data.docs.map((document) {
          return Container(
            child: Center(child: Text(document['blood_group'])),
          );
        }).toList(),
      ),
    ),
  );
}


void showSnackBar(BuildContext context, bool result) {
  String message = '';
  MaterialColor color;
  if (result == true){
    message = "you have internet";
    color = Colors.green;
    showTopSnackBar(context, message, color);
  } else if(result == false) {
    message = "you are not connected to the internet";
    color = Colors.red;
    showTopSnackBar(context, message, color);
  }

}

Future<void> addDatabase(BuildContext context) async{
  if(_email_controller.isEmpty || _name_controller.isEmpty || _number_controller == null || dropdownValues == 'Select Group' || _date == null || _month == null || _year == null){
    ErrorAlert(context, 'Enter Details', 'All Details must be entered before saving');
  }
  else{
    await users.add
      ({
      'email': _email_controller,
      'name': _name_controller,
      'number': _number_controller,
      'blood_group': SelectedValue,
      'recovered_date': _date,
      'recovered_month': _month,
      'recovered_year': _year,
    });
    SuccessAlert(context, _name_controller);
  }
}

dateSort(String? value){
  _selectedDate = value;
  splitting = _selectedDate!.split('-');
  _year = int.parse(splitting[0]);
  _month = int.parse(splitting[1]);
  _date = int.parse(splitting[2]);
  print(_year);
  print(_month);
  print(_date);
}


String? _selectedDate = '';
List<String> splitting = [];
int _year = 0;
int _month = 0;
int _date = 0;
int testVar = 0;
class _PlasmaDonationState extends State<PlasmaDonation> {

  Future<void> check(context) async {
    bool result = await DataConnectionChecker().hasConnection;
    if(result == true) {
      null;
    } else {
      showSnackBar(context, result);
      print('No internet :( Reason:');
      print(DataConnectionChecker().lastTryResults);
    }
  }

  @override
  Widget build(BuildContext context) {

    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.lightGreen,
        ),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text('Plasma Donation',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),
              centerTitle: true,
              bottom: TabBar(
                indicatorColor: Colors.black26,
                tabs: [
                  Padding(padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
                    child: Text("Donate Plasma", style: TextStyle(fontSize: 20)),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
                    child: Text("Search Plasma", style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
            body: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Donation').snapshots(),
                builder: (context, snapshot) {
                  return Builder(
                      builder: (context) {
                        return TabBarView(
                          children: [
                            //first page
                            ListView(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 30, 20, 30),
                                      child: TextField(
                                        keyboardType: TextInputType.name,
                                        onChanged: (value){
                                          _name_controller = value;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Your Name"
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 30, 20, 30),
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        onChanged: (value){
                                          _number_controller = int.parse(value);
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Your Number"
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 30, 20, 30),
                                      child: TextField(
                                        keyboardType: TextInputType.emailAddress,
                                        onChanged: (value){
                                          _email_controller = value;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Your Email Address"
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 30, 20, 30),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Text('Choose your Blood Group',),
                                            DropDown(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 30, 20, 30),
                                      child: DateTimePicker(
                                        initialValue:
                                        '', // initialValue or controller.text can be null, empty or a DateTime string otherwise it will throw an error.
                                        type: DateTimePickerType.date,
                                        dateLabelText: 'Select Date',
                                        firstDate: DateTime(1995),
                                        lastDate: DateTime.now().add(Duration(
                                            days: 365)), // This will add one year from current date
                                        validator: (value) {
                                          return null;
                                        },
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            setState(() {
                                              dateSort(value);
                                            });
                                          }
                                        },
                                        onSaved: (value){
                                          dateSort(value);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 30, 20, 30),
                                      child: Flex(
                                        direction: Axis.horizontal,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: ()  {
                                                setState(() {
                                                  addDatabase(context);
                                                });
                                              },
                                              child: Text('Submit'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            //second page
                            ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text('Choose your Blood Group'),
                                        DropDownOutput(),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => GetData())
                                              );
                                            });
                                          },
                                          child: Text('Get Info'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
}