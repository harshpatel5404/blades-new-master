import 'package:blades/utils/colors.dart';
import 'package:blades/widgets/app_button.dart';
import 'package:blades/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../services/api_services.dart';
import '../utils/dimentions.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController bioController = TextEditingController(text: "");
  TextEditingController infoController = TextEditingController(text: "");
  TextEditingController msgController = TextEditingController(text: "");
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var selectedText = 0;

  @override
  Widget build(BuildContext context) {
    List profiles = [
      {
        "name": "Name",
        "controller": nameController,
        "icon": "person",
        "hint": "Name"
      },
      {
        "name": "Email",
        "controller": emailController,
        "icon": "contactemail",
        "hint": "Email"
      },
      {
        "name": "Bio",
        "controller": bioController,
        "icon": "contactcall",
        "hint": "Bio"
      },
      {
        "name": "Practice Info",
        "controller": infoController,
        "icon": "contactcall",
        "hint": "Practice Info"
      },
      {
        "name": "Message",
        "controller": msgController,
        "icon": "contactcall",
        "hint": "Message"
      },
    ];
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(Get.height * 0.165), // here the desired height
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04, vertical: Get.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Card(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide: const BorderSide(
                                width: 0, color: Colors.white)),
                        elevation: 3.5,
                        child: Padding(
                            padding: EdgeInsets.all(Get.width * 0.02),
                            child: const Icon(Icons.arrow_back)),
                      ),
                    ),
                    Container(
                      height: mHeight * 0.07,
                      child: Image.asset(
                        "assets/icons/logo.png",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.12,
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.width * 0.02,
                ),
                Container(
                  child: Text(
                    " Contact",
                    style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w500,
                        color: kBlack.withOpacity(0.8)),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(Get.width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "You can contact us on the following email address and phone number.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15, height: 1.5, color: Color(0xff808080)),
                ),
                SizedBox(height: Get.height * 0.04),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/email.svg",
                      height: Get.height * 0.04,
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    const Text(
                      "johndoe@gmail.com",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.03),
                const Divider(
                  color: Colors.white30,
                ),
                SizedBox(height: Get.height * 0.02),
                const Text(
                  "Connect with Us",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: Get.height * 0.04),
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: mHeight * 0.03,
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profiles.length,
                  itemBuilder: (BuildContext context, int index) {
                    var thisController = profiles[index]["controller"];
                    return TextFormField(
                      controller: thisController,
                      decoration: InputDecoration(
                          hintText: profiles[index]["name"],
                          // prefixIcon: index == 3
                          //     ? Icon(
                          //         Icons.message,
                          //         size: 30,
                          //       )
                          //     : Padding(
                          //         padding: EdgeInsets.all(mWidth * 0.03),
                          //         child: SvgPicture.asset(
                          //           "assets/icons/${profiles[index]["icon"]}.svg",
                          //           height: mWidth * 0.02,
                          //           width: mWidth * 0.02,
                          //         ),
                          //       ),
                          border: UnderlineInputBorder()),
                      keyboardType: TextInputType.text,
                    );

                    // return index == selectedText
                    //     ? Container(
                    //         alignment: Alignment.center,
                    //         height:
                    //             index == 3 ? mHeight * 0.15 : mHeight * 0.075,
                    //         child: TextFormField(
                    //           controller: profiles[index]["controller"],
                    //           cursorColor: kBlack,
                    //           autofocus: true,
                    //           maxLines: index == 3 ? 4 : 1,
                    //           decoration: InputDecoration(
                    //               contentPadding:
                    //                   const EdgeInsets.only(top: 10),
                    //               prefixIcon: Padding(
                    //                 padding: EdgeInsets.only(
                    //                     left: mWidth * 0.08,
                    //                     right: 10,
                    //                     top: 15,
                    //                     bottom: 20),
                    //                 child: index == 3
                    //                     ? SizedBox()
                    //                     : SvgPicture.asset(
                    //                         "assets/icons/${profiles[index]["icon"]}.svg",
                    //                         height: 20,
                    //                         width: 20,
                    //                         color: kBlack,
                    //                         fit: BoxFit.contain,
                    //                       ),
                    //               ),
                    //               border: OutlineInputBorder(
                    //                 borderRadius: index == 3
                    //                     ? BorderRadius.all(
                    //                         Radius.circular(20.0))
                    //                     : BorderRadius.all(
                    //                         Radius.circular(90.0)),
                    //                 borderSide: BorderSide(
                    //                   color: kBlack,
                    //                   width: 1,
                    //                 ),
                    //               ),
                    //               enabledBorder: OutlineInputBorder(
                    //                 borderRadius: index == 3
                    //                     ? BorderRadius.all(
                    //                         Radius.circular(20.0))
                    //                     : BorderRadius.all(
                    //                         Radius.circular(90.0)),
                    //                 borderSide: BorderSide(
                    //                   color: kBlack,
                    //                   width: 1,
                    //                 ),
                    //               ),
                    //               focusedBorder: OutlineInputBorder(
                    //                 borderRadius: index == 3
                    //                     ? BorderRadius.all(
                    //                         Radius.circular(20.0))
                    //                     : BorderRadius.all(
                    //                         Radius.circular(90.0)),
                    //                 borderSide: BorderSide(
                    //                   color: kBlack,
                    //                   width: 1,
                    //                 ),
                    //               ),
                    //               // labelText: profiles[index]["name"],
                    //               // labelStyle: const TextStyle(
                    //               //     color: Colors.black,
                    //               //     fontFamily: "Poppins"),
                    //               hintStyle: const TextStyle(
                    //                   color: Colors.grey,
                    //                   fontFamily: "Poppins"),
                    //               filled: true,
                    //               fillColor: kPrimaryColor,
                    //               hintText: profiles[index]["hint"]),
                    //         ),
                    //       )
                    //     : InkWell(
                    //         onTap: () {
                    //           setState(() {
                    //             selectedText = index;
                    //           });
                    //         },
                    //         child: Container(
                    //           alignment: Alignment.center,
                    //           decoration: BoxDecoration(
                    //               color: kWhite,
                    //               borderRadius: index == 3
                    //                   ? BorderRadius.circular(20)
                    //                   : BorderRadius.circular(90)),
                    //           height:
                    //               index == 3 ? mHeight * 0.15 : mHeight * 0.075,
                    //           width: mWidth,
                    //           padding: EdgeInsets.only(
                    //             left: mWidth * 0.08,
                    //           ),
                    //           child: Row(
                    //             children: [
                    //               index == 3
                    //                   ? SizedBox()
                    //                   : SvgPicture.asset(
                    //                       "assets/icons/${profiles[index]["icon"]}.svg",
                    //                       height: 20,
                    //                       width: 20,
                    //                       fit: BoxFit.contain,
                    //                       color: Color(0xff9E9E9E),
                    //                     ),
                    //               SizedBox(
                    //                 width: 8,
                    //               ),
                    //               Container(
                    //                 width: mWidth * 0.7,
                    //                 child: Text(
                    //                   thisController.text == ""
                    //                       ? profiles[index]["name"]
                    //                       : thisController.text,
                    //                   overflow: TextOverflow.ellipsis,
                    //                   maxLines: 4,
                    //                   style: TextStyle(
                    //                       color: Color(0xff9E9E9E),
                    //                       fontSize: 15),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: mWidth * 0.05),
                    child: AppButton(
                      onpress: () {
                        _contactUs();
                      },
                      btntext: "Submit",
                      textcolor: const Color(0xffF4FAFF),
                      btncolor: kSecondaryColor,
                      heights: mHeight * 0.07,
                      btnfontsize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _contactUs() async {
    String _name = nameController.text.trim();
    // String _phonenumber = phoneController.text.trim();
    String _email = emailController.text.trim();
    String bio = bioController.text.trim();
    String info = infoController.text.trim();
    String _msg = msgController.text.trim();

    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";

    RegExp emailvalidation = RegExp(pattern);
    if (_name.isEmpty) {
      showCustomSnackBar('Enter Your Name');
    } else if (_email.isEmpty) {
      showCustomSnackBar('Enter Your Email');
    } else if (!emailvalidation.hasMatch(_email)) {
      showCustomSnackBar('Enter a valid email address');
    } else if (_msg.isEmpty) {
      showCustomSnackBar('Enter Your Message');
    } else {
      contactUs(_name, _email, bio, info, _msg);
    }
  }
}
