import '../components/constant.dart';

class UserDetails {
  final String name;
  final String email;
  final int id;
  final String phoneNumber;
  final String? profilePic;

  UserDetails({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profilePic,
    required this.id,
  });

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      id: map['id'] as int,
      email: map['email'] as String,
      name: map['name'],
      phoneNumber: map['phoneNumber'] as String,
      profilePic: (map['profilePic'] != null)
          ? Endpoints.url + map['profilePic']
          : 'https://www.havahart.com/media/wysiwyg/hh/cms/lc/mice/hh-animals-mouse-1.png',
    );
  }
}
