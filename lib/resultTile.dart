import 'package:flutter/material.dart';

class ResultTile extends StatelessWidget {
  final String parameter, value;

  const ResultTile({Key? key, required this.parameter, required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: Colors.black,
              )),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  parameter.toUpperCase(),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                Text(
                  value,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
