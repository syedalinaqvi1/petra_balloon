// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:petra_balloon/boarding_screen.dart';
//import 'package:petra_balloon/ticket_screen.dart';

void main() => runApp(
      const MaterialApp(
        home: Home(),
      ),
    );

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double height;
    double width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 10),
              //   child: SizedBox(
              //     height: height / 9,
              //     width: width * 0.8,
              //     child: ElevatedButton(
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const TicketScreen()),
              //         );
              //       },
              //       style: ButtonStyle(
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(36.0),
              //             side: const BorderSide(
              //               color: Color.fromRGBO(170, 4, 4, 1),
              //             ),
              //           ),
              //         ),
              //         backgroundColor: MaterialStateProperty.all(
              //           const Color.fromRGBO(170, 4, 4, 1),
              //         ),
              //       ),
              //       child: const Text(
              //         'Scan Ticket',
              //         style: TextStyle(fontSize: 20),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: height / 9,
                  width: width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PetraBallon()),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      'Scan Boarding Pass',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
