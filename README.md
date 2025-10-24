# persian_calendar_widget

[![pub package](https://img.shields.io/pub/v/persian_calendar_widget)](https://pub.dev/packages/persian_calendar_widget)

A Flutter package that provides a customizable grid view calendar widget and date picker by supporting Persian (Jalali) and Gregorian calendars, with internationalization (i18n) support.

![Persian Calendar Widget Shots](https://github.com/Persian-Widgets/persian_calendar_widget/blob/main/doc/images/persian_calendar_widget_shots.png?raw=true)

## Features

- Supports both Persian (Jalali) and Gregorian calendars.
- Embeddable `GridViewCalendar` for custom inline calendars with powerful builder callbacks for day and weekday tiles.
- Two widget variants: `MinimalPersianCalendar` (simple styling) and `CustomDecorationPersianCalendar` (full customization).
- Flexible date picking modes: full date (day/month/year), month/day, day only, or year/month.
- Internationalization for buttons, weekdays, and months.
- Optional Persian digits display.
- Customizable first day of the week (Saturday, Sunday, or Monday).
- Today banner and "Go to Today" button.
- Full theming support via TextStyle (Minimal) or BoxDecoration/ButtonStyle (Custom).

## Usage

The package provides two main classes: `MinimalPersianCalendar` for basic styling and `CustomDecorationPersianCalendar` for advanced customization. Both offer static methods to show date picker dialogs:

- `pickFullDate`: Select day, month, and year.
- `pickMonthAndDay`: Select month and day (no year).
- `pickDay`: Select day only (fixed month/year).
- `pickYearAndMonth`: Select year and month (no day).

Additionally, `GridViewCalendar` provides a non-dialog widget for embedding a customizable grid-based calendar view directly in your UI, ideal for inline date selection, event calendars, or multi-month layouts. It uses builder callbacks to empower developers with full control over rendering each day and weekday, enabling features like event indicators, custom colors, or interactive elements.

The `onSubmit` callback receives:
- `selectedDate`: Record with `jalali: Jalali` and `gregorian: Gregorian` objects.
- `formattedDate`: Record with `jalali: String` and `gregorian: String` (e.g., "12 Ordibehesht 1403").

### GridViewCalendar

`GridViewCalendar` is a powerful, embeddable widget that renders a month's days in a 7-column grid. Developers can customize each day tile via `DayTileBuilder` (receiving Jalali and Gregorian dates) and weekday headers via `WeekDayTileBuilder`. This allows for highly flexible implementations, such as highlighting specific dates, adding event badges, or creating swipeable multi-month calendars. It supports both calendar types, custom starting days, i18n, and layout adjustments for seamless integration into any Flutter UI.

#### Usage Example

```dart
import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/persian_calendar_widget.dart';

class MyCalendar extends StatefulWidget {
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grid Calendar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridViewCalendar(
          calendarType: CalendarType.jalali,
          initDate: (year: 1403, month: 2),  // Ordibehesht 1403
          firstDayOfWeek: FirstDayOfWeek.saturday,
          i18n: I18n(),  // Customize if needed
          // Custom weekday header builder
          weekDayTileBuilder: (weekDay) => Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              weekDay,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          // Custom day tile builder with selection
          builder: (jalaliDate, gregorianDate) {
            final isSelected = selectedDate == gregorianDate.toDateTime();
            final isToday = gregorianDate.toDateTime().isToday;
            return GestureDetector(
              onTap: () => setState(() {
                selectedDate = gregorianDate.toDateTime();
              }),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.blue
                      : (isToday ? Colors.green.shade100 : null),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey.shade300,
                  ),
                ),
                child: Center(
                  child: Text(
                    jalaliDate.formatter.dd.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
          mainAxisExtent: 50,  // Height of each day tile
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          padding: const EdgeInsets.symmetric(horizontal: 4),
        ),
      ),
    );
  }
}
```

This example demonstrates selecting dates via taps and custom styling for selected/today states, showcasing the widget's flexibility for interactive calendars.

### MinimalPersianCalendar.pickFullDate

```dart
import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/persian_calendar_widget.dart';

ElevatedButton(
  onPressed: () {
    MinimalPersianCalendar.pickFullDate(
      context: context,
      onSubmit: (selectedDate, formattedDate) {
        setState(() {
          selectedText = formattedDate.jalali; // or formattedDate.gregorian
        });
        debugPrint('Jalali: ${formattedDate.jalali}');
        debugPrint('Gregorian: ${formattedDate.gregorian}');
      },
      calendarType: CalendarType.jalali, // or CalendarType.gregorian
      i18n: I18n(), // Customize i18n
      showTodayBanner: true,
      useGoToTodayButton: true,
    );
  },
  child: const Text('Pick Full Date'),
)
```

For other methods (e.g., `pickDay`), use the same structure but adjust the `pickDateFormat` internally.

### CustomDecorationPersianCalendar.pickFullDate

```dart
ElevatedButton(
  onPressed: () {
    CustomDecorationPersianCalendar.pickFullDate(
      context: context,
      onSubmit: (selectedDate, formattedDate) {
        setState(() {
          selectedText = formattedDate.jalali;
        });
        debugPrint('Jalali: ${formattedDate.jalali}');
        debugPrint('Gregorian: ${formattedDate.gregorian}');
      },
      calendarType: CalendarType.jalali,
      background: Colors.cyan.shade50,

      // Title box
      titleBoxStyle: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colors.cyan.shade500, width: 1.5),
        color: Colors.cyan.shade600,
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.shade500,
            offset: Offset.zero,
            blurRadius: 25,
          ),
        ],
      ),
      titleButtonStyle: TextButton.styleFrom(),
      titleSelectedButtonStyle: TextButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.cyan.shade700,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      titleTextStyle: const TextStyle(color: Colors.white),
      titleSelectedTextStyle: const TextStyle(color: Colors.white54),

      // Date buttons
      dateButtonStyle: TextButton.styleFrom(),
      dateSelectedButtonStyle: TextButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.cyan.shade700,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      dateTextStyle: TextStyle(color: Colors.cyan.shade700),
      dateSelectedTextStyle: const TextStyle(color: Colors.white54),

      // Submit button
      submitTitle: 'ثبت',
      submitButtonStyle: ElevatedButton.styleFrom(
        elevation: 10,
        shadowColor: Colors.cyan.shade400,
        backgroundColor: Colors.cyan.shade700,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      submitTextStyle: TextStyle(color: Colors.cyan.shade100),

      // Cancel button
      cancelTitle: 'لغو',
      cancelButtonStyle: TextButton.styleFrom(),
      cancelTextStyle: TextStyle(color: Colors.cyan.shade700),

      // Week days
      weekDaysBoxStyle: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colors.cyan.shade500, width: 1.5),
        color: Colors.cyan.shade600,
      ),
      weekDaysTextStyle: const TextStyle(color: Colors.white),

      showTodayBanner: true,
      useGoToTodayButton: true,
    );
  },
  child: const Text('Pick Full Date (Custom)'),
)
```

### Calendar Type Support

```dart
calendarType: CalendarType.jalali  // Persian
// or
calendarType: CalendarType.gregorian  // Gregorian
```

### First Day of Week

```dart
firstDayOfWeek: FirstDayOfWeek.saturday,  // Saturday first
// or FirstDayOfWeek.sunday, FirstDayOfWeek.monday
```

### Persian Digits Support

```dart
enablePersianDigits: true,  // Persian digits (default)
// or false for Western Arabic digits
```

### Internationalization (i18n)

Customize texts via `I18n`:

```dart
i18n: I18n(
  buttons: I18nButtons(
    cancel: 'Cancel',  // Or use app localization like S.current.cancel
    submit: 'Submit',
    goToday: 'Go to Today',
  ),
  weekCodes: I18nWeekCodes(
    saturday: 'ش', sunday: 'ی', monday: 'د', tuesday: 'س', wednesday: 'چ',
    thursday: 'پ', friday: 'ج',
  ),
  persianMonths: I18nPersianMonths(
    farvardin: 'فروردین', ordibehesht: 'اردیبهشت', // etc.
  ),
  gregorianMonths: I18nGregorianMonths(
    january: 'January', february: 'February', // etc.
  ),
),
```

For full app localization, integrate with `flutter_localizations` and use `S.of(context).key` in `I18n` fields.

### toPersianDigit Extension

Convert numbers to Persian digits:

```dart
Text('123'.toPersianDigit())  // Outputs: ۱۲۳
```


## Documentation

### GridViewCalendar Parameters

| Parameter              | Description                                      | Type                  | Default                  |
|------------------------|--------------------------------------------------|-----------------------|--------------------------|
| `builder`              | Required callback to build each day tile         | `DayTileBuilder`      | Required                 |
| `weekDayTileBuilder`   | Optional callback for weekday headers            | `WeekDayTileBuilder?` | null (default headers)   |
| `calendarType`         | Jalali or Gregorian display                      | `CalendarType?`       | Persian                  |
| `initDate`             | Initial year and month to display                | `InitDate?`           | Current month/year       |
| `firstDayOfWeek`       | Starting day (Saturday for Persian, Monday for Gregorian) | `FirstDayOfWeek?` | Auto-configured          |
| `i18n`                 | Weekday and month names                          | `I18n?`               | Default `I18n()`         |
| `mainAxisExtent`       | Height of day tiles                              | `double?`             | Auto                     |
| `crossAxisSpacing`     | Horizontal spacing between tiles                 | `double?`             | 0.0                      |
| `mainAxisSpacing`      | Vertical spacing between rows                    | `double?`             | 0.0                      |
| `padding`              | Overall padding                                  | `EdgeInsets?`         | EdgeInsets.all(8)        |

With these builders, developers can implement advanced features like event overlays, accessibility labels, animations, or integration with state management for dynamic calendars.

### MinimalPersianCalendar Parameters

| Parameter              | Description                                      | Type                  | Default                  |
|------------------------|--------------------------------------------------|-----------------------|--------------------------|
| `context`              | The BuildContext for showing the dialog          | `BuildContext`        | Required                 |
| `onSubmit`             | Callback with selected and formatted dates       | `OnPickDate?`         | Required                 |
| `calendarType`         | Calendar type (Jalali or Gregorian)              | `CalendarType`        | Required                 |
| `initialDate`          | Starting date                                   | `DateTime?`           | `DateTime.now()`         |
| `maxYear` / `minYear`  | Year range (for full/year-month modes)          | `int?`                | N/A                      |
| `borderRadius`         | Dialog border radius                            | `double?`             | 20.0                     |
| `primaryColor`         | Primary theme color                             | `Color?`              | Theme primary            |
| `onPrimaryColor`       | Text color on primary                           | `Color?`              | Theme onPrimary          |
| `background`           | Dialog background color                         | `Color?`              | Theme background         |
| `titleTextStyle`       | Unselected title text style                     | `TextStyle?`          | Default                  |
| `titleSelectedTextStyle` | Selected title text style                     | `TextStyle?`          | Default                  |
| `dateTextStyle`        | Unselected date text style                      | `TextStyle?`          | Default                  |
| `dateSelectedTextStyle`| Selected date text style                        | `TextStyle?`          | Default                  |
| `submitTextStyle`      | Submit button text style                        | `TextStyle?`          | Default                  |
| `cancelTextStyle`      | Cancel button text style                        | `TextStyle?`          | Default                  |
| `showTodayBanner`      | Show today date banner                          | `bool?`               | false                    |
| `useGoToTodayButton`   | Show "Go to Today" button                       | `bool?`               | false                    |
| `weekDaysPadding`      | Weekdays padding                                | `EdgeInsetsGeometry?` | Default                  |
| `weekDaysTextStyle`    | Weekdays text style                             | `TextStyle?`          | Default                  |
| `firstDayOfWeek`       | Starting day of week                            | `FirstDayOfWeek?`     | Saturday                 |
| `i18n`                 | i18n configuration                              | `I18n?`               | Default `I18n()`         |
| `enablePersianDigits`  | Use Persian digits                              | `bool?`               | true                     |

*Note: Minimal uses TextStyle for styling; deprecated string titles should use `I18n` instead.*

### CustomDecorationPersianCalendar Parameters

Similar to Minimal, but with advanced styling:

| Parameter                  | Description                                      | Type                  | Default                  |
|----------------------------|--------------------------------------------------|-----------------------|--------------------------|
| `context`                  | The BuildContext for showing the dialog          | `BuildContext`        | Required                 |
| `onSubmit`                 | Callback with selected and formatted dates       | `OnPickDate?`         | Required                 |
| `calendarType`             | Calendar type (Jalali or Gregorian)              | `CalendarType`        | Required                 |
| `initialDate`              | Starting date                                   | `DateTime?`           | `DateTime.now()`         |
| `maxYear` / `minYear`      | Year range (for full/year-month modes)          | `int?`                | N/A                      |
| `borderRadius`             | Dialog border radius                            | `double?`             | 20.0                     |
| `primaryColor`             | Primary theme color                             | `Color?`              | Theme primary            |
| `onPrimaryColor`           | Text color on primary                           | `Color?`              | Theme onPrimary          |
| `background`               | Dialog background color                         | `Color?`              | Theme background         |
| `titleBoxStyle`            | Title container decoration                      | `BoxDecoration?`      | Default                  |
| `titleButtonStyle`         | Unselected title button style                   | `ButtonStyle?`        | Default                  |
| `titleSelectedButtonStyle` | Selected title button style                     | `ButtonStyle?`        | Default                  |
| `titleTextStyle`           | Unselected title text style                     | `TextStyle?`          | Default                  |
| `titleSelectedTextStyle`   | Selected title text style                       | `TextStyle?`          | Default                  |
| `dateButtonStyle`          | Unselected date button style                    | `ButtonStyle?`        | Default                  |
| `dateSelectedButtonStyle`  | Selected date button style                      | `ButtonStyle?`        | Default                  |
| `dateTextStyle`            | Unselected date text style                      | `TextStyle?`          | Default                  |
| `dateSelectedTextStyle`    | Selected date text style                        | `TextStyle?`          | Default                  |
| `submitButtonStyle`        | Submit button style                             | `ButtonStyle?`        | Default                  |
| `submitTextStyle`          | Submit text style                               | `TextStyle?`          | Default                  |
| `cancelButtonStyle`        | Cancel button style                             | `ButtonStyle?`        | Default                  |
| `cancelTextStyle`          | Cancel text style                               | `TextStyle?`          | Default                  |
| `goButtonStyle`            | "Go to Today" button style                      | `ButtonStyle?`        | Default                  |
| `weekDaysBoxStyle`         | Weekdays container decoration                   | `BoxDecoration?`      | Default                  |
| `weekDaysPadding`          | Weekdays padding                                | `EdgeInsetsGeometry?` | Default                  |
| `weekDaysTextStyle`        | Weekdays text style                             | `TextStyle?`          | Default                  |
| `firstDayOfWeek`           | Starting day of week                            | `FirstDayOfWeek?`     | Saturday                 |
| `i18n`                     | i18n configuration                              | `I18n?`               | Default `I18n()`         |
| `enablePersianDigits`      | Use Persian digits                              | `bool?`               | true                     |

*Deprecated string titles (`submitTitle`, etc.) should use `I18n` instead.*

## Contributing

Contributions are welcome! Please open an issue on the [GitHub repository](https://github.com/Persian-Widgets/persian_calendar_widget/issues) for suggestions, bugs, or features.

To contribute code, read the [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.
