class LogicConst {
  static const String tempUser = 'tempuser';
  static const String status = 'status';
  static const String authenticate = 'authenticate';
  static const String unauthenticate = 'unauthenticate';
  static const String newTxt = 'new';
  static const String requests = 'requests';
  static const String users = 'users';
  static const String state = 'state';
  static const String excercises = 'excercises';
  static const String excercise = 'excercise';

  static const String baseUrl = 'https://fcm.googleapis.com/fcm/send';
  static const String serverKey =
      'AAAASDMMuWc:APA91bEacGsvXSovzu5sUJxew9Bllu3V0O1q0ss6S9pfqA645msVfRR57TtjlyP7nY-FAjxAvB2PN8x00myp-OioNTGnpPODLWsBJpyDuj6vTJ-DxZdwjvIxWOV_v8IjavCb4_3GMiWw';

  static const int minuts = 0;
  static const int second = 1;

  static const List<String> bodyPart = [
    "cardio",
    "chest",
    "back",
    "shoulders",
    "arms",
    "legs",
    "neck",
    "waist",
    'abs',
  ];

  static const List<String> targetMuscles = [
    "abductors",
    "abs",
    "adductors",
    "biceps",
    "calves",
    "cardiovascular system",
    "delts",
    "forearms",
    "glutes",
    "hamstrings",
    "lats",
    "levator scapulae",
    "pectorals",
    "quads",
    "serratus anterior",
    "spine",
    "traps",
    "triceps",
    "upper back"
  ];
}
