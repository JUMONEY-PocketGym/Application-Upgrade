import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pock_gym/api/apiVal.dart';
import 'package:pock_gym/api/model/auth/login_response.dart';
import 'package:pock_gym/api/model/auth/register_response.dart';
import 'package:pock_gym/api/model/error_response.dart';
import 'package:pock_gym/api/model/video/video_upload_pre_response.dart';
import 'package:pock_gym/ui/intro/splash/controller/splash_controller.dart';
import 'package:pock_gym/ui/mainPage/subPage/myPage/profile/walletPassword/model/check_wallet_password_response.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/details/soloDetailPages/controller/model/quest_buy_response.dart';
import 'package:pock_gym/utils/debug_print.dart';
import 'package:pock_gym/utils/image/image_upload.dart';
import 'package:pock_gym/utils/toast/bottom_toast.dart';
import 'package:pock_gym/val/color.dart';

var phoneCertUrl = 'https://api.iamport.kr/';

class RemoteServicePost {
  static var client = http.Client();

  static Future<LoginResponse?> login(String email, String password) async {
    String apiUrlPath = apiURL + "auth/user/login";

    var header = {
      "Content-Type": "application/json",
    };

    var data = jsonEncode({"email": email, "password": password});
    var response = await client.post(Uri.parse(apiUrlPath), body: data, headers: header);

    var result = response.body;

    print("login Response :: " + result);

    if (response.statusCode >= 400) {
      ErrorResponse ev = ErrorResponse.fromJson(jsonDecode(result));
      showBotToast(ev.message!, toastColor, Alignment.bottomCenter, 1);
    }

    return response.statusCode < 400 ? loginResponseFromJson(result) : null;
  }

  static Future<RegisterResponse?> registerUser(var data) async {
    String apiUrlPath = apiURL + "users/register";

    var header = {
      "Content-Type": "application/json",
    };
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    print("registerUser :: " + result);
    return response.statusCode < 400 ? registerResponseFromJson(result) : null;
  }

  static Future<String> imageUpload(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    File? file = await pickProfilePicture(source);
    File decompressImage = await compressToJpeg(file!);
    String fileExtension = decompressImage.path.split(".").last;
    List<int> imageBytes = decompressImage.readAsBytesSync();

    String base64File = base64Encode(imageBytes);

    String apiUrlPath = "http://54.180.40.23:8080/api/v1/s3/upload";

    var header = {
      "Content-Type": "application/json",
    };
    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode({
          "data": [base64File],
          "extension": [fileExtension],
          "thumbnail": false,
        }),
        headers: header);

    var result = jsonDecode(response.body);

    print("CHECK123:: " + response.statusCode.toString());
    print("CHECK123:: " + result[0]);

