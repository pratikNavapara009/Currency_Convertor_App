import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../globals.dart';
import '../helper_class/helper.dart';
import '../model_class/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController amountcontroller = TextEditingController();
  String? countrydata;
  late Future<Currency?> getdata;
  String from = "USD";
  String to = "inr";
  int amount = 1;
  String? currency;

  @override
  void initState() {
    super.initState();
    getdata = Apihelper.apihelper.fetchData(from: "USD", to: "inr", amount: 1)
        as Future<Currency?>;
    amountcontroller.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Currency Converter"),
        actions: [
          Switch(
              inactiveThumbColor: Colors.red,
              activeColor: Colors.green,
              trackColor: MaterialStateProperty.all(Colors.black),
              value: Globals.isios,
              onChanged: (val) {
                setState(() {
                  Globals.isios = val;
                });
              })
        ],
      ),
      body: FutureBuilder(
        future: getdata,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Error:${snapshot.error}");
          } else if (snapshot.hasData) {
            Currency? data = snapshot.data;
            int amount1 = int.parse(amountcontroller.text);

            if (data != null) {
              return Center(
                child: Container(
                  height: 700,
                  width: 390,
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.blue,
                        blurRadius: 5,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      (Globals.isios == false)
                          ? const SizedBox(
                              height: 50,
                            )
                          : const SizedBox(
                              height: 1,
                            ),
                      (Globals.isios == false)
                          ? Container(
                              color: Colors.blue,
                              child: DropdownButtonFormField(
                                hint: const Text(
                                  "Select Country From",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    fillColor: Colors.grey.withOpacity(0.50),
                                    filled: true),
                                value: from,
                                iconSize: 20,
                                iconDisabledColor: Colors.black,
                                iconEnabledColor: Colors.white,
                                icon: const Icon(
                                  Icons.arrow_drop_down_sharp,
                                  size: 40,
                                ),
                                isExpanded: true,
                                dropdownColor: Colors.grey.shade300,
                                items: item
                                    .map(
                                      (e) => DropdownMenuItem(
                                        child: Text(
                                          e["Country"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 23),
                                        ),
                                        value: ("${e["from"]}"),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      from = val.toString();
                                      print(from);
                                    },
                                  );
                                },
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => Column(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            color: Colors.black26,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: CupertinoPicker(
                                            backgroundColor: Colors.white,
                                            itemExtent: 30,
                                            children: item.map((e) {
                                              return Text(
                                                e["from"],
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            }).toList(),
                                            onSelectedItemChanged: (value) {
                                              setState(() {
                                                int i = value;
                                                from =
                                                    item[i]["from"].toString();
                                                print(from);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade100),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "$from".toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 30,
                      ),
                      (Globals.isios == false)
                          ? Container(
                              color: Colors.blue,
                              child: DropdownButtonFormField(
                                hint: const Text(
                                  "Select Country",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(), filled: true),
                                value: to,
                                iconSize: 40,
                                iconDisabledColor: Colors.black,
                                iconEnabledColor: Colors.white,
                                icon: const Icon(Icons.arrow_drop_down_sharp),
                                isExpanded: true,
                                dropdownColor: Colors.grey.shade300,
                                items: item
                                    .map(
                                      (e) => DropdownMenuItem(
                                        child: Text(
                                          e["Country"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 23,
                                          ),
                                        ),
                                        value: "${e["to"]}",
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    to = val.toString();
                                    print(to);
                                  });
                                },
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => Column(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            color: Colors.black26,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: CupertinoPicker(
                                            backgroundColor: Colors.white,
                                            itemExtent: 30,
                                            children: item.map((e) {
                                              return Text(
                                                e["to"],
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            }).toList(),
                                            onSelectedItemChanged: (value) {
                                              setState(() {
                                                int i = value;
                                                to = item[i]["to"].toString();
                                                print(to);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade100),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "$to".toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter Amount ";
                          }
                        },
                        onSaved: (val) {
                          setState(() {
                            amount = int.parse(val!);
                          });
                        },
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        controller: amountcontroller,
                        decoration: InputDecoration(
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          hintText: "Enter Amount",
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          filled: true,
                          fillColor: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            getdata = Apihelper.apihelper.fetchData(
                                from: from,
                                to: to,
                                amount: amount1) as Future<Currency?>;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.black),
                          child: const Text(
                            "Calculate",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Icon(
                        Icons.arrow_downward_sharp,
                        size: 30,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$amount1",
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 190,
                            ),
                            Text(
                              "${data.from}",
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 110,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${data.result}",
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            Text(
                              "${data.to}",
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              const Center(
                child: Text("No Data Found!!!"),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
