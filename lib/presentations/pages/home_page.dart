import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reno_music/presentations/widgets/action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Column(
        children: [
          Text('home'),
          ActionButton(onPressed: ()async{
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('token');
          }, label: Text('delete'), icon: Icon(Icons.delete)),


          ActionButton(onPressed: ()async{
            final storage = new FlutterSecureStorage();
            await storage.deleteAll();
          }, label: Text('secure'), icon: Icon(Icons.delete))
        ],
      ),),
    );
  }
}
