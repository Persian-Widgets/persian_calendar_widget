# persian_calendar_widget

A Flutter package that provides users access to pick a date using Persian and Gregorian calendars, with support for internationalization (i18n).

| <img src="https://github.com/Persian-Widgets/persian_calendar_widget/blob/main/doc/images/PREVIEW_MINIMAL_PERSIAN_CALENDAR.png?raw=true" width='250' alt="Minimal persian calendar" /> | <img src="https://github.com/Persian-Widgets/persian_calendar_widget/blob/main/doc/images/PREVIEW_CUSTOM_DECORATION_PERSIAN_CALENDAR.png?raw=true" width='250' alt="Minimal persian calendar" /> |<img src="https://github.com/Persian-Widgets/persian_calendar_widget/blob/main/doc/images/PREVIEW_CUSTOM_DECORATION_PERSIAN_CALENDAR_I18L.png?raw=true" width='250' alt="Minimal persian calendar" /> |
| :------: | :------: | :------: | 
| **Minimal Calendar** | **Custom Decoration Calendar** |  **Custom Decoration in English** |                                                      


## Usage

### MinimalPersianCalendar.pickFullDate widget

```Dart
/// pickFullDate dialog box
ElevatedButton(
    onPressed: () {
        /// open date picker widget
        /// user have access to pick day, month and year
        MinimalPersianCalendar.pickFullDate(
            context: context,
            onSubmit: (selectedDate, formattedDate) {
                /// when user chooses a date, two formats are returned:
                /// Record [selectedDate]: (jalali: Jalali(...), gregorian: Gregorian(...))
                /// Record [formattedDate]: (jalali: '12 ordibehesht 1403', gregorian: '2 May 2024')
                setState(() {
                    selectedDate = formattedDate.jalali; // or formattedDate.gregorian
                });
                log('Jalali date: ${formattedDate.jalali}');
                log('Gregorian date: ${formattedDate.gregorian}');
            },
            calendarType: CalendarType.jalali, // or CalendarType.gregorian
            i18n: I18n(), // Customize text strings and localizations
            showTodayBanner: true,
            useGoToTodayButton: true,
        );
    },
    child: const Text('انتخاب روز ماه و سال')),
```

### CustomDecorationPersianCalendar.pickFullDate widget

```Dart
/// pickFullDate dialog box
ElevatedButton(
    onPressed: () {
        /// open date picker widget
        /// user have access to pick day, month and year
        CustomDecorationPersianCalendar.pickFullDate(
            context: context,
            onSubmit: (jalaliDate, dateInText) {
                /// when user choose date from dialog box and submit two
                /// types of `Jalali` date returned here
                /// Jalali [jalaliDate]: Jalali(year, month, day, hour, minute, second, millisecond)
                /// String [dateInText]: '12 ordibehesht 1403'
                setState(() {
                    selectedDate = dateInText;
                });
                log('dateInText of pick full date: $dateInText');
                log('jalaliDate of pick full date: $jalaliDate');
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
                border: Border.all(color: Colors.cyan.shade500, width: 1.5),
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
        );
    },
    child: const Text('انتخاب روز ماه و سال')),
```

### Calendar Type Support

The widget now supports both Persian (Jalali) and Gregorian calendars. You can switch between them using the `calendarType` parameter:

```Dart
// For Persian calendar
calendarType: CalendarType.jalali

// For Gregorian calendar
calendarType: CalendarType.gregorian
```

### First Day of Week

You can customize which day of the week should appear as the first day in the calendar using the `firstDayOfWeek` parameter:

```Dart
MinimalPersianCalendar.pickFullDate(
    context: context,
    firstDayOfWeek: FirstDayOfWeek.saturday, // Start week from Saturday
    // or
    firstDayOfWeek: FirstDayOfWeek.sunday,   // Start week from Sunday
    // or
    firstDayOfWeek: FirstDayOfWeek.monday,   // Start week from Monday
    // ... other parameters
);
```

### Persian Digits Support

You can enable or disable Persian numbers in the calendar using the `enablePersianDigits` parameter:

