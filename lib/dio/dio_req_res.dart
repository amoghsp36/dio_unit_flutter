

import 'package:dio/dio.dart';
import 'package:dio_prac/dio/model.dart';

class DIOReqRes {
  final Dio client;
  DIOReqRes(this.client);
  //Dio dio = Dio();
  CancelToken cancelToken = CancelToken();

  Future<List<User>> getData() async {
    try {
      final res = await client.get('https://jsonplaceholder.typicode.com/posts', cancelToken: cancelToken);
      final list = res.data as List;
      if (res.statusCode != 200) {
        print(res);
      }
      //print(res.data.toString());
      return list
          .map((e) => User(
              userId: e['userId'],
              id: e['id'],
              title: e['title'],
              body: e['body']))
          .toList();
    } on DioException catch (e) {
      if(e.type == DioExceptionType.cancel){
        print('request cancelled : ${e.message}');
      }
      else{
        print('${e.message}');
      }
      throw 'unknown error occured';
      
    }
  }

  void onChanged(){
    cancelToken.cancel('get request cancelled by user');
  }

  void postData() async {
    try {
      final res2 =
          await client.post('https://api.escuelajs.co/api/v1/products/', data: {
        "title": "New Product",
        "price": 12,
        "description": "A description",
        "categoryId": 1,
        "images": ["https://placeimg.com/640/480/any"]
      });
      print(res2.headers);
      print(res2.requestOptions.data);
      print(res2.statusCode);
      print(res2.data);
    } catch (e) {
      throw 'unknown error occured';
    }
  }

  
}

// void main() {
//   DIOReqRes dioReqRes = DIOReqRes();
//   dioReqRes.postData();
// }
