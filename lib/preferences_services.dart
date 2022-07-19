import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';

class PreferencesService {
  Future SettingsSave(SaveSettings saveSettings) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString("username", saveSettings.username!);
    await preferences.setBool("isEmployed", saveSettings.isEmpoyed!);
    await preferences.setInt("gender", saveSettings.gender!.index);
    await preferences.setStringList(
        "proLanguages",
        saveSettings.programmingLanguage!
            .map((lang) => lang.index.toString())
            .toList());

    print("Save settingsssss");
  }

  Future<SaveSettings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();

    final username = preferences.getString('username');
    final isEmployed = preferences.getBool('isEmployed');
    final gender = Gender.values[preferences.getInt('gender') ?? 0];

    final programmingLanguagesIndicies =
        preferences.getStringList('programmingLanguages');

    final programmingLanguages = programmingLanguagesIndicies
        ?.map((stringIndex) =>
            ProgrammingLanguages.values[int.parse(stringIndex)])
        .toSet();

    return SaveSettings(
        username: username,
        gender: gender,
        programmingLanguage: programmingLanguages,
        isEmpoyed: isEmployed);
  }
}
