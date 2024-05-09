# persian_calendar_widget

A Flutter package that provides users access to pick a date using a Persian calendar.

| <img src="https://github.com/Persian-Widgets/persian_calendar_widget/blob/main/doc/images/PREVIEW_MINIMAL_PERSIAN_CALENDAR.jpg?raw=true" width='250' alt="Minimal persian calendar" /> | <img src="https://github.com/Persian-Widgets/persian_calendar_widget/blob/main/doc/images/PREVIEW_CUSTOM_DECORATION_PERSIAN_CALENDAR.jpg?raw=true" width='250' alt="Minimal persian calendar" /> |
| :------: | :------: | 
| **Minimal Calendar** | **Custom Decoration Calendar** |                                                      


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
        MinimalPersianCalendar.pickFullDate(
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
        );
    },
    child: const Text('انتخاب روز ماه و سال')),
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
| `onSubmit`   | Callback function returning the picked date      | Function(Jalali jalaliDate, String dateInText)          | Required             |
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
| `cancelTextStyle` | Change text style of the cancel text         | TextStyle                                               | null     |
| `cancelTitle` | Change the title of the cancel button        | String                                               | null     |


### CustomDecorationPersianCalendar Parameters

| Parameter    | Description                                       | Type                                                   | Default              |
|--------------|---------------------------------------------------|--------------------------------------------------------|----------------------|
| `context`   | Callback function returning the picked date        | BuildContext                                           | Required             |
| `onSubmit`   | Callback function returning the picked date      | Function(Jalali jalaliDate, String dateInText)          | Required             |
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

## Contributing

Contributions are always welcome! If you have any suggestions, bug reports, or feature requests, please open an issue on the GitHub [repository](https://github.com/Persian-Widgets/persian_calendar_widget/issues).

If you would like to contribute to the project, please read the [CONTRIBUTING.md](https://github.com/Persian-Widgets/persian_calendar_widget/blob/main/CONTRIBUTING.md) file for more information on how to contribute.
