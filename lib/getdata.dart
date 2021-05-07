import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dropdown_output.dart';

class GetData extends StatefulWidget {
  @override
  _GetDataState createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  var fireStoreDB = FirebaseFirestore.instance
      .collection('Donation')
      .where('blood_group', isEqualTo: SelectedValueOutput);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: fireStoreDB.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Center(child: Text('Error'));
            if (snapshot.hasData == false)
              return Center(
                child: Text(
                  'There is no Donor for blood group $SelectedValueOutput',
                  style: TextStyle(fontSize: 32),
                ),
              );
            final messages = snapshot.data!.docs;
            List<Data> widgets = [];
            for (var message in messages) {
              final name = (message.data() as Map)['name'].toString();
              final bloodGroup =
                  (message.data() as Map)['blood_group'].toString();
              final recoveredDate =
                  (message.data() as Map)['recovered_date'].toString();
              final recoveredMonth =
                  (message.data() as Map)['recovered_month'].toString();
              final recoveredYear =
                  (message.data() as Map)['recovered_year'].toString();
              final number = (message.data() as Map)['number'].toString();
              final widget = Data(
                name: name,
                bloodGroup: bloodGroup,
                number: number,
                recoveredDate: recoveredDate,
                recoveredMonth: recoveredMonth,
                recoveredYear: recoveredYear,
              );
              widgets.add(widget);
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView(
                      children: widgets,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class Data extends StatelessWidget {
  final String recoveredDate;
  final String recoveredMonth;
  final String recoveredYear;
  final String number;
  final String name;
  final String bloodGroup;

  Data(
      {required this.name,
      required this.bloodGroup,
      required this.recoveredDate,
      required this.recoveredMonth,
      required this.recoveredYear,
      required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => contactDetails(name, bloodGroup,
                  recoveredDate, recoveredMonth, recoveredYear, number),
            ),
          );
        },
        child: Material(
          borderRadius: BorderRadius.circular(25),
          color: Colors.grey,
          elevation: 15,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$name',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Card(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$bloodGroup',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

contactDetails(name, bloodGroup, date, month, year, number) {
  return Material(
    color: Colors.blueGrey,
    child: FractionallySizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Donor Name: $name', style: TextStyle(fontSize: 20),),
          )),
          Card(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Phone: $number', style: TextStyle(fontSize: 20),),
          )),
          Card(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Recovered Date: $date / $month / $year', style: TextStyle(fontSize: 20),),
          )),
          Card(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Blood Group: $bloodGroup', style: TextStyle(fontSize: 20),),
          )),
        ],
      ),
    ),
  );
}
