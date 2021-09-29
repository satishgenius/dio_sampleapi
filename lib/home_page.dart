import 'package:app_sample/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dio_client.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  final DioClient _client = DioClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: Center(
        child: FutureBuilder<User?>(
            future:_client.getUser(id: '2'),
            builder: (context, snapshot){
              if (snapshot.hasData) {
                User? userInfo = snapshot.data;
                if (userInfo != null) {
                  Data userData = userInfo.data;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(userData.avatar),
                      SizedBox(height: 10,),
                      Text(
                        '${userInfo.data.firstName} ${userInfo.data.lastName}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        userData.email,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  );
                }
              }
              return CircularProgressIndicator();
            },
        ),
      ),
    );
  }
}

// Future<User?> getUser({required String id}) async {
//   User? user;
//   try {
//     Response userData = await _dio.get(_baseUrl + '/users/$id');
//     print('User Info: ${userData.data}');
//     user = User.fromJson(userData.data);
//   } on DioError catch (e) {
//     // The request was made and the server responded with a status code
//     // that falls out of the range of 2xx and is also not 304.
//     if (e.response != null) {
//       print('Dio error!');
//       print('STATUS: ${e.response?.statusCode}');
//       print('DATA: ${e.response?.data}');
//       print('HEADERS: ${e.response?.headers}');
//     } else {
//       // Error due to setting up or sending the request
//       print('Error sending request!');
//       print(e.message);
//     }
//   }
//   return user;
// }