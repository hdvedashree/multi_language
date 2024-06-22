import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multi_language/enum.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var selectedLanguage = Languages.English;

  Locale _locale = Locale(Languages.English.value, '');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: _locale,
        supportedLocales: const [
          Locale('en', ''),
          Locale('hi', ''),
        ],
        builder: (context, child) {
          return Scaffold(
            backgroundColor: const Color(0xFF64B5F6),
            body: SafeArea(
                child: Column(
              children: [
                Container(
                  height: 50,
                  color: Colors.blueAccent,
                  child: const Center(
                      child: Text(
                    "Multi language",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                      child: Center(
                          child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Select language: ",
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 20),
                            _getDropdown(),
                            const SizedBox(height: 30),
                            Text(
                              AppLocalizations.of(context)?.homePage ?? "",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ))),
                ),
              ],
            )),
          );
        });
  }

  Widget _getDropdown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(15),
      child: PopupMenuButton<Languages>(
        enabled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        elevation: 2,
        tooltip: '',
        position: PopupMenuPosition.under,
        onSelected: (value) {
          //setLocale(Locale(value.value,''));

          setState(() {
            _locale = Locale(value.value, '');

            selectedLanguage = value;
          });
        },
        itemBuilder: (context) {
          List<PopupMenuEntry<Languages>> popupItems = [];

          for (var i = 0; i < Languages.values.length; i++) {
            if (i != 0) {
              popupItems.add(const PopupMenuDivider());
            }
            popupItems.add(PopupMenuItem(
              value: Languages.values[i],
              child: Text(
                Languages.values[i].name,
              ),
            ));
          }
          return popupItems;
        },
        // offset: Offset(0, 15.h),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedLanguage.name,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Icon(
                    Icons.arrow_drop_down_rounded,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
