enum Gender {
  MALE,
  FEMALE,
  OTHER,
}

enum ProgrammingLanguages {
  Dart,
  JavaScript,
  Java,
  Swift,
}

class SaveSettings {
  final String? username;
  final Gender? gender;
  final Set<ProgrammingLanguages>? programmingLanguage;
  final bool? isEmpoyed;
  SaveSettings({
    this.username,
    this.gender,
    this.programmingLanguage,
    this.isEmpoyed,
  });
}
