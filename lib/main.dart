import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Interest Calculator",
      home: interestCalculator(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
    ));

class interestCalculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _interestCalculatorState();
  }
}

class _interestCalculatorState extends State<interestCalculator> {
  final _formKey = GlobalKey<FormState>();

  final _minimumMargin = 5.0;
  var _currencies = ["Taka", "Dollar", "Rupe"];
  var _currentItemSelected = "";

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController totalAmount = TextEditingController();
  TextEditingController interestRate = TextEditingController();
  TextEditingController ternInYear = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.body1;

    // TODO: implement build
    return Willp
      Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Interest Calculator"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(_minimumMargin),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      controller: totalAmount,
                      validator: (String value){
                        if(value.isEmpty){
                          return "Amount can't be Empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Enter Amount",
                          hintText: "Enter Your Amount e.g. 23000 tk",
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(_minimumMargin))),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      controller: interestRate,
                      validator: (String value){
                        if(value.isEmpty){
                          return "Interest Rate can't be Empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Interest Rate",
                          hintText: "Enter Rate of interest(In Percent)",
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(_minimumMargin))),
                    )),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      controller: ternInYear,
                      validator: (String value){
                        if(value.isEmpty){
                          return "Term can't be Empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Term",
                          hintText: "Term in Years)",
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(_minimumMargin))),
                    )),
                    Container(
                      width: _minimumMargin * 10,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentItemSelected,
                        style: textStyle,
                        onChanged: (String newValueSelected) {
                          _onDropDownItemSelected(newValueSelected);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text(
                        "Calculate",
                        textScaleFactor: 1.2,
                      ),
                      onPressed: () {
                        setState(() {
                          if(_formKey.currentState.validate()){
                            this.displayResult = calculationTotalAmountWithInterest();
                          }
                        });
                      },
                    )),
                    Container(
                      width: _minimumMargin * 2,
                    ),
                    Expanded(
                        child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        "Reset",
                        textScaleFactor: 1.2,
                      ),
                      onPressed: () {
                        setState(() {
                          resetButton();
                        });
                      },
                    ))
                  ],
                ),
                Container(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.all(_minimumMargin * 2),
                  child: Text(
                    "Result = " + this.displayResult,
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  Widget getImageAsset() {
    return Center(
        child: Container(
      child: Image(
        image: AssetImage("images/taka.png"),
        width: 125.0,
        height: 125.0,
      ),
      margin: EdgeInsets.all(_minimumMargin),
    ));
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String calculationTotalAmountWithInterest() {
    double amount = double.parse(totalAmount.text);
    double rate = double.parse(interestRate.text);
    double years = double.parse(ternInYear.text);

    double totalAmountWithInterest = amount + (amount * rate * years) / 100;
    String value =
        "After $years Years, Your investment will be $totalAmountWithInterest $_currentItemSelected";
    return value;
  }

  void resetButton() {
    totalAmount.text = "";
    interestRate.text = "";
    ternInYear.text = "";
    displayResult = "";
    _currentItemSelected = _currencies[0];
  }
}
