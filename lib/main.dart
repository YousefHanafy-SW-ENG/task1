import 'package:flutter/material.dart';
import 'package:task1/home.dart';
import 'package:task1/settings.dart';
import 'package:task1/settings_page.dart';
import 'package:task1/signUp.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'myButton.dart';



void main() {
  runApp(
      MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
          home: SignUp(isDarkMode: false,)
      )
  );
}