```Dart
MinimalPersianCalendar.pickFullDate(
    context: context,
    enablePersianDigits: true,  // Enable Persian numbers (default)
    // or
    enablePersianDigits: false, // Use Western Arabic numbers
    // ... other parameters
);
```

### Internationalization (i18n)

You can customize all text strings in the calendar using the `i18n` parameter:

```Dart
MinimalPersianCalendar.pickFullDate(
    context: context,
    i18n: I18n(
            buttons: I18nButtons(
              cancel: S.current.button_cancel,
              submit: S.current.button_submit,
            ),
            weekCodes: I18nWeekCodes(
              saturday: S.current.week_day_sat,
              sunday: S.current.week_day_sun,
              monday: S.current.week_day_mon,
              tuesday: S.current.week_day_tue,
              wednesday: S.current.week_day_wed,
              thursday: S.current.week_day_thu,
              friday: S.current.week_day_fri,
            ),
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
    // ... other parameters
);
```

### toPersianDigit extension

```Dart
/// show this digits with persian format

Text(
    '123'.toPersianDigit(),
)
```



## Documentation

### MinimalPersianCalendar Parameters

| Parameter    | Description                                       | Type                                                   | Default              |
|--------------|---------------------------------------------------|--------------------------------------------------------|----------------------|
| `context`   | Callback function returning the picked date        | BuildContext                                           | Required             |
| `onSubmit`   | Callback function returning the picked date      | Function(({Jalali jalali, Gregorian gregorian}), ({String jalali, String gregorian}))          | Required             |
| `calendarType` | Type of calendar to display (Jalali/Gregorian)   | CalendarType                                           | Required             |
| `i18n`      | Internationalization settings for calendar text    | I18n                                                   | Default I18n()       |
| `enablePersianDigits` | Enable or disable Persian numbers in the calendar | bool | true |
| `firstDayOfWeek` | Set the starting day of the week (Saturday/Sunday/Monday) | FirstDayOfWeek | Saturday |
| `initialDate`| Initial date displayed in the calendar            | DateTime                                               | DateTime.now()       |
| `borderRadius` | Border radius of the dialog box                 | double                                                 | 20                 |
| `maxYear`    | Maximum selectable year                           | int                                                    | DateTime.now() + 11|
| `minYear`    | Minimum selectable year                           | int                                                    | DateTime.now()     |
| `primaryColor` | Choose primary color                          | Color                                                    | null     |
| `onPrimaryColor` | Choose on primary color                          | Color                                               | null     |
| `background` | Choose background color                          | Color                                                   | null     |
| `titleTextStyle` | Change text style of the title texts         | TextStyle                                               | null     |
| `titleSelectedTextStyle` | Change text style of the selected title texts | TextStyle                                      | null     |
| `dateTextStyle` | Change text style of the date texts         | TextStyle                                               | null     |
| `dateSelectedTextStyle` | Change text style of the selected date texts | TextStyle                                      | null     |
| `submitTextStyle` | Change text style of the submit text        | TextStyle                                               | null     |
| `submitTitle` | Change the title of the submit button        | String                                               | null     |
| `cancelTextStyle` | Change text style of the cancel text         | TextStyle                                        | null     |
| `cancelTitle` | Change the title of the cancel button        | String                                               | null     |
| `showTodayBanner` | Show a banner to see current day date        | bool                                     | null     |
| `todayDateBannerTextStyle` | Change text style of the today banner text         | TextStyle                        | null     |
| `useGoToTodayButton` | Show go to today button        | bool                                     | null     |
| `goTitle` | Change the title of the banner button title        | String                                    | null     |
| `goTextStyle` | Change text style of the banner button title        | TextStyle                              | null     |
| `weekDaysPadding` | Change the padding of the week days tiles         | EdgeInsetsGeometry                         | null     |
| `weekDaysTextStyle` | Change text style of the week days tiles text         | TextStyle                              | null     |


### CustomDecorationPersianCalendar Parameters

