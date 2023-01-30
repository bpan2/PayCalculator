import 'package:flutter/material.dart';

void main() {
  runApp(const PayCalculator());
}

class PayCalculator extends StatelessWidget {
  const PayCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Calculator',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Pay Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  double _numOfHours = 0;
  double _hourlyRate = 0;
  double _taxRate = 0.18;
  double _regularPay = 0;
  double _overtimePay = 0;
  double _totalPay = 0;
  double _tax = 0;

  late String numOfHours;
  late String hourlyRate;

  bool _validate_1_1 = false;
  bool _validate_1_2 = false;
  bool _validate_2_1 = false;
  bool _validate_2_2 = false;

  void calculateOutput() {
    _numOfHours = double.tryParse(numOfHours)!;
    _hourlyRate = double.tryParse(hourlyRate)!;

    if (_numOfHours <= 40) {
      _regularPay = _numOfHours * _hourlyRate;
      _totalPay = _regularPay;
    } else {
      _regularPay = 40 * _hourlyRate;
      _overtimePay = (_numOfHours - 40) * _hourlyRate * 1.5;
      _totalPay = _regularPay + _overtimePay;
    }

    _tax = _totalPay * _taxRate;

    setState(() {
      _regularPay = _regularPay;
      _overtimePay = _overtimePay;
      _totalPay = _totalPay;
      _tax = _tax;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) => setState(() {
                        numOfHours = value;
                        double.tryParse(value) != null ? _validate_1_2 = false : _validate_1_2 = true;
                      }),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Number of hours',
                        errorText: generateErrMsg(isEmptyField: _validate_1_2, isWrongDataType: _validate_1_2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) => setState(() {
                        hourlyRate = value;
                        double.tryParse(value) != null ? _validate_2_2 = false : _validate_2_2 = true;
                        //(hourlyRate.isEmpty || double.tryParse(hourlyRate) is double)? _validate_1 = true : _validate_1 = false;
                        //hourlyRate.isEmpty ? _validate_1 = true : _validate_1 = false;
                        //value is double ? _validate_2 = true : _validate_2 = false;
                      }),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Hourly rate',
                        errorText: generateErrMsg(isEmptyField: _validate_2_1, isWrongDataType: _validate_2_2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            OutlinedButton(

              style: OutlinedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                backgroundColor: Colors.cyan,
                shape: const StadiumBorder(),
                side: const BorderSide(width: 2, color: Colors.blueGrey),
              ),
              onPressed: () {
                debugPrint('Received click');
                calculateOutput();
                _buildCalculationOutput();
              },
              child: const Text('Calculate'),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Text(
                        "Report",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Regular Pay: $_regularPay",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Overtime Pay: $_overtimePay",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Total Pay: $_totalPay",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Tax: $_tax",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildAboutSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculationOutput() {
    return   Expanded(
        child: Card(
          //margin: EdgeInsets.all(8.0),
          //child: Container(
            color: Colors.white70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                Container(
                  child: Text(
                    "Report",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Regular Pay: $_regularPay",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Overtime Pay: $_overtimePay",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Total Pay: $_totalPay",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Tax: $_tax",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            //),
          ),
        )
    );
  }

  Widget _buildAboutSection() {
    return Card(
      color: Colors.cyan,
      elevation: 5,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: const SizedBox(
        child: const ListTile(
          leading: Icon(Icons.person_2_outlined),
          title: Text('Bing Pan'),
          subtitle: Text('301317241'),
        ),
      ),
    );
  }

  generateErrMsg( {required bool isEmptyField, required bool isWrongDataType}) {
    String errMsg = "";
    if (isEmptyField){ errMsg += "This field can not be empty";}
    else if (isWrongDataType){ errMsg += "Please enter a number";}
    else errMsg = "";

    return errMsg;
  }

/* Widget _buildCalculationOutput() {
    return Card(
        child: Column(
          children: <Widget>[
            Card(
                color: Colors.white70,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 8, //or null
                    decoration: InputDecoration.collapsed(
                        hintText: "Enter your text here"),
                  ),
                )
            )
          ],
        )
    );
  }

  class CalculateButtonWidget extends StatelessWidget {
  const CalculateButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
        backgroundColor: Colors.cyan,
        shape: const StadiumBorder(),
        side: const BorderSide(width: 5, color: Colors.redAccent),
      ),
      onPressed: () {
        debugPrint('Received click');
      },
      child: const Text('Calculate'),
    );
  }
}


/*Widget _buildInputFieldSection() {
    return Card(
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Number of hours',
              ),

            ),
          ),


          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Hourly rate',
              ),
            ),
          ),
        ],
      ),
    );
  }
  */
*/
}
