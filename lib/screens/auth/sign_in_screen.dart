import 'package:flutter_diablo2_exchange/index.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  ScrollController _scrollController = ScrollController();
  TextEditingController idTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    idTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!GetPlatform.isMobile) {
      // After 1 second, it takes you to the bottom of the ListView
      Timer(Duration(seconds: 1), () async {
        if (_scrollController.hasClients) {
          await _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease);
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/sign_in_background.jpg'),
              ),
            ),
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                SizedBox(
                  height: 650,
                ),
                InputField(
                  autofocus: true,
                  label: "아이디",
                  content: "아이디를 입력해주세요.",
                  onChanged: (value) {
                    print('id:$value');
                  },
                  onFieldSubmitted: (value) {
                    print(value);
                  },
                  validator: customIdValidate,
                  inputFormatters: idTextInputFormatter,
                  textInputAction: TextInputAction.next,
                  controller: idTextController,
                  suffixIcon: IconButton(
                    onPressed: idTextController.clear,
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey[600]!,
                    ),
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                InputField(
                  label: "비밀번호",
                  content: "비밀번호를 입력해주세요.",
                  onChanged: (value) {
                    print('password:$value');
                  },
                  onFieldSubmitted: (value) {
                    print(value);
                  },
                  obscureText: true,
                  validator: customPasswordValidate,
                  textInputAction: TextInputAction.done,
                  controller: passwordTextController,
                  suffixIcon: IconButton(
                    onPressed: passwordTextController.clear,
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey[600]!,
                    ),
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey[350]!),
                            ),
                            onPressed: () {
                              //로그인 정보 확인 후 정보 받아오기
                              Get.find<UserController>().signin(
                                loginId2: 'betrider',
                                phoneNumber2: '01055254256',
                                battleTagId2: 'betrider#12345',
                                diabloId2: '베트라이더',
                              );

                              if (true) {
                                //로그인 성공 시
                                Get.back();
                                showToast(message: '성공적으로 로그인되었습니다.');
                                // ignore: dead_code
                              } else {
                                showToast(message: '로그인에 실패했습니다.');
                              }
                            },
                            child: Text('로그인'.tr,
                                style: AppTextStyle.white_14_w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey[350]!),
                          ),
                          onPressed: () {
                            Get.toNamed('sign_up');
                          },
                          child: Text(
                            '계정 찾기'.tr,
                            style: AppTextStyle.white_14_w400,
                          ),
                        ),
                      ),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey[350]!),
                          ),
                          onPressed: () {
                            Get.toNamed('sign_up');
                          },
                          child: Text('새로운 계정 만들기'.tr,
                              style: AppTextStyle.white_14_w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