    return response.statusCode < 400 ? result[0] : null;
  }

  static Future<List<dynamic>?> imageMultiUpload(List<String> base64File, List<String> fileExtension) async {
    String apiUrlPath = "http://54.180.40.23:8080/api/v1/s3/upload";

    var header = {
      "Content-Type": "application/json",
    };
    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode({
          "data": base64File,
          "extension": fileExtension,
          "thumbnail": false,
        }),
        headers: header);

    var result = jsonDecode(response.body);

    print("CHECK123:: " + response.statusCode.toString());
    print("CHECK123:: " + jsonEncode(result));

    return response.statusCode < 400 ? result : null;
  }

  static recordUpload(String uploadType, String uid, dynamic data) async {
    String apiUrlPath = apiURL + "records/$uploadType";

    var header = {"Content-Type": "application/json", "uid": uid};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    print("recordUpload Response :: " + result);
    return response.statusCode < 400 ? result : null;
  }

  static updateUser(var data) async {
    String apiUrlPath = apiURL + "users/update-profile";

    SplashController sc = Get.find();

    print(jsonEncode(data));

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.put(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    print("updateUser :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  static disabledMembership() async {
    String apiUrlPath = apiURL + "users/disabled-membership";

    SplashController sc = Get.find();

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.put(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("disabledMembership :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  static widthrawPPT(var data) async {
    String apiUrlPath = apiURL + "point/exchangeToken";

    SplashController sc = Get.find();

    print(jsonEncode(data));

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    print("updateUser :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  static widthrawKRW(var data) async {
    String apiUrlPath = apiURL + "point/exchangeKRW";

    SplashController sc = Get.find();

    print(jsonEncode(data));

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    print("updateUser :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  static customerInquiry(var data) async {
    String apiUrlPath = apiURL + "other/customerInquiry";

    SplashController sc = Get.find();

    print(jsonEncode(data));

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    print("updateUser :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  static point(var data) async {
    String apiUrlPath = apiURL + "point/charge";

    SplashController sc = Get.find();

    print(jsonEncode(data));

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    print("point :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  static membershipConfirm(var data) async {
    String apiUrlPath = apiURL + "payment/membership-confirm";

    SplashController sc = Get.find();

    dPrint(jsonEncode(data));

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    dPrint("point :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  static membershipKcalConfirm(var data) async {
    String apiUrlPath = apiURL + "payment/membership/kcal";

    SplashController sc = Get.find();

    print(jsonEncode(data));

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    print("point :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  static getCertificationPhone() async {
    String apiUrlPath = phoneCertUrl + "users/getToken";

    var header = {
      "Content-Type": "application/json",
    };
//MsfdACs6Tk
    var body = {"imp_key": "7417784262382793", "imp_secret": "f35f26595fc870d33ce2cdafa835de5ee51682b753df5e82606d27a9cf1485bf68f6c4b616df7cef"};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(body), headers: header);

    var result = response.body;

    print("getCertificationPhoneInfo Response :: " + result);
    return response.statusCode < 400 ? result : null;
  }

  // certification phone info
  static getCertificationPhoneInfo(String uid, String accessToken) async {
    String apiUrlPath = phoneCertUrl + "certifications/$uid";

    var header = {"Content-Type": "application/json", 'Authorization': accessToken};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getCertificationPhoneInfo Response :: " + result);
    return response.statusCode < 400 ? result : null;
  }

  static Future<QuestBuyResponse?> questBuy(var data) async {
    String apiUrlPath = apiURL + "payment/quest";

    SplashController sc = Get.find();

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    print("questBuy :: " + result);
    return response.statusCode < 400 ? questBuyResponseFromJson(result) : null;
  }

  static questDrop(var data) async {
    String apiUrlPath = apiURL + "quest/giveup";

    SplashController sc = Get.find();

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    print("questDrop :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  static questRecordCertfication(var data) async {
    String apiUrlPath = apiURL + "quest/record-certification";

    SplashController sc = Get.find();

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    dPrint("questRecordCertfication :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  static Future<VideoUploadPreModel?> questRecordCertficationVideoPre(var data) async {
    String apiUrlPath = "http://43.201.12.204/api/v1/s3/certification-video-request";

    SplashController sc = Get.find();

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    dPrint("questRecordCertficationVideoPre :: " + result);
    return response.statusCode < 400 ? videoUploadPreModelFromJson(result) : null;
  }

  static questRecordCertficationVideo(File videoFile, var data) async {
    String apiUrlPath = "http://43.201.12.204/api/v1/s3/certification-video-file-upload";

    SplashController sc = Get.find();

    var header = {"uid": sc.userProfileInfo.value.uid.toString()};

    var request = http.MultipartRequest('POST', Uri.parse(apiUrlPath));
    request.headers.addAll(header);
    request.fields['data'] = json.encode(data);

    // Add file to request
    var file = await http.MultipartFile.fromPath('file', videoFile.path);
    request.files.add(file);

    // Send the request
    var response = await request.send();

    // Handle the response

    dPrint(response.statusCode);
    // if (response.statusCode == 200) {
    //   dPrint('File uploaded successfully');
    // } else {
    //   dPrint('Error uploading file');
    // }
    // print("questRecordCertficationVideo :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  static questRecordCertficationImage(File imageFile) async {
    String apiUrlPath = "http://54.180.40.23:8080/api/v1/s3/multipart/image-upload";

    SplashController sc = Get.find();

    // var header = {"uid": sc.userProfileInfo.value.uid.toString()};

    var request = http.MultipartRequest('POST', Uri.parse(apiUrlPath));
    // request.headers.addAll(header);
    // request.fields['data'] = json.encode(data);

    // Add file to request
    var file = await http.MultipartFile.fromPath('file', imageFile.path);
    request.files.add(file);

    // Send the request
    var response = await request.send();

    final responseJson = await response.stream.bytesToString();
    final jsonResponse = json.decode(responseJson);

    // 응답 데이터 확인
    dPrint(jsonEncode(jsonResponse));
    final imageUrl = jsonResponse['result'];

    // Handle the response

    dPrint(response.statusCode);
    // if (response.statusCode == 200) {
    //   dPrint('File uploaded successfully');
    // } else {
    //   dPrint('Error uploading file');
    // }
    // print("questRecordCertficationVideo :: " + result);
    return response.statusCode < 400 ? imageUrl : null;
  }
  // static questRecordCertficationVideo(var data) async {
  //   String apiUrlPath = "http://43.201.12.204/api/v1/s3/certification-video-upload";

  //   SplashController sc = Get.find();

  //   var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
  //   var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

  //   var result = response.body;

  //   print("questRecordCertficationVideo :: " + result);
  //   return response.statusCode < 400 ? true : null;
  // }

  static checkWalletPassword(var data) async {
    String apiUrlPath = apiURL + "auth/wallet/password";

    SplashController sc = Get.find();

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    dPrint("checkWalletPassword :: " + result);
    return response.statusCode < 400 ? true : false;
  }

  static deleteNoteRecord(String recordUid) async {
    String apiUrlPath = apiURL + "users/record/$recordUid";

    SplashController sc = Get.find();

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.delete(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("questRecordCertfication :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  static questReview(var data) async {
    String apiUrlPath = apiURL + "quest/review";

    SplashController sc = Get.find();

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.post(Uri.parse(apiUrlPath), body: jsonEncode(data), headers: header);

    var result = response.body;

    dPrint("questReview :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  static secessionUser() async {
    String apiUrlPath = apiURL + "auth/user/secession";

    SplashController sc = Get.find();

    var header = {"Content-Type": "application/json", "uid": sc.userProfileInfo.value.uid.toString()};
    var response = await client.post(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    dPrint("questReview :: " + result);
    return response.statusCode < 400 ? true : null;
  }
}
