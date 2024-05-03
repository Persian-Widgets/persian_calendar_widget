import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/persian_calendar_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Persian Calendar Widget Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedDate = 'تاریخی انتخاب نشده است';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(
            height: 150,
          ),
          Center(
              child: Text(
            selectedDate,
            style: Theme.of(context).textTheme.headlineMedium,
            textDirection: TextDirection.rtl,
          )),
          const SizedBox(
            height: 80,
          ),

          /// pickFullDate dialog box
          ElevatedButton(
              onPressed: () {
                /// open date picker widget
                /// user have access to pick day, month and year
                MinimalPersianCalendar.pickFullDate(
                  context: context,
                  background: Colors.cyan.shade100,
                  primaryColor: Colors.cyan.shade700,
                  onPrimaryColor: Colors.cyan.shade50,
                  onSubmit: (jalaliDate, dateInText) {
                    /// when user choose date from dialog box and submit two
                    /// types of `Jalali` date returned here
                    /// Jalali [jalaliDate]: Jalali(year, month, day, hour, minute, second, millisecond)
                    /// String [dateInText]: '۱۴۰۳ اردیبهشت ۱۲'
                    setState(() {
                      selectedDate = dateInText;
                    });
                    log('dateInText of pick full date: $dateInText');
                    log('jalaliDate of pick full date: $jalaliDate');
                  },
                );
              },
              child: const Text('انتخاب روز ماه و سال')),

          /// pick month and day dialog box
          ElevatedButton(
              onPressed: () {
                /// open date picker widget
                /// user have access to pick day and month
                MinimalPersianCalendar.pickMonthAndDay(
                  context: context,
                  onSubmit: (jalaliDate, dateInText) {
                    log('dateInText of pick month & day: $dateInText');
                    log('jalaliDate of pick month & day: $jalaliDate');
                  },
                );
              },
              child: const Text('انتخاب روز و ماه')),

          /// pick day dialog box
          ElevatedButton(
              onPressed: () {
                /// open date picker widget
                /// user have access to pick day
                MinimalPersianCalendar.pickDay(
                  context: context,
                  onSubmit: (jalaliDate, dateInText) {
                    log('dateInText of pick day: $dateInText');
                    log('jalaliDate of pick day: $jalaliDate');
                  },
                );
              },
              child: const Text('انتخاب روز')),
        ],
      ),
    );
  }
}