| Parameter    | Description                                       | Type                                                   | Default              |
|--------------|---------------------------------------------------|--------------------------------------------------------|----------------------|
| `context`   | Callback function returning the picked date        | BuildContext                                           | Required             |
| `onSubmit`   | Callback function returning the picked date      | Function(({Jalali jalali, Gregorian gregorian}), ({String jalali, String gregorian}))          | Required             |
| `calendarType` | Type of calendar to display (Jalali/Gregorian)   | CalendarType                                           | Required             |
| `i18n`      | Internationalization settings for calendar text    | I18n                                                   | Default I18n()       |
| `enablePersianDigits` | Enable or disable Persian numbers in the calendar | bool | true |
| `firstDayOfWeek` | Set the starting day of the week (Saturday/Sunday/Monday) | FirstDayOfWeek | Saturday |
| `initialDate`| Initial date displayed in the calendar            | DateTime                                               | DateTime.now()       |
| `borderRadius` | Border radius of the dialog box                 | double                                                 | 20                 |
| `maxYear`    | Maximum selectable year                           | int                                                    | DateTime.now() + 11|
| `minYear`    | Minimum selectable year                           | int                                                    | DateTime.now()     |
| `primaryColor` | Choose primary color                          | Color                                                    | null     |
| `onPrimaryColor` | Choose on primary color                          | Color                                               | null     |
| `background` | Choose background color                          | Color                                                   | null     |
| `titleBoxStyle` | Change the decoration of the title box        | BoxDecoration                                                   | null     |
| `titleButtonStyle` | Change the button style of the title buttons  | ButtonStyle                                                   | null     |
| `titleSelectedButtonStyle` | Change the button style of the selected title buttons       | ButtonStyle                           | null     |
| `titleTextStyle` | Change text style of the title texts         | TextStyle                                               | null     |
| `titleSelectedTextStyle` | Change text style of the selected title texts | TextStyle                                      | null     |
| `dateButtonStyle` | Change the button style of the date buttons  | ButtonStyle                                                   | null     |
| `dateSelectedButtonStyle` | Change the button style of the selected date buttons       | ButtonStyle                           | null     |
| `dateTextStyle` | Change text style of the date texts         | TextStyle                                               | null     |
| `dateSelectedTextStyle` | Change text style of the selected date texts | TextStyle                                      | null     |
| `submitButtonStyle` | Change the button style of the submit buttons  | ButtonStyle                                                   | null     |
| `submitTextStyle` | Change text style of the submit text        | TextStyle                                               | null     |
| `submitTitle` | Change the title of the submit button        | String                                               | null     |
| `cancelButtonStyle` | Change the button style of the cancel buttons  | ButtonStyle                                                   | null     |
| `cancelTextStyle` | Change text style of the cancel text         | TextStyle                                               | null     |
| `cancelTitle` | Change the title of the cancel button        | String                                               | null     |
| `showTodayBanner` | Show a banner to see current day date        | bool                                     | null     |
| `todayDateBannerTextStyle` | Change text style of the today banner text         | TextStyle                        | null     |
| `useGoToTodayButton` | Show go to today button        | bool                                     | null     |
| `goTitle` | Change the title of the banner button title        | String                                    | null     |
| `goTextStyle` | Change text style of the banner button title        | TextStyle                              | null     |
| `goButtonStyle` | Change the button style of the go today buttons  | ButtonStyle                                                   | null     |
| `weekDaysBoxStyle` | Change the decoration of the week days tiles        | BoxDecoration                         | null     |
| `weekDaysPadding` | Change the padding of the week days tiles         | EdgeInsetsGeometry                         | null     |
| `weekDaysTextStyle` | Change text style of the week days tiles text         | TextStyle                              | null     |

## Contributing

Contributions are always welcome! If you have any suggestions, bug reports, or feature requests, please open an issue on the GitHub [repository](https://github.com/Persian-Widgets/persian_calendar_widget/issues).

If you would like to contribute to the project, please read the [CONTRIBUTING.md](https://github.com/Persian-Widgets/persian_calendar_widget/blob/main/CONTRIBUTING.md) file for more information on how to contribute.
