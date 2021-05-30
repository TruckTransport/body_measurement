import 'package:body_measurement/globalVariable.dart';
import 'package:body_measurement/resultTile.dart';
import 'package:flutter/material.dart';

class ViewData extends StatefulWidget {
  @override
  _ViewDaatState createState() => _ViewDaatState();
}

class _ViewDaatState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Take Measurement Again')),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    ResultTile(parameter: 'neck', value: neck),
                    ResultTile(parameter: 'Height', value: height),
                    ResultTile(parameter: 'weight', value: weight),
                    ResultTile(parameter: 'belly', value: belly),
                    ResultTile(parameter: 'chest', value: chest),
                    ResultTile(parameter: 'wrist', value: wrist),
                    ResultTile(parameter: 'arm Length', value: armLength),
                    ResultTile(parameter: 'thigh', value: thigh),
                    ResultTile(parameter: 'hips', value: hips),
                    ResultTile(parameter: 'ankle', value: ankle),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
