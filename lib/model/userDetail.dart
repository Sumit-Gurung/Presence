class UserDetails {
  final String name;
  final String email;
  final String phoneNumber;
  final String? imagePath;

  UserDetails(
      {required this.name, required this.email, required this.phoneNumber, this.imagePath});
}
