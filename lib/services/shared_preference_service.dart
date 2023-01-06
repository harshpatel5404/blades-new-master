import 'package:shared_preferences/shared_preferences.dart';

Future setlogin(bool login) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('Islogin', login);
}

Future<bool?> getlogin() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('Islogin');
}

Future<bool> removelogin() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.remove('Islogin');
}

//token
Future<void> setToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('Token', token);
  // print("add mobile to local");
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.getString("Token"));
  return prefs.getString("Token");
}

Future<void> removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('Token');
}

//userid

Future setuserid(String userid) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userid', userid);
}

Future<String?> getuserid() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userid');
}

Future removeuserid() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userid');
}

Future<void> setUserinfo({name, email, phone}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', name ?? "");
  await prefs.setString('email', email ?? "");
  await prefs.setString('phone', phone ?? "");
}

Future<String?> getname() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('name');
}

Future<String?> getemail() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('email');
}

Future<String?> getphone() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('phone');
}

Future<void> setotp(String otp) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('otp', otp);
  // print("add mobile to local");
}

Future<String?> getotp() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("otp");
}

Future setchannelList(List<String> channellist) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('channellist', channellist);
}

Future<List<String>?> getchannelList() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('channellist') ?? [];
}

Future removechannelList() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.remove('channellist');
}



Future<void> setChannelId(String channelId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('channelId', channelId);
  // print("add mobile to local");
}

Future<String?> getChannelId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("channelId");
}