import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:blades/controller/channel_controller.dart';
import 'package:blades/controller/channel_details_controller.dart';
import 'package:blades/controller/get_information.dart';
import 'package:blades/controller/grid_controller.dart';
import 'package:blades/controller/home_controller.dart';
import 'package:blades/controller/subscription_controller.dart';
import 'package:blades/models/channel_model.dart';
import 'package:blades/models/comment_model.dart';
import 'package:blades/models/content_model.dart';
import 'package:blades/models/grid_view_model.dart';
// import 'package:blades/models/content_model.dart';
import 'package:blades/models/subscription_model.dart';
import 'package:blades/screens/home.dart';
import 'package:blades/screens/pageview_video.dart';
import 'package:blades/screens/sign_in_page.dart';
import 'package:blades/screens/verify_otp_screen.dart';
import 'package:blades/services/shared_preference_service.dart';
import 'package:blades/utils/deactivated_dialog.dart';
import 'package:blades/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import '../controller/comment_controller.dart';
import '../controller/profile_controller.dart';

var baseUrl = "https://nodeserver.mydevfactory.com:3309/frontendRouter";
var imgUrl = "https://nodeserver.mydevfactory.com:3309/userProfile";

Future signup(Map data, {isResendOtp = false}) async {
  try {
    final response = await http.post(Uri.parse('$baseUrl/registration'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: json.encode({
          "name": data['name'],
          "email": data['email'],
          "phone": data['phone'],
          "password": data['password'],
        }),
        encoding: Encoding.getByName('utf-8'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
      showCustomSnackBar("Please check your email for OTP code.",
          isError: false);
      var otp = responsedata['data']['otp'].toString();
      await setotp(otp);
      if (!isResendOtp) {
        Get.to(VerifyOtpScreen(otp: otp, data: data));
      }
    } else {
      var responsedata = jsonDecode(response.body);
      print("400");
      print(responsedata);
      showCustomSnackBar("Email already exists");
    }
  } on SocketException {
    return "No Internet connection";
  } on TimeoutException {
    throw TimeoutException('Connection Time Out!');
  } catch (e) {
    print(e.toString());
  }
}

Future verifyOtp(otp, data) async {
  // var name = await getname();
  // var email = await getemail();
  // var phone = await getphone();

  try {
    final response = await http.post(Uri.parse('$baseUrl/otpVerify'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: json.encode({
          "name": data['name'],
          "email": data['email'],
          "phone": data['phone'].toString(),
          "password": data['password'],
          "EmailOtp": otp,
          "InputOtp": otp
        }),
        encoding: Encoding.getByName('utf-8'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responsedata = jsonDecode(response.body);
      await setuserid(responsedata['data']['_id'].toString());
      showCustomSnackBar("OTP Verify Successfully", isError: false);
      Get.off(SignInPage());
    } else {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
    }
  } on TimeoutException {
    showCustomSnackBar("Connection Time Out!");
  } catch (e) {
    print(e.toString());
  }
}

Future resendOTP() async {
  var email = await getemail();
  try {
    final response = await http.post(Uri.parse('$baseUrl/resendOTP'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: json.encode({
          "email": email,
        }),
        encoding: Encoding.getByName('utf-8'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responsedata = jsonDecode(response.body);
      showCustomSnackBar("OTP Send Successfully", isError: false);
    } else {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
    }
  } on SocketException {
    showCustomSnackBar("No Internet connection");
  } on TimeoutException {
    showCustomSnackBar("Connection Time Out!");
  } catch (e) {
    print(e.toString());
  }
}

Future login(email, password) async {
  try {
    final response = await http.post(Uri.parse('$baseUrl/login'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: json.encode({
          "email": email,
          "password": password,
        }),
        encoding: Encoding.getByName('utf-8'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
      var email = responsedata['data']['email'].toString();
      var name = responsedata['data']['name'].toString();
      var phone = responsedata['data']['phone'].toString();
      await setToken(responsedata['token']);
      await setuserid(responsedata['data']['_id']);
      await setUserinfo(email: email, name: name, phone: phone);
      await setlogin(true);
      showCustomSnackBar("Login Successfully", isError: false);
      Get.offAll(const PageViewVideo());
    } else {
      var responsedata = jsonDecode(response.body);
      print("400");
      print(responsedata);
      showCustomSnackBar("Invalid Credential!");
    }
  } on SocketException {
    return "No Internet connection";
  } on TimeoutException {
    throw TimeoutException('Connection Time Out!');
  } catch (e) {
    showCustomSnackBar("Something went wrong!");
  }
}

Future getProfileDetails() async {
  var token = await getToken();

  ProfileController profilecontroller = Get.put(ProfileController());
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/get_user_detail'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "authorization": "Bearer $token"
      },
    );
    if (response.statusCode == 200) {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
      var data = responsedata['data'];
      profilecontroller.name.value = data['name'];
      profilecontroller.email.value = data['email'];
      profilecontroller.contact.value = data['phone'].toString();
      profilecontroller.bio.value = data['bio'];
      profilecontroller.otherDetails.value = data['otherDetails'];
      profilecontroller.image.value = data['profileImage'];
      profilecontroller.id.value = data['_id'];
      profilecontroller.isverified.value = data['isActive'];
    } else {
      var responsedata = jsonDecode(response.body);
    }
  } on SocketException {
    showCustomSnackBar("No Internet connection");
  } on TimeoutException {
    showCustomSnackBar("Connection Time Out!");
  } catch (e) {
    print(e.toString());
    showCustomSnackBar(e.toString());
  }
}

Future updateProfile(name, email, phone, bio, detail, profileImg) async {
  var token = await getToken();
  try {
    if (profileImg != null) {
      var request =
          http.MultipartRequest('POST', Uri.parse("$baseUrl/edit-profile"))
            ..headers['authorization'] = "Bearer $token"
            ..files.add(await http.MultipartFile.fromPath(
              'profileImage',
              profileImg.path,
            )); // your file(s)
      var responseimg = await request.send();
      if (responseimg.statusCode == 200 || responseimg.statusCode == 200) {
        print(responseimg.reasonPhrase);
        print('Uploaded!');
      }
    }

    final response = await http.post(Uri.parse('$baseUrl/edit-profile'),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "authorization": "Bearer $token"
        },
        body: json.encode({
          "name": name,
          // "email": "testing@gmail.com",
          "phone": phone,
          "bio": bio,
          "otherDetails": detail,
        }),
        encoding: Encoding.getByName('utf-8'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
    } else {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
    }
  } on SocketException {
    showCustomSnackBar("No Internet connection");
  } on TimeoutException {
    showCustomSnackBar("Connection Time Out!");
  } catch (e) {
    print(e.toString());
    showCustomSnackBar(e.toString());
  }
}

Future forgetPassword(email) async {
  try {
    final response = await http.post(Uri.parse('$baseUrl/forgotPassword'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: json.encode({
          "email": email,
        }),
        encoding: Encoding.getByName('utf-8'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
      showCustomSnackBar('Password send to your email', isError: false);
      // Get.to(const SignInPage());
    } else {
      var responsedata = jsonDecode(response.body);
      print(response.statusCode);
      print(responsedata);
      showCustomSnackBar('Email not found');
    }
  } on SocketException {
    showCustomSnackBar("No Internet connection");
  } on TimeoutException {
    showCustomSnackBar("Connection Time Out!");
  } catch (e) {
    print(e.toString());
    showCustomSnackBar(e.toString());
  }
}

Future changePassword(oldPassword, newPassword) async {
  try {
    var token = await getToken();

    final response = await http.post(Uri.parse('$baseUrl/changePassword'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': '$token',
        },
        body: json.encode({
          "oldpassword": oldPassword,
          "password": newPassword,
        }),
        encoding: Encoding.getByName('utf-8'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
      showCustomSnackBar('You have Successfully Changed your password',
          isError: false);
    } else if (response.statusCode == 401) {
      print(response.statusCode.toString());
      print('unauthorize');
    } else {
      var responsedata = jsonDecode(response.body);
      print(response.statusCode);
      print(responsedata);
      showCustomSnackBar(responsedata["message"].toString());
      // showCustomSnackBar(
      //     'Password contain at least one upper, lower, digit, special character');
    }
  } catch (e) {
    showCustomSnackBar("Server Error!");
  }
}

Future contactUs(
    String name, String email, String bio, practiceinfo, String msg) async {
  try {
    final response = await http.post(Uri.parse('$baseUrl/add-contact-us'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: json.encode({
          "name": name,
          "email": email,
          "bio": bio,
          "practiceinfo": practiceinfo,
          "message": msg
        }),
        encoding: Encoding.getByName('utf-8'));
    /* print('after send bearer token'+token.toString());*/

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
      showCustomSnackBar('You have Successfully Sent your Message',
          isError: false);
    } else {
      var responsedata = jsonDecode(response.body);
      print(response.statusCode);
      print(responsedata);
      showCustomSnackBar(responsedata['msg']);
    }
  } on SocketException {
    return "No Internet connection";
  } on TimeoutException {
    throw TimeoutException('Connection Time Out!');
  } catch (e) {
    showCustomSnackBar("Something went wrong!");
  }
}

Future getInformation(endPoint) async {
  GetInformationController getInformationController =
      Get.put(GetInformationController());
  try {
    final response = await http.get(Uri.parse('$baseUrl/$endPoint'), headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
      getInformationController.data.value = responsedata['data']['content'];
    } else {
      var responsedata = jsonDecode(response.body);
      print(response.statusCode);
      print(responsedata);
    }
  } on SocketException {
    getInformationController.infomsg.value = "No Internet connection";
    // showCustomSnackBar("No Internet connection");
  } on TimeoutException {
    getInformationController.infomsg.value = "Connection Time Out!";
    // showCustomSnackBar("Connection Time Out!");
  } catch (e) {
    print(e.toString());
    getInformationController.infomsg.value = e.toString();
    showCustomSnackBar(e.toString());
  }
}

Future createChannel(channelname, desc, File channelImg) async {
  var token = await getToken();
  final data = {
    'title': channelname,
    'description': desc,
    'profileImage': await dio.MultipartFile.fromFile(channelImg.path,
        filename: channelImg.path.split("/").last)
  };
  print(data);
  dio.FormData formData = dio.FormData.fromMap(data);
  try {
    dio.Dio dio1 = dio.Dio();
    dio.Response response = await dio1.post(
      "$baseUrl/add-Channel",
      data: formData,
      options: dio.Options(
        headers: {
          "Accept": "application/json",
          "authorization": "Bearer $token"
        },
      ),
    );
    if (response.statusCode == 200) {
      print("200");
      print(response.data);
    } else {
      print(response.data.toString());
    }
  } catch (e) {
    print("error");
    print(e.toString());
  }
}

Future getChannelDetails() async {
  ChannelController channelController = Get.put(ChannelController());
  var token = await getToken();
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/get-Channel-details'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "authorization": "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      channelController.contentList.clear();
      var responsedata = ChannelModel.fromJson(jsonDecode(response.body));
      List<Datum> datum = responsedata.data;
      List<ChannelList> channels = datum[0].channelList;

      if (channels.isNotEmpty) {
        print("my channels");
        channelController.channelList.value = channels;
        channelController.isChannelmsg.value = "true";

        await setChannelId(channels[0].id);
        List<String> channelTitleList = [];
        for (var channelContent in responsedata.contentData) {
          for (var content in channelContent.uploadContent) {
            channelController.contentList.add(content);
          }
        }
        channelController.contentList.value =
            List.from(channelController.contentList.reversed);

        if (responsedata.contentData.isNotEmpty) {
          channelController.contentmsg.value = "true";
        }
        for (var channel in channels) {
          channelTitleList.add(channel.title.toString());
        }
        setchannelList(channelTitleList);
      } else {
        channelController.isChannelmsg.value = "false";
        channelController.contentmsg.value = "false";
        print("not channel");
      }
    } else {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
    }
  } on SocketException {
    channelController.isChannelmsg.value = "No Internet connection";
    channelController.contentmsg.value = "false";

    showCustomSnackBar("No Internet connection");
  } on TimeoutException {
    channelController.isChannelmsg.value = "Connection Time Out!";
    channelController.contentmsg.value = "false";

    showCustomSnackBar("Connection Time Out!");
  } catch (e) {
    print(e.toString());
    print("content error");
    channelController.contentmsg.value = "false";
    channelController.isChannelmsg.value = "Something went to Wrong!";
  }
}

Future getContent() async {
  HomeController homeController = Get.put(HomeController());
  homeController.ishomeContent.value = true;
  var token = await getToken();
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/get-subscription'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "authorization": "Bearer $token"
      },
    );
    if (response.statusCode == 200) {
      print("content is ${response.body}");

      homeController.homecontentList.clear();
      var data = ContentModel.fromJson(jsonDecode(response.body));
      for (var contentdata in data.contentData) {
        for (var element in contentdata.homeuploadContent) {
          homeController.homecontentList.add(element);
        }
      }
      print(homeController.homecontentList.length);
    } else {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
    }
  } on SocketException {
    homeController.homecontentmsg.value = "false";
    // showCustomSnackBar("No Internet connection");
  } on TimeoutException {
    homeController.homecontentmsg.value = "false";
    // showCustomSnackBar("Connection Time Out!");
  } catch (e) {
    print(e.toString());
    homeController.ishomeChannelmsg.value = "Something went to Wrong!";
    showCustomSnackBar("Server error!");
  }
}

Future getContentByChannel(contentId) async {
  print(contentId);
  GridController gridController = Get.put(GridController());
  gridController.gridcontentList.clear();
  var token = await getToken();
  try {
    final response =
        await http.post(Uri.parse('$baseUrl/get-AllContent-channel'),
            headers: {
              "Content-Type": "application/json; charset=utf-8",
              "authorization": "Bearer $token"
            },
            body: json.encode({"contentId": contentId}),
            encoding: Encoding.getByName('utf-8'));
    if (response.statusCode == 200) {
      var responsedata = jsonDecode(response.body);
      var uplist = responsedata["data"]["uploadContent"];
      for (var element in uplist) {
        gridController.gridcontentList
            .add(UploadContent.fromJson(element as Map<String, dynamic>));
      }
    }
  } catch (e) {
    print(e.toString());
    showCustomSnackBar("Server error!");
  }
}

Future getContentByChannelId(channelId) async {
  ChannelDetailController channelDetailController =
      Get.put(ChannelDetailController());
  channelDetailController.channelcontentList.clear();
  print(channelId);

  var token = await getToken();
  try {
    final response = await http.post(Uri.parse('$baseUrl/get-channel-byId'),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "authorization": "Bearer $token"
        },
        body: json.encode({"channelId": channelId}),
        encoding: Encoding.getByName('utf-8'));
    if (response.statusCode == 200) {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
      var uplist = responsedata["data"][0]["uploadContent"] ?? [];
      for (var element in uplist) {
        channelDetailController.channelcontentList
            .add(UploadContent.fromJson(element as Map<String, dynamic>));
      }
    }
  } catch (e) {
    print(e.toString());
    showCustomSnackBar("Server error!");
  }
}

Future editChannel(channelname, desc, editchannelImg, id) async {
  var token = await getToken();
  final data = {'title': channelname, 'description': desc, 'channelId': id};
  if (editchannelImg != null) {
    print(editchannelImg.path.split("/").last);
    data['profileImage'] = await dio.MultipartFile.fromFile(editchannelImg.path,
        filename: editchannelImg.path.split("/").last);
    // filename: DateTime.now().millisecondsSinceEpoch.toString());
  }
  print(data);
  dio.FormData formData = dio.FormData.fromMap(data);

  try {
    dio.Dio dio1 = dio.Dio();
    dio.Response response = await dio1.post(
      "$baseUrl/edit-Channel",
      data: formData,
      options: dio.Options(
        headers: {
          "Accept": "application/json",
          "authorization": "Bearer $token"
        },
      ),
    );
    if (response.statusCode == 200) {
      print("200");
      print(response.data);
    } else {
      print(response.data.toString());
    }
  } catch (e) {
    print("error");
    print(e.toString());
  }
}

Future uploadContent(contentTitle, contentdesc, File? content, id) async {
  var token = await getToken();
  final data;
  if (content != null) {
    data = {
      'channelId': id,
      'contentTitle': contentTitle,
      'contentDescription': contentdesc,
      'content': await dio.MultipartFile.fromFile(content.path,
          filename: content.path.split('/').last),
    };
  } else {
    data = {
      'channelId': id,
      'contentTitle': contentTitle,
      'contentDescription': contentdesc,
    };
  }
  print(data);
  dio.FormData formData = dio.FormData.fromMap(data);

  try {
    dio.Dio dio1 = dio.Dio();
    dio.Response response = await dio1.post(
      "$baseUrl/add-Content",
      data: formData,
      options: dio.Options(
        headers: {
          "Accept": "application/json",
          "authorization": "Bearer $token"
        },
      ),
    );
  } catch (e) {
    print("ERROR");
    print(e.toString());
  }
}

Future getSubscriptionDetails() async {
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());

  subscriptionController.isloading.value = true;

  print("get subscription");
  var token = await getToken();
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/get-Subscription-details'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "authorization": "Bearer $token"
      },
    );
    if (response.statusCode == 200) {
      List<Subscription> data =
          SubscriptionModel.fromJson(jsonDecode(response.body)).data;
      subscriptionController.subsctiptionList.clear();
      data.forEach((item) {
        if (item.status) {
          if (item.isActive) {
            subscriptionController.subsctiptionList.add(item);
          }
        }
      });
    } else {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
    }
  } catch (e) {
    print("error");
    print(e.toString());
  }
}

