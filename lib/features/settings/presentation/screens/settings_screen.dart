import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        title: Text('Settings'.tr()),
      ),
      body: Consumer<L10nProvider>(
        builder: (context, l10nProvider, _) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ListTile(
                onTap: () {
                  _showChangeLanguagePopup(context, l10nProvider);
                },
                title: const Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: _getLanguageWidget(context, l10nProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case LocaleCodes.english:
        return 'English';
      case LocaleCodes.kinyarwanda:
        return 'Kinyarwanda';
      case LocaleCodes.swahili:
        return 'Swahili';
      case LocaleCodes.french:
        return 'French';
      default:
        return 'English';
    }
  }

  Widget _getLanguageWidget(
    BuildContext context,
    L10nProvider l10nProvider,
  ) {
    return Text(
      _getLanguageName(l10nProvider.locale),
      style: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
    );
  }

  void _showChangeLanguagePopup(
    BuildContext context,
    L10nProvider l10nProvider,
  ) {
    final supportedLocales = AppLocalizations.supportedLocales;
    log(l10nProvider.locale.toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Language'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                for (final locale in supportedLocales)
                  ListTile(
                    onTap: () {
                      l10nProvider.changeLocale(locale);
                      Navigator.of(context).pop();
                    },
                    selectedTileColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.15),
                    selected:
                        l10nProvider.locale.languageCode == locale.languageCode,
                    title: Text(_getLanguageName(locale)),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}