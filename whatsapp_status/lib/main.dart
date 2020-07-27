import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsappstatus/data/status_view_model.dart';
import 'all_tabs.dart';
import 'models/checkStoragePermission.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PermissionCheck().checkStoragePermission();
  runApp(WhatsAppStatus());
}

class WhatsAppStatus extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        title: 'Status Keeper',
        theme: ThemeData.dark().copyWith(
            primaryColor: Colors.lightGreen,
            indicatorColor: Colors.lightGreen,
            primaryColorLight: Colors.lightGreen,
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.lightGreenAccent
          )
        ),
        home: DefaultTabController(
          length: 3,
          child: Tabs(),
        )
    );
  }


}





