import 'dart:async';
import 'dart:io';
import 'balancecard.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expence_manager/properties.dart';
import 'package:expence_manager/Pages/transation.dart';
import 'package:expence_manager/API_Management/googlesheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _txtcntrlAMOUNT = TextEditingController();
  final _txtcntrlITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  void _enterTransaction() {
    GoogleSheetsApi.insert(
        _txtcntrlITEM.text, _txtcntrlAMOUNT.text, _isIncome, "=ROW()-1");
    setState(() {});
  }

  void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                title: const Text('New Transaction'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isIncome = true;
                              });
                            },
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  boxShadow: _isIncome == false
                                      ? null
                                      : [
                                          //bottom right
                                          BoxShadow(
                                              color: Colors.grey.shade500,
                                              blurRadius: 15,
                                              offset: const Offset(5, 5)),

                                          //top left
                                          const BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              blurRadius: 15,
                                              offset: Offset(-5, -5))
                                        ],
                                  borderRadius: BorderRadius.circular(8),
                                  color: _isIncome
                                      ? Colors.green
                                      : const Color.fromARGB(25, 158, 158, 158),
                                ),
                                child: const Text(
                                  'Income',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isIncome = false;
                              });
                            },
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  boxShadow: _isIncome == true
                                      ? null
                                      : [
                                          //bottom right
                                          BoxShadow(
                                              color: Colors.grey.shade500,
                                              blurRadius: 15,
                                              offset: const Offset(5, 5)),

                                          //top left
                                          const BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              blurRadius: 15,
                                              offset: Offset(-5, -5))
                                        ],
                                  borderRadius: BorderRadius.circular(8),
                                  color: _isIncome == false
                                      ? Colors.red
                                      : const Color.fromARGB(25, 158, 158, 158),
                                ),
                                child: const Text(
                                  'Expence',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        padding: const EdgeInsets.only(left: 25, bottom: 3),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: _isIncome == false
                                    ? const Color.fromARGB(255, 255, 0, 157)
                                    : const Color.fromARGB(255, 0, 255, 8)),
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Name of tx',
                                ),
                                controller: _txtcntrlITEM,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                padding:
                                    const EdgeInsets.only(left: 25, bottom: 3),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: _isIncome == false
                                            ? const Color.fromARGB(
                                                255, 255, 0, 157)
                                            : const Color.fromARGB(
                                                255, 0, 255, 8)),
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(30)),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Amount',
                                  ),
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Enter an amount';
                                    }
                                    return null;
                                  },
                                  controller: _txtcntrlAMOUNT,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  MaterialButton(
                    // color: Colors.grey[600],
                    child: const Text('Cancel',
                        style: TextStyle(
                          color: Color.fromARGB(255, 29, 17, 96),
                        )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    color: const Color.fromARGB(255, 29, 17, 96),
                    child:
                        const Text('Ok', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _enterTransaction();
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              );
            },
          );
        });
  }

  bool timerHasStarted = false;

  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {
          timer.cancel();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: const Text(
            'Expence Tracker',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            BalanceCard(
              balance:
                  "₹  ${(GoogleSheetsApi.calculateIncome() - GoogleSheetsApi.calculateExpense()).toString()}/-",
            ),
            const ConstHeight(height: 10),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(boxShadow: [
                      //bottom right
                      BoxShadow(
                          color: Colors.grey.shade500,
                          blurRadius: 15,
                          // spreadRadius: 1,
                          offset: const Offset(5, 5)),

                      //top left
                      const BoxShadow(
                          color: Colors.white,
                          blurRadius: 15,
                          // spreadRadius: 1,
                          offset: Offset(-5, -5))
                    ], color: Colors.grey[300], shape: BoxShape.circle),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Total"),
                        const Text("Income"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "₹  ${GoogleSheetsApi.calculateIncome()}/-",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(boxShadow: [
                      //bottom right
                      BoxShadow(
                          color: Colors.grey.shade500,
                          blurRadius: 15,
                          // spreadRadius: 1,
                          offset: const Offset(5, 5)),

                      //top left
                      const BoxShadow(
                          color: Colors.white,
                          blurRadius: 15,
                          // spreadRadius: 1,
                          offset: Offset(-5, -5))
                    ], color: Colors.grey[300], shape: BoxShape.circle),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Total"),
                        const Text("Expenditure"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "₹  ${GoogleSheetsApi.calculateExpense()}/-",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const ConstHeight(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 12, right: 12),
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 0.3,
              color: Colors.black,
            ),
            Expanded(
              flex: 3,
              child: GoogleSheetsApi.loading == true
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: GoogleSheetsApi.currentTransactions.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          background: CustomBG(),
                          key: Key(GoogleSheetsApi.currentTransactions[index]
                              .toString()),
                          onDismissed: (direction) {
                            GoogleSheetsApi.deleteRow(index + 2);

                            setState(() {
                              GoogleSheetsApi.currentTransactions
                                  .removeAt(index);
                            });
                          },
                          child: Txwidget(
                            txname: GoogleSheetsApi.currentTransactions[index]
                                [0],
                            money: GoogleSheetsApi.currentTransactions[index]
                                [1],
                            incomeorexpence:
                                GoogleSheetsApi.currentTransactions[index][2],
                          ),
                        );
                      }),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _newTransaction(),
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    _launchURL(
                        "https://docs.google.com/spreadsheets/d/1e9AD9-3Iz3Toad5bEn3nvrOWtDH203Ejw7tnNpQMyQ8/edit#gid=0");
                  },
                  child: Text("Export"))),
        ));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "could nt";
    }
  }
}

//  "https://docs.google.com/spreadsheets/d/1e9AD9-3Iz3Toad5bEn3nvrOWtDH203Ejw7tnNpQMyQ8/edit#gid=0";
