import 'package:flutter/material.dart';
import 'package:task_manager/src/constants/assets_constant.dart';
import 'package:task_manager/src/constants/color_constants.dart';
import 'package:task_manager/src/constants/string_constants.dart';
import 'package:task_manager/src/res/dimensions/dimensions.dart';
import 'package:task_manager/src/res/theme/text_styles.dart';
import 'package:task_manager/src/services/firebase_auth_service.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.firebaseNavy,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimens.px16,
            right: Dimens.px16,
            bottom: Dimens.px20,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Image.asset(
                          AssetsConstant.firebaseLogo,
                          height: Dimens.px160,
                        ),
                      ),
                      const SizedBox(height: Dimens.px20),
                      Text(
                        KString.flutterFire,
                        style: osTextStyle40Medium.copyWith(
                          color: KColors.firebaseYellow,
                        ),
                      ),
                      Text(
                        KString.authentication,
                        style: osTextStyle40Medium.copyWith(
                          color: KColors.firebaseOrange,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildSignInButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() => OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(KColors.whiteColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.px40),
            ),
          ),
        ),
        onPressed: () async {
        await  FirebaseAuthService().signInWithGoogles();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.px0, Dimens.px10, Dimens.px0, Dimens.px10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                AssetsConstant.googleLogo,
                height: Dimens.px35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: Dimens.px10),
                child: Text(
                  KString.signInWithGoogle,
                  style: osTextStyle18SemiBold.copyWith(color: KColors.black54),
                ),
              )
            ],
          ),
        ),
      );
}
