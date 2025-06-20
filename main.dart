import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String height = "";
  String weight = "";
  final _formkey = GlobalKey<FormState>();

  bool _submitInput() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              color: Colors.white70,
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "BMI CALCULATOR",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 20,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Height (in M)"),
                          hintText: "Height (in M)",
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (newValue) {
                          height = newValue!;
                        },
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Enter a valid number";
                          } else if (double.parse(value) == 0) {
                            return "Enter number other than 0";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 20,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Weight (in kg)"),
                          hintText: "Weight (in kg)",
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (newValue) {
                          weight = newValue!;
                        },
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Enter a valid number";
                          } else if (double.parse(value) == 0) {
                            return "Enter number other than 0";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              if (_submitInput()) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(child: Text(calcualteBMI(weight, height))),
                      content: Text(
                        "Your weight Class is ${calcualteWegithClass(calcualteBMI(weight, height))} ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                );
              }
            },
            child: Text("calculate"),
          ),
        ],
      ),
    );
  }
}

String calcualteBMI(String weight, String height) {
  var w = double.parse(weight);
  var h = double.parse(height);

  var bmi = w / (h * h);
  return bmi.toStringAsFixed(2);
}

String calcualteWegithClass(String bmi) {
  var b = double.parse(bmi);
  if (b < 16) {
    return "Sever Thinness";
  } else if (b <= 17 && b > 16) {
    return "Moderate Thinness";
  } else if (b <= 18.5 && b > 17) {
    return "Mild Thinness";
  } else if (b <= 25 && b > 18.5) {
    return "Normal";
  } else if (b <= 30 && b > 25) {
    return "Overweight";
  } else if (b <= 35 && b > 30) {
    return "Obese class I ";
  } else if (b <= 40 && b > 35) {
    return "Obese class II";
  } else {
    return "Obese class III";
  }
}
