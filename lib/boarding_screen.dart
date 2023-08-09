import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:petra_balloon/modals/ticket.dart';

class PetraBallon extends StatefulWidget {
  const PetraBallon({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PetraBallonState createState() => _PetraBallonState();
}

class _PetraBallonState extends State<PetraBallon> {
  String _scanQrcode =
      '{"selected_pass":"NA","ticketNumber": 123456789, "Passenger": "adult", "Date": "2023-07-14"}';

  bool _success = false;
  String _successTest = 'NA';

  final dio = Dio();

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String qrCodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      qrCodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      qrCodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    if (!mounted) return;

    setState(() {
      _scanQrcode = qrCodeScanRes;
    });
  }

  Future<void> sendPostRequest() async {
    try {
      Response response = await dio.post(
        'https://api.petraballoon.com/api/ticket/boarding-scanner', // Replace with your endpoint URL
        data: {
          'data': _scanQrcode,
        }, // Replace with your request body
      );
      // Handle the response

      if (response.statusCode == 200) {
        setState(() {
          _success = true;
          _successTest = 'Approved';
        });
      } else if (response.statusCode == 201) {
        setState(() {
          _success = false;
          _successTest = 'Declined';
        });
      }
    } catch (error) {
      // Handle any errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Petra Ballon'),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(170, 4, 4, 1),
        ),
        body: Builder(
          builder: (BuildContext context) {
            String jsonString = _scanQrcode;
            Map<String, dynamic> json = jsonDecode(jsonString);
            Ticket ticket = Ticket.fromJson(json);

            String selectedPass = ticket.selectedPass;
            String ticketNumber = ticket.ticketNumber.toString();
            String passenger = ticket.passenger;
            String date = ticket.date;

            double height;
            double width;
            height = MediaQuery.of(context).size.height;
            width = MediaQuery.of(context).size.width;

            return Container(
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: height / 3,
                      width: width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(170, 4, 4, 1),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Boarding Informattion:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selected Pass : $selectedPass',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Boarding Number : $ticketNumber',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Passenger : $passenger',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Date : $date',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: height / 5,
                      width: width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(170, 4, 4, 1),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Boarding Status',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          _success
                              ? Text(
                                  _successTest,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  _successTest,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: height / 9,
                      width: width * 0.8,
                      child: ElevatedButton(
                        onPressed: () => scanQR(),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36.0),
                              side: const BorderSide(
                                color: Color.fromRGBO(170, 4, 4, 1),
                              ),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(170, 4, 4, 1),
                          ),
                        ),
                        child: const Text(
                          'Start QR scan',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      height: height / 9,
                      width: width * 0.8,
                      child: ElevatedButton(
                        onPressed: () => sendPostRequest(),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36.0),
                              side: const BorderSide(
                                color: Color.fromRGBO(170, 4, 4, 1),
                              ),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(170, 4, 4, 1),
                          ),
                        ),
                        child: const Text(
                          'Check Status',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
