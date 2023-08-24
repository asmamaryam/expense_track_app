// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transction.dart';
import './widgets/transaction.dart';
import './widgets/charts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          fontFamily: 'OpenSans',
          appBarTheme: AppBarTheme(
            // textTheme:   ThemeData.light().textTheme.copyWith(
            //   titleLarge: TextStyle(
            //     fontFamily: 'OpenSans',

            //     ),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
              fontSize: 20,
            ),
          ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)
              .copyWith(secondary: Colors.purple)),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late String titleinput;
  // final titleController = TextEditingController();

  // final amountController =TextEditingController();

  final List<Trascation> _usertransction = [
    // Trascation(
    //   id: '1',
    //   title: 'Shirt',
    //   amount: 55.55,
    //   date: DateTime.now(),
    // ),
    // Trascation(
    //   id: '2',
    //   title: 'Shoe',
    //   amount: 77.55,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showchart = false;

  List<Trascation>? get _recentTransactions {
    return _usertransction.where((tx) {
      assert(tx != null);
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransction(String txtitle, double txamount, DateTime chosendate) {
    final newtx = Trascation(
      title: txtitle,
      amount: txamount,
      date: chosendate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _usertransction.add(newtx);
    });
  }

  void _delTransaction(String id) {
    setState(() {
      _usertransction.removeWhere((element) => element.id == id);
    });
  }

  void _startaddnewTransaction(BuildContext stx) {
    showModalBottomSheet(
      context: stx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Newtransction(_addNewTransction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startaddnewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
      backgroundColor: Theme.of(context).primaryColor,
    );
    final txlistwidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: Transactionlist(_usertransction, _delTransaction));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (islandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch.adaptive(
                      value: _showchart,
                      onChanged: (val) {
                        setState(() {
                          _showchart = val;
                        });
                      })
                ],
              ),
            if (!islandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Charts(_recentTransactions!),
              ),
            if (!islandscape) txlistwidget,
            if (islandscape)
              _showchart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Charts(_recentTransactions!),
                    )
                  : txlistwidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(Icons.add),
        onPressed: () => _startaddnewTransaction(context),
      ),
    );
  }
}
