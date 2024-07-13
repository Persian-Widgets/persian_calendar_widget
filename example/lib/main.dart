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
            selectedDate.toPersianDigit(),
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

          /// pickYearAndMonth dialog box
          ElevatedButton(
              onPressed: () {
                /// open date picker widget
                /// user have access to pick day, month and year
                MinimalPersianCalendar.pickYearAndMonth(
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
              child: const Text('تغییر ماه و سال')),

          /// pick month and day dialog box
          ElevatedButton(
              onPressed: () {
                /// open date picker widget
                /// user have access to pick day and month
                CustomDecorationPersianCalendar.pickMonthAndDay(
                  context: context,
                  onSubmit: (jalaliDate, dateInText) {
                    setState(() {
                      selectedDate = dateInText;
                    });
                    log('dateInText of pick month & day: $dateInText');
                    log('jalaliDate of pick month & day: $jalaliDate');
                  },
                  background: Colors.cyan.shade50,

                  /// change cancel button decoration
                  cancelTitle: 'لغو',
                  cancelButtonStyle: TextButton.styleFrom(),
                  cancelTextStyle: TextStyle(color: Colors.cyan.shade700),

                  /// change submit button decoration
                  submitTitle: 'ثبت',
                  submitButtonStyle: ElevatedButton.styleFrom(
                    elevation: 10,
                    shadowColor: Colors.cyan.shade400,
                    backgroundColor: Colors.cyan.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  submitTextStyle: TextStyle(color: Colors.cyan.shade100),

                  /// change date button decoration
                  dateButtonStyle: TextButton.styleFrom(),
                  dateSelectedButtonStyle: TextButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.cyan.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  dateTextStyle: TextStyle(
                    color: Colors.cyan.shade700,
                  ),
                  dateSelectedTextStyle: const TextStyle(
                    color: Colors.white54,
                  ),

                  /// change title decoration
                  titleBoxStyle: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border:
                          Border.all(color: Colors.cyan.shade500, width: 1.5),
                      color: Colors.cyan.shade600,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.cyan.shade500,
                            offset: Offset.zero,
                            blurRadius: 25)
                      ]),
                  titleButtonStyle: TextButton.styleFrom(),
                  titleSelectedButtonStyle: TextButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.cyan.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  titleSelectedTextStyle: const TextStyle(
                    color: Colors.white54,
                  ),
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
