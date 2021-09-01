import 'package:flutter_diablo2_exchange/index.dart';

bool isDebug() => kDebugMode;
bool isRelease() => kDebugMode;

dynamic getCache() async => await Hive.openBox('cache');

// 앱이 구동중인 플랫폼을 확인
// GetPlatform.isAndroid
// GetPlatform.isIOS
// GetPlatform.isMacOS
// GetPlatform.isWindows
// GetPlatform.isLinux
// GetPlatform.isFuchsia

// 장치 타입을 확인
// GetPlatform.isMobile
// GetPlatform.isDesktop
// 모든 플랫폼은 독립적으로 웹을 제공합니다!
// Windows, iOS, OSX, Android 등의
// 브러우저에서 구동중이면 알 수 있습니다.
// GetPlatform.isWeb

/// 가로사이즈
// Get.width
/// 세로사이즈
// Get.height

/// Navigator의 현재 context를 제공
// Get.context

/// 코드 어디에서든지 foreground에서 snackbar/dialog/bottomsheet의 context를 제공
// Get.overlayContext

/// 장치의 가로 모드 확인
// context.isLandscape()

/// 장치의 세로 모드 확인
// context.isPortrait()

enum UrlType {
  INTERNET,
  TEL,
  SMS,
  EMAIL,
}

extension UrlTypeExtension on UrlType {
  String get name {
    switch (this) {
      case UrlType.INTERNET:
        return "인터넷";
      case UrlType.TEL:
        return "전화번호";
      case UrlType.SMS:
        return "문자";
      case UrlType.EMAIL:
        return "이메일";
    }
  }
}

/// URL연결(인터넷,전화,문자,이메일)
///
/// ```dart
/// url:'www.naver.com', urlType:UrlType.INTERNET -> 'https://www.naver.com'
/// url:'01012345678', urlType:UrlType.TEL -> 'tel:01012345678'
/// url:'01023456789', urlType:UrlType.SMS, body:'내용 -> 'sms:01023456789?body=내용'
/// url:'www.naver.com', urlType:UrlType.EMAIL, subject:'제목', body:'내용' -> 'mailto:www.naver.com?subject=제목&body=내용'
/// ```
///
Future<void> urlLauncher({
  required String url,
  required UrlType urlType,

  ///이메일 제목
  String subject = '제목 입력부분입니다.',

  ///이메일&문자 내용
  String body = '내용 입력부분입니다.',
}) async {
  switch (urlType) {
    case UrlType.INTERNET:
      await launch(
        'https://$url',
      );
      break;
    case UrlType.TEL:
      await launch('tel:$url');
      break;
    case UrlType.SMS:
      await launch(
          'sms:$url?body=$body'); //'sms:+39 348 060 888?body=hello%20there';
      break;
    case UrlType.EMAIL:
      await launch(
          'mailto:$url?subject=$subject&body=$body'); //<email address>?subject=<subject>&body=<body>
      break;
  }
}

/// 이미지 가지고오기(단일모드)
///
/// ImageSource.camera : 사진
///
/// ImageSource.gallery : 갤러리
///
Future<String> getImagePath({
  required ImageSource imageSource,
  int aspectRatioX = 1,
  int aspectRatioY = 1,
  bool useCrop = false,
}) async {
  String? filePath;

  XFile? pickedFile = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 100,
  );

  if (pickedFile == null) return '';

  filePath = pickedFile.path;

  return filePath;
}