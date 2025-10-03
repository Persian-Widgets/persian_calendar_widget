import 'dart:developer';

import 'package:example/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_calendar_widget/core/data/i18n/i18n.dart';
import 'package:persian_calendar_widget/persian_calendar_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Persian Calendar Widget Demo',
      home: const MyHomePage(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('en', ''),
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
                  calendarType: CalendarType.persian,
                  onSubmit: (chosenDate, dateInText) {
                    /// when user choose date from dialog box and submit two
                    /// types of `Jalali` date returned here
                    /// Jalali [jalaliDate]: Jalali(year, month, day, hour, minute, second, millisecond)
                    /// String [dateInText]: '۱۴۰۳ اردیبهشت ۱۲'
                    setState(() {
                      selectedDate = dateInText.jalali;
                    });
                    log('jalali dateInText of pick full date: ${dateInText.jalali}');
                    log('jalali Date of pick full date: ${chosenDate.jalali}');
                    log('gregorian dateInText of pick full date: ${dateInText.gregorian}');
                    log('gregorian Date of pick full date: ${chosenDate.gregorian}');
                  },
                  showTodayBanner: true,
                  useGoToTodayButton: true,
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
                  calendarType: CalendarType.persian,
                  onSubmit: (chosenDate, dateInText) {
                    /// when user choose date from dialog box and submit two
                    /// types of `Jalali` date returned here
                    /// Jalali [jalaliDate]: Jalali(year, month, day, hour, minute, second, millisecond)
                    /// String [dateInText]: '۱۴۰۳ اردیبهشت ۱۲'
                    setState(() {
                      selectedDate = dateInText.jalali;
                    });
                    log('jalali dateInText of pick full date: ${dateInText.jalali}');
                    log('jalali Date of pick full date: ${chosenDate.jalali}');
                    log('gregorian dateInText of pick full date: ${dateInText.gregorian}');
                    log('gregorian Date of pick full date: ${chosenDate.gregorian}');
                  },
                  useGoToTodayButton: true,
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
                    calendarType: CalendarType.gregorian,
                    i18n: I18n(
                        gregorianMonths: I18nGregorianMonths(
                          january: S.current.gregorian_month_january,
                          february: S.current.gregorian_month_february,
                          march: S.current.gregorian_month_march,
                          april: S.current.gregorian_month_april,
                          may: S.current.gregorian_month_may,
                          june: S.current.gregorian_month_june,
                          july: S.current.gregorian_month_july,
                          august: S.current.gregorian_month_august,
                          september: S.current.gregorian_month_september,
                          october: S.current.gregorian_month_october,
                          november: S.current.gregorian_month_november,
                          december: S.current.gregorian_month_december,
                        ),
                        persianMonths: I18nPersianMonths(
                          farvardin: S.current.jalali_month_farvardin,
                          ordibehesht: S.current.jalali_month_ordibehesht,
                          khordad: S.current.jalali_month_khordad,
                          tir: S.current.jalali_month_tir,
                          mordad: S.current.jalali_month_mordad,
                          shahrivar: S.current.jalali_month_shahrivar,
                          mehr: S.current.jalali_month_mehr,
                          aban: S.current.jalali_month_aban,
                          azar: S.current.jalali_month_azar,
                          dey: S.current.jalali_month_dey,
                          bahman: S.current.jalali_month_bahman,
                          esfand: S.current.jalali_month_esfand,
                        )),
                    onSubmit: (chosenDate, dateInText) {
                      setState(() {
                        selectedDate = dateInText.gregorian;
                      });
                      log('jalali dateInText of pick month & day: ${dateInText.jalali}');
                      log('jalali Date of pick month & day: ${chosenDate.jalali}');
                      log('gregorian dateInText of pick month & day: ${dateInText.gregorian}');
                      log('gregorian Date of pick month & day: ${chosenDate.gregorian}');
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
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

                    /// change week days decoration
                    weekDaysBoxStyle: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border:
                          Border.all(color: Colors.cyan.shade500, width: 1.5),
                      color: Colors.cyan.shade600,
                    ),
                    weekDaysTextStyle: const TextStyle(color: Colors.white));
              },
              child: const Text('انتخاب روز و ماه')),

          /// pick day dialog box
          ElevatedButton(
              onPressed: () {
                /// open date picker widget
                /// user have access to pick day
                MinimalPersianCalendar.pickDay(
                  context: context,
                  calendarType: CalendarType.gregorian,
                  onSubmit: (chosenDate, dateInText) {
                    log('jalali dateInText of pick day: ${dateInText.jalali}');
                    log('jalali Date of pick day: ${chosenDate.jalali}');
                    log('gregorian dateInText of pick day: ${dateInText.gregorian}');
                    log('gregorian Date of pick day: ${chosenDate.gregorian}');
                  },
                  showTodayBanner: true,
                  useGoToTodayButton: true,
                );
              },
              child: const Text('انتخاب روز')),
        ],
      ),
    );
  }
}
