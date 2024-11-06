
import 'package:dio/dio.dart';
import 'package:dio_prac/dio/dio_req_res.dart';
import 'package:dio_prac/dio/new_page.dart';
import 'package:flutter/material.dart';

class DioView extends StatelessWidget {
  const DioView({super.key});


  

  @override
  Widget build(BuildContext context) {
    DIOReqRes dioReqRes = DIOReqRes(Dio());
    //final te = DIOReqRes().getData();
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NextPage()));
        dioReqRes.onChanged();
      }),
      body: Column(
        children: [
          FutureBuilder(future: dioReqRes.getData(), builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            else if(snapshot.hasError){
              return Center(child: Text('${snapshot.error}'),);
            }
            else if(!snapshot.hasData || snapshot.data!.isEmpty){
              return const Center(child: Text('No Data Found'),);
            }
            final dat = snapshot.data!;
            return Expanded(
              child: ListView.builder(itemBuilder: (context, index){
              final da = dat[index];
              return ListTile(
                title: Text(da.title),
                subtitle: Text(da.body),
                leading: Text('${da.userId}'),
              );
                        }),
            );
          })
        ],
      ),
    );
  }


}