import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

class Transactionlist extends StatelessWidget {
  final List<Trascation> dtransction;
  final Function deletetx;

  Transactionlist(this.dtransction, this.deletetx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: dtransction.isEmpty
          ? LayoutBuilder(builder: (btx, Constraints){
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Container(
                    
                    child: Image.asset(
                      'assets/images/Daco_4534211.png',
                      width: 200.0,
                      height: 100.0,
                    )),
              ],
            );
          }) 
          : ListView.builder(
              itemBuilder: (ctx, index) {

                return 
                Card( 
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: 
                  ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FittedBox(
                          child: Text('\$${dtransction[index].amount}')),
                    ),
                  ),
                  title: Text
                  (
                    dtransction[index].title,
                  
                          style:  TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            color: Colors.purple,
                           
                  ), 
                  
                  ),
                 subtitle: Text(
                          DateFormat('yMMMMd').format(dtransction[index].date),
                          style: TextStyle(color: Colors.grey), 
                          ),
                    trailing: IconButton(icon: Icon(Icons.delete),
                    color: Colors.amber,
                    onPressed: () => deletetx(dtransction[index].id)),
                ));

            
                // Card(
                //     child: Row( 
                //   children: <Widget>[
                //     Container(
                //       margin: const EdgeInsets.symmetric(
                //         vertical: 10,
                //         horizontal: 20,
                //       ),
                //       decoration: BoxDecoration(
                //           border: Border.all(
                //         color: Colors.amber,
                //         width: 2,
                //       )),
                //       padding: const EdgeInsets.all(10),
                //       child: Text(
                //         '\$-${dtransction[index].amount.toStringAsFixed(2)}',
                //         style: const TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 20,
                //           color: Colors.teal,
                //         ),
                //       ),
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: <Widget>[
                //         Text(
                //           dtransction[index].title,
                //           style: const TextStyle(
                //             fontWeight: FontWeight.w600,
                //             fontSize: 25,
                //             color: Colors.teal,
                //           ),
                //         ),
                //         Text(
                //           DateFormat('yMMMMd').format(dtransction[index].date),
                //           style: TextStyle(color: Colors.grey),
                //         ),
                //       ],
                //     )
                //   ],
                // ),
                // );
              },
              itemCount: dtransction.length,
            ),
    );
  }
}
