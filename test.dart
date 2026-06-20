import 'package:dio/dio.dart';
void main() async {
  final dio = Dio();
  try {
    final response = await dio.post(
      'http://mentalhelth.runasp.net/api/Auth/register',
      data: {
        'firstName': 'Test',
        'lastName': 'User',
        'phoneNumber': '01012345678',
        'email': 'testuser123456@example.com',
        'password': 'Password123!'
      },
    );
    print('SUCCESS: ');
  } catch (e) {
    print('ERROR MSG: ');
  }
}