Future getSubscriptionBYId() async {
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  print("get subscription by Id");
  var token = await getToken();
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/get-Subscription-By-Id'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "authorization": "Bearer $token"
      },
    );
    if (response.statusCode == 200) {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
      var type = responsedata["data"]["type"];
      var lastdt = responsedata["data"]["userId"][0]["toDate"];
      var subscribelastdate = DateFormat("dd MMMM yyyy").format(
        DateTime.parse(lastdt),
      );
      subscriptionController.subscriptionmsg.value =
          "Your $type subscription will expire on $subscribelastdate";
    } else {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
    }
  } catch (e) {
    print(e.toString());
  }
}

Future editContent(
  like,
  id,
  userID, {
  String comment = "",
}) async {
  var token = await getToken();
  // var userId = await getuserid();

  final data = {'likes': like, "contentId": id, "userID": userID};

  if (comment != "") {
    data["comments"] = comment;
  }

  print("edit data $data");
  dio.FormData formData = dio.FormData.fromMap(data);
  try {
    dio.Dio dio1 = dio.Dio();
    dio.Response response = await dio1.post(
      "$baseUrl/edit-Content",
      data: formData,
      options: dio.Options(
        headers: {
          "Accept": "application/json",
          "authorization": "Bearer $token"
        },
      ),
    );
    if (response.statusCode == 200) {
      print("edit content 200");
      // print(response.data);
      if (comment != "") {
        getCommentsBYId(id);
      } else {
        getChannelDetails();
        getContent();
      }
      print(response.data);
    } else {
      print(response.data.toString());
    }
  } catch (e) {
    print("error");
    print(e.toString());
  }
}

