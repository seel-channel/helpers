import 'package:flutter/material.dart';

class BuildColor {
  /// It is a simplification of the **_Theme.of(_context)_** statement.
  BuildColor(BuildContext context) : _context = context;

  final BuildContext _context;

  ///```dart
  ///return Theme.of(context).primaryColor
  ///```
  Color get primary => Theme.of(_context).primaryColor;

  ///```dart
  ///return Theme.of(context).primaryColorLight
  ///```
  Color get primaryLight => Theme.of(_context).primaryColorLight;

  ///```dart
  ///return Theme.of(context).primaryColorDark
  ///```
  Color get primaryDark => Theme.of(_context).primaryColorDark;

  ///```dart
  ///return Theme.of(context).accentColor
  ///```
  @Deprecated(
    'Use colorScheme.secondary instead. '
    'For more information, consult the migration guide at '
    'https://flutter.dev/docs/release/breaking-changes/theme-data-accent-properties#migration-guide. '
    'This feature was deprecated after v2.3.0-0.1.pre.',
  )
  Color get accent => Theme.of(_context).colorScheme.secondary;

  ///```dart
  ///return Theme.of(context).canvasColor
  ///```
  Color get canvas => Theme.of(_context).canvasColor;

  ///```dart
  ///return Theme.of(context).shadowColor
  ///```
  Color get shadow => Theme.of(_context).shadowColor;

  ///```dart
  ///return Theme.of(context).scaffoldBackgroundColor
  ///```
  Color get scaffold => Theme.of(_context).scaffoldBackgroundColor;

  ///```dart
  ///return Theme.of(context).bottomAppBarColor
  ///```
  Color get bottomAppBar => Theme.of(_context).bottomAppBarColor;

  ///```dart
  ///return Theme.of(context).cardColor
  ///```
  Color get card => Theme.of(_context).cardColor;

  ///```dart
  ///return Theme.of(context).dividerColor
  ///```
  Color get divider => Theme.of(_context).dividerColor;

  ///```dart
  ///return Theme.of(context).focusColor
  ///```
  Color get focus => Theme.of(_context).focusColor;

  ///```dart
  ///return Theme.of(context).hoverColor
  ///```
  Color get hover => Theme.of(_context).hoverColor;

  ///```dart
  ///return Theme.of(context).highlightColor
  ///```
  Color get highlight => Theme.of(_context).highlightColor;

  ///```dart
  ///return Theme.of(context).splashColor
  ///```
  Color get splash => Theme.of(_context).splashColor;

  ///```dart
  ///return Theme.of(context).unselectedWidgetColor
  ///```
  Color get unselectedWidget => Theme.of(_context).unselectedWidgetColor;

  ///```dart
  ///return Theme.of(context).disabledColor
  ///```
  Color get disabled => Theme.of(_context).disabledColor;

  ///```dart
  ///return Theme.of(context).buttonColor
  ///```
  @Deprecated(
    'Use colorScheme.secondary instead. '
    'For more information, consult the migration guide at '
    'https://flutter.dev/docs/release/breaking-changes/theme-data-accent-properties#migration-guide. '
    'This feature was deprecated after v2.3.0-0.1.pre.',
  )
  Color get button => Theme.of(_context).buttonTheme.colorScheme?.secondary ?? Theme.of(_context).colorScheme.secondary;

  ///```dart
  ///return Theme.of(context).secondaryHeaderColor
  ///```
  Color get secondaryHeader => Theme.of(_context).secondaryHeaderColor;

  ///```dart
  ///return Theme.of(context).backgroundColor
  ///```
  Color get background => Theme.of(_context).backgroundColor;

  ///```dart
  ///return Theme.of(context).dialogBackgroundColor
  ///```
  Color get dialogBackground => Theme.of(_context).dialogBackgroundColor;

  ///```dart
  ///return Theme.of(context).indicatorColor
  ///```
  Color get indicator => Theme.of(_context).indicatorColor;

  ///```dart
  ///return Theme.of(context).hintColor
  ///```
  Color get hint => Theme.of(_context).hintColor;

  ///```dart
  ///return Theme.of(context).errorColor
  ///```
  Color get error => Theme.of(_context).errorColor;

  ///```dart
  ///return Theme.of(context).toggleableActiveColor
  ///```
  Color get toggleableActive => Theme.of(_context).toggleableActiveColor;
}
