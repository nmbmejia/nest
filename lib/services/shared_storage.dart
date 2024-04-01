import 'package:shared_preferences/shared_preferences.dart';

class SharedStorage {
  static const _lastName = 'lastName';
  static const _firstName = 'firstName';
  static const _phoneNumber = 'phoneNumber';
  static const _lastJoinedRoom = 'lastJoinedRoom';

  static deleteLastJoinedRoom() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(_lastJoinedRoom);
  }

  static saveLastJoinedRoom(String lastJoinedRoom) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(_lastJoinedRoom, lastJoinedRoom);
  }

  static Future<String?> getLastJoinedRoom() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? lastJoinedRoom = pref.getString(_lastJoinedRoom);
    return lastJoinedRoom;
  }

  static savePhoneNumber(String phoneNumber) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(_phoneNumber, phoneNumber);
  }

  static Future<String?> getPhoneNumber() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? phoneNumber = pref.getString(_phoneNumber);
    return phoneNumber;
  }

  static saveFirstName(String firstName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(_firstName, firstName);
  }

  static Future<String?> getFirstName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? firstName = pref.getString(_firstName);
    return firstName;
  }

  static saveLastName(String lastName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(_lastName, lastName);
  }

  static Future<String?> getLastName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? lastName = pref.getString(_lastName);
    return lastName;
  }
}
