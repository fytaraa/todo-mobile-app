import 'package:flutter/material.dart';
import 'package:flutter_test1/src/widgets/task_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _descriptionController =
      new TextEditingController();
  List<String> keysList = List();
  int totalTask;
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addDialog();
        },
        child: Icon(Icons.add),
      ),
      body: Container(
          child: keysList.length != 0 && keysList != null
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.check_box_outline_blank,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(keysList[index], style: TextStyle(fontSize: 16.0)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(prefs.getString(keysList[index]), style: TextStyle(fontSize: 12.0))
                              ],
                            ),
                            IconButton(icon: Icon(Icons.delete_forever),color: Colors.red,onPressed: (){
                              prefs.remove(keysList[index]);
                              Toast.show("The note is deleted", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                              keysList.clear();
                              keysList = prefs.getKeys().toList();
                              totalTask = keysList.length;
                              setState(() {

                              });
                            },)
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: totalTask,
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void _addDialog() {
    Alert(
        style: AlertStyle(
          backgroundColor: Colors.white,
        ),
        context: context,
        title: "Add New Note",
        content: Column(
          children: <Widget>[
            TextField(
              enabled: true,
              maxLines: 1,
              textDirection: TextDirection.rtl,
              textInputAction: TextInputAction.done,
              style: TextStyle(color: Colors.black87, fontFamily: 'Hacen'),
//              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  FontAwesomeIcons.passport,
                  color: Theme.of(context).primaryColor,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Note Title',
                alignLabelWithHint: true,
                hintStyle: TextStyle(color: Colors.grey[400]),
                contentPadding: const EdgeInsets.only(
                    left: 4.0, right: 4.0, bottom: 10.0, top: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.7),
                ),
              ),
              controller: _titleController,
              onChanged: (val) {
                print('Dialog nid: ' + val);
              },
            ),
            TextField(
              enabled: true,
              maxLines: 1,
              textDirection: TextDirection.rtl,

              textInputAction: TextInputAction.done,
              style: TextStyle(color: Colors.black87, fontFamily: 'Hacen'),
//              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  FontAwesomeIcons.passport,
                  color: Theme.of(context).primaryColor,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Note Description',
                alignLabelWithHint: true,
                hintStyle: TextStyle(color: Colors.grey[400]),
                contentPadding: const EdgeInsets.only(
                    left: 4.0, right: 4.0, bottom: 10.0, top: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.7),
                ),
              ),
              controller: _descriptionController,
              onChanged: (val) {
                print('Dialog nid: ' + val);
              },
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              saveData(_titleController.text, _descriptionController.text);
              Navigator.of(context).pop();
              Toast.show("The note is deleted", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
            },
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  saveData(String title, String description) async {
    prefs.setString(title, description);
    keysList.clear();
    keysList = prefs.getKeys().toList();
    totalTask = keysList.length;
    setState(() {

    });
    print("Data is loaded ${prefs.getString(title)}");
  }

  loadData() async {
    prefs = await SharedPreferences.getInstance();
    keysList = prefs.getKeys().toList();
    totalTask = keysList.length;
  }
}
