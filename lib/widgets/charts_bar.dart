import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Chartbar extends StatelessWidget {
  final String label;
  final double spending;
  final double spendingPc;

  Chartbar(this.label, this.spending, this.spendingPc);

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (btx, Constraints)
    {
 return     Column(
      children: <Widget>[
        Container(
           height: Constraints.maxHeight * 0.15,
           child: FittedBox
        (

          child: Text('\$${spending.toStringAsFixed(0)}')),),
       
        SizedBox(
          height: Constraints.maxHeight * 0.05,
        ),
        Container(
          height: Constraints.maxHeight * 0.6,
          width: 10,
          child: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 1.0),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPc,
              child: Container(
                decoration: BoxDecoration(color: Colors.amber),
              ),
            ),
          ]),
        )
      ],
    );

    },
    );
    

  }
}
