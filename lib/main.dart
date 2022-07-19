import 'package:day8/models.dart';
import 'package:day8/preferences_services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _preferencesService = PreferencesService();
  final _textfieldController = TextEditingController();
  var _selectedGender = Gender.FEMALE;
  var _selectedLanguage = Set<ProgrammingLanguages>();
  bool? isEmployed = false;

  @override
  void initState() {
    super.initState();
    _populateFields();
  }

  void _populateFields() async {
    final settings = await _preferencesService.getSettings();
    setState(() {
      _textfieldController.text = settings.username!;
      _selectedGender = settings.gender!;
      // _selectedLanguage = settings.programmingLanguage!;
      isEmployed = settings.isEmpoyed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _textfieldController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
          ),
          RadioListTile(
            title: const Text("Female"),
            value: Gender.FEMALE,
            groupValue: _selectedGender,
            onChanged: (newValue) {
              setState(() => _selectedGender = newValue as Gender);
            },
          ),
          RadioListTile(
            title: const Text("Male"),
            value: Gender.MALE,
            groupValue: _selectedGender,
            onChanged: (newValue) {
              setState(() => _selectedGender = newValue as Gender);
            },
          ),
          RadioListTile(
            title: const Text("Other"),
            value: Gender.OTHER,
            groupValue: _selectedGender,
            onChanged: (newValue) {
              setState(() => _selectedGender = newValue as Gender);
            },
          ),
          CheckboxListTile(
            title: const Text("Dart"),
            value: _selectedLanguage.contains(ProgrammingLanguages.Dart),
            onChanged: (_) {
              setState(() =>
                  _selectedLanguage.contains(ProgrammingLanguages.Dart)
                      ? _selectedLanguage.remove(ProgrammingLanguages.Dart)
                      : _selectedLanguage.add(ProgrammingLanguages.Dart));
            },
          ),
          CheckboxListTile(
            title: const Text("Java"),
            value: _selectedLanguage.contains(ProgrammingLanguages.Java),
            onChanged: (_) {
              setState(() =>
                  _selectedLanguage.contains(ProgrammingLanguages.Java)
                      ? _selectedLanguage.remove(ProgrammingLanguages.Java)
                      : _selectedLanguage.add(ProgrammingLanguages.Java));
            },
          ),
          CheckboxListTile(
            title: const Text("JavaScript"),
            value: _selectedLanguage.contains(ProgrammingLanguages.JavaScript),
            onChanged: (_) {
              setState(() => _selectedLanguage
                      .contains(ProgrammingLanguages.JavaScript)
                  ? _selectedLanguage.remove(ProgrammingLanguages.JavaScript)
                  : _selectedLanguage.add(ProgrammingLanguages.JavaScript));
            },
          ),
          CheckboxListTile(
            title: const Text("Swift"),
            value: _selectedLanguage.contains(ProgrammingLanguages.Swift),
            onChanged: (_) {
              setState(() =>
                  _selectedLanguage.contains(ProgrammingLanguages.Swift)
                      ? _selectedLanguage.remove(ProgrammingLanguages.Swift)
                      : _selectedLanguage.add(ProgrammingLanguages.Swift));
            },
          ),
          SwitchListTile(
              title: Text("Is Employed"),
              value: isEmployed!,
              onChanged: (newValue) {
                setState(() {
                  isEmployed = newValue;
                });
              }),
          TextButton(
            style: TextButton.styleFrom(
                // backgroundColor: Colors.blue,
                // primary: Colors.white,
                // maximumSize: Size(100, 50),
                ),
            onPressed: _saveSettings,
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _saveSettings() {
    final newSettings = SaveSettings(
      username: _textfieldController.text,
      gender: _selectedGender,
      programmingLanguage: _selectedLanguage,
      isEmpoyed: isEmployed,
    );
    print(newSettings);
    _preferencesService.SettingsSave(newSettings);
  }
}
