// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Cancel`
  String get button_cancel {
    return Intl.message('Cancel', name: 'button_cancel', desc: '', args: []);
  }

  /// `Submit`
  String get button_submit {
    return Intl.message('Submit', name: 'button_submit', desc: '', args: []);
  }

  /// `sa`
  String get week_day_sat {
    return Intl.message('sa', name: 'week_day_sat', desc: '', args: []);
  }

  /// `su`
  String get week_day_sun {
    return Intl.message('su', name: 'week_day_sun', desc: '', args: []);
  }

  /// `mo`
  String get week_day_mon {
    return Intl.message('mo', name: 'week_day_mon', desc: '', args: []);
  }

  /// `tu`
  String get week_day_tue {
    return Intl.message('tu', name: 'week_day_tue', desc: '', args: []);
  }

  /// `we`
  String get week_day_wed {
    return Intl.message('we', name: 'week_day_wed', desc: '', args: []);
  }

  /// `th`
  String get week_day_thu {
    return Intl.message('th', name: 'week_day_thu', desc: '', args: []);
  }

  /// `fr`
  String get week_day_fri {
    return Intl.message('fr', name: 'week_day_fri', desc: '', args: []);
  }

  /// `January`
  String get gregorian_month_january {
    return Intl.message(
      'January',
      name: 'gregorian_month_january',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get gregorian_month_february {
    return Intl.message(
      'February',
      name: 'gregorian_month_february',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get gregorian_month_march {
    return Intl.message(
      'March',
      name: 'gregorian_month_march',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get gregorian_month_april {
    return Intl.message(
      'April',
      name: 'gregorian_month_april',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get gregorian_month_may {
    return Intl.message('May', name: 'gregorian_month_may', desc: '', args: []);
  }

  /// `June`
  String get gregorian_month_june {
    return Intl.message(
      'June',
      name: 'gregorian_month_june',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get gregorian_month_july {
    return Intl.message(
      'July',
      name: 'gregorian_month_july',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get gregorian_month_august {
    return Intl.message(
      'August',
      name: 'gregorian_month_august',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get gregorian_month_september {
    return Intl.message(
      'September',
      name: 'gregorian_month_september',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get gregorian_month_october {
    return Intl.message(
      'October',
      name: 'gregorian_month_october',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get gregorian_month_november {
    return Intl.message(
      'November',
      name: 'gregorian_month_november',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get gregorian_month_december {
    return Intl.message(
      'December',
      name: 'gregorian_month_december',
      desc: '',
      args: [],
    );
  }

  /// `Farvardin`
  String get jalali_month_farvardin {
    return Intl.message(
      'Farvardin',
      name: 'jalali_month_farvardin',
      desc: '',
      args: [],
    );
  }

  /// `Ordibehesht`
  String get jalali_month_ordibehesht {
    return Intl.message(
      'Ordibehesht',
      name: 'jalali_month_ordibehesht',
      desc: '',
      args: [],
    );
  }

  /// `Khordad`
  String get jalali_month_khordad {
    return Intl.message(
      'Khordad',
      name: 'jalali_month_khordad',
      desc: '',
      args: [],
    );
  }

  /// `Tir`
  String get jalali_month_tir {
    return Intl.message('Tir', name: 'jalali_month_tir', desc: '', args: []);
  }

  /// `Mordad`
  String get jalali_month_mordad {
    return Intl.message(
      'Mordad',
      name: 'jalali_month_mordad',
      desc: '',
      args: [],
    );
  }

  /// `Shahrivar`
  String get jalali_month_shahrivar {
    return Intl.message(
      'Shahrivar',
      name: 'jalali_month_shahrivar',
      desc: '',
      args: [],
    );
  }

  /// `Mehr`
  String get jalali_month_mehr {
    return Intl.message('Mehr', name: 'jalali_month_mehr', desc: '', args: []);
  }

  /// `Aban`
  String get jalali_month_aban {
    return Intl.message('Aban', name: 'jalali_month_aban', desc: '', args: []);
  }

  /// `Azar`
  String get jalali_month_azar {
    return Intl.message('Azar', name: 'jalali_month_azar', desc: '', args: []);
  }

  /// `Dey`
  String get jalali_month_dey {
    return Intl.message('Dey', name: 'jalali_month_dey', desc: '', args: []);
  }

  /// `Bahman`
  String get jalali_month_bahman {
    return Intl.message(
      'Bahman',
      name: 'jalali_month_bahman',
      desc: '',
      args: [],
    );
  }

  /// `Esfand`
  String get jalali_month_esfand {
    return Intl.message(
      'Esfand',
      name: 'jalali_month_esfand',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fa'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
