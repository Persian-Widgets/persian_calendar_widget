## 0.7.0

### Major Features
* Implement grid view calendar widget
* Add calendar helper with next and previous methods
* Add boolean constructors to CalendarType and FirstDayOfWeek enums

### Breaking Changes
* Handle extra space and remove it when start week day is Sunday or Saturday on day page view
* Flag deprecated arguments on minimal and custom decoration Persian calendars
* Handle text direction (RTL) and change banner radius borders
* Add shamsi_date package import to the Persian calendar widget file
* Remove extra Directionality widget on date picker dialog boxes

## 0.6.0

### Major Features
* Added support for Gregorian calendar alongside Persian calendar
* Implemented internationalization (i18n) support
* Added customizable first day of week option (Saturday/Sunday/Monday)
* Added Persian digits toggle feature

### Breaking Changes
* Changed `onSubmit` callback signature to return both Jalali and Gregorian dates
* Updated calendar type handling with new `CalendarType` enum

### Enhancements
* Enhanced i18n support with customizable text strings
* Improved type safety with new enums and records
* Added better documentation and examples
* Updated UI customization options

## 0.5.0
* Optimize resizing dialog box width
* Refactor date picker dialog boxes
* Remove `todayTitleBannerTextStyle` argument
* Implement week days
* Update `README.md` file
* Update screenshots

## 0.4.0
* Implement go to button and today banner
* Update example

## 0.3.0
* Implement `pickYearAndMonth` widget
* Update example

## 0.2.0
* Implement `ToPersianDigit` extension
* Implement `CustomDecorationPersianCalendar` widget
* Update example
* Update `README.md` file

## 0.1.0
* Update `README.md` file
* Add repository URL in `pubspec.yaml` file
* Add homepage URL in `pubspec.yaml` file
* Add topics in `pubspec.yaml` file
* Add contributing info in `CONTRIBUTING.md` file
* Add `primaryColor` and `background` in minimal persian calendar

## 0.0.1
* Implement minimal date picker dialog box
