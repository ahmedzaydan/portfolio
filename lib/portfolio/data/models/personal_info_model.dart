import '../../../utils/assets_manager.dart';
import 'icon_model.dart';

class PersonalInfoModel {
  final String name;
  final String title;
  final String about;
  final String email;
  final String phone;
  final String location;
  final IconModel whatsApp;
  final IconModel linkedIn;
  final IconModel github;
  final String avatar;

  const PersonalInfoModel()
    : name = 'Ahmed Zaydan',
      title = 'Mobile Application Developer (Flutter)',
      about =
          'Flutter Developer and Computer Science graduate with hands-on experience building mobile applications across e-commerce, accounting, and marketing sectors. Skilled in developing clean, scalable applications using Flutter, Dart, and modern architectures like MVVM and Clean Architecture.',
      email = 'ahmedzaydan2901@gmail.com',
      phone = '+201147018108',
      location = '6th of October, Egypt',
      whatsApp = const IconModel(
        path: AssetsManager.whatsappSVG,
        url: 'https://wa.me/201147018108',
      ),
      github = const IconModel(
        path: AssetsManager.githubSVG,
        url: 'https://github.com/ahmedzaydan',
      ),
      linkedIn = const IconModel(
        path: AssetsManager.linkedinSVG,
        url: 'https://linkedin.com/in/ahmed-zaydan',
      ),
      avatar = AssetsManager.ahmedJPG;
}