Future addSubscription(subId) async {
  SubscriptionController subscriptionController = Get.find();
  var token = await getToken();
  try {
    final response = await http.post(Uri.parse('$baseUrl/add-subscription'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          "authorization": "Bearer $token"
        },
        body: json.encode({
          "subscriptionId": subId,
        }),
        encoding: Encoding.getByName('utf-8'));

    if (response.statusCode == 200) {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
    } else {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
      showCustomSnackBar(responsedata["response_data"]);
    }
  } on SocketException {
    return "No Internet connection";
  } on TimeoutException {
    throw TimeoutException('Connection Time Out!');
  } catch (e) {
    showCustomSnackBar("Something went wrong!");
  }
}

Future getCommentsBYId(contentId) async {
  CommentController commentcontroller = Get.put(CommentController());
  commentcontroller.commentMsg.value = "";
  print("get comments by Id");
  var token = await getToken();
  try {
    final response = await http.post(Uri.parse('$baseUrl/get-CommentsById'),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "authorization": "Bearer $token"
        },
        body: json.encode({
          "contentId": contentId,
        }),
        encoding: Encoding.getByName('utf-8'));
    if (response.statusCode == 200) {
      print("get comts by ID");
      print(jsonDecode(response.body));
      var jsondata = CommentModel.fromJson(jsonDecode(response.body));
      commentcontroller.commentdataList.value = jsondata.data!;
      print(commentcontroller.commentdataList.length);
      if (commentcontroller.commentdataList.isEmpty) {
        commentcontroller.commentMsg.value = "No comments Found!";
      }
    } else {
      var responsedata = jsonDecode(response.body);
      print(responsedata);
    }
  } catch (e) {
    print(e.toString());
  }
}
