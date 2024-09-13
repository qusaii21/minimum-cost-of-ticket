import 'package:flutter/material.dart';

// lib imports
import 'package:ads_course_project_minimum_cost_of_ticket/pages/path.dart';
import 'package:ads_course_project_minimum_cost_of_ticket/services/globalVariables.dart' as global;
import 'package:ads_course_project_minimum_cost_of_ticket/widgets/datepicker.dart';
import 'package:ads_course_project_minimum_cost_of_ticket/services/minimumCostOfTicket.dart';

// google fonts imports
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // minimum cost of ticket instance
  MinimumCost minimumCost = MinimumCost();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // START: Background image
        Image.asset(
          'assets/background.png',
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        // END: Background image
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 50),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // START: Date picker
                    const WidgetsDatePicker(),
                    // END: Date picker
                    // START: cost of passes text filed
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          width: 3,
                          color: Colors.black,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 30),
                        child: Column(
                          children: [
                            Text(
                              "Cost of different passes:",
                              style: GoogleFonts.ubuntu(
                                fontSize: MediaQuery.of(context).size.height / 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: global.daily,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(hintText: "1 day"),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width / 20),
                                  Expanded(
                                    child: TextFormField(
                                      controller: global.weekly,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(hintText: "7 day"),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width / 20),
                                  Expanded(
                                    child: TextFormField(
                                      controller: global.monthly,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(hintText: "30 day"),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // END: cost of passes text filed
                    // START: Cancel calculate buttons
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              width: 3,
                              color: Colors.black,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              global.onCancel();
                              print('days: ${global.days}');
                              print('costs: ${global.costs}');
                            },
                            child: Text(
                              "clear",
                              style: GoogleFonts.ubuntu(
                                fontSize: MediaQuery.of(context).size.height / 40,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              width: 3,
                              color: Colors.black,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              global.costs.add(int.parse(global.daily.text.toString()));
                              global.costs.add(int.parse(global.weekly.text.toString()));
                              global.costs.add(int.parse(global.monthly.text.toString()));
                              global.onSubmit();
                              print('days: ${global.days}');
                              print('costs: ${global.costs}');
                              minimumCost.minCostTickets(global.days, global.costs);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return const Path();
                              }));
                            },
                            child: Text(
                              "calculate",
                              style: GoogleFonts.ubuntu(
                                fontSize: MediaQuery.of(context).size.height / 40,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // END: Cancel calculate buttons
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
