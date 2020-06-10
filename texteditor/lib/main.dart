import 'package:flutter/material.dart';
import 'package:texteditor/SaveFunctionality.dart';

void main(){
  runApp(
      MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
      ),
      home:Editor()
  )
  );
}

class Editor extends StatefulWidget {
  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {

  String userEnteredData='Text Goes Here';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Text Editor'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: AppBar().preferredSize.height,
              child: Center(
                child: Text('Editor Options',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
            ),
            ListTile(
              leading: Icon(Icons.save),
              title: Text('Save'),
              onTap: (){
                SaveOption saveOption=SaveOption();
                saveOption.save(context,userEnteredData);
              },
            ),
            ListTile(
              leading: Icon(Icons.folder_open),
              title: Text('Open'),
              onTap: () async {
                String temp= await FileStorage('mno.txt').readContent();
                print(temp);
                setState(() {
                  userEnteredData=temp;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.add_box),
              title: Text('New'),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(Icons.content_cut),
              title: Text('Cut'),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(Icons.content_copy),
              title: Text('Copy'),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(Icons.content_paste),
              title: Text('Paste'),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(Icons.find_in_page),
              title: Text('Find'),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(Icons.find_replace),
              title: Text('Replace'),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(Icons.undo),
              title: Text('Undo'),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(Icons.redo),
              title: Text('Redo'),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(Icons.close),
              title: Text('Close'),
              onTap: (){

              },
            ),
          ],
        ),
      ),
      body: Container(
        child: TextField(
          style: TextStyle(
              fontSize: 20.0
          ),
          maxLines: null,
          keyboardType:TextInputType.multiline,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: userEnteredData,
          ),
          onChanged: (value){
            userEnteredData=value;
          },
        ),
      ),
    );
  }
}

