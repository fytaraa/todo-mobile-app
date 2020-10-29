import 'package:flutter/material.dart';
import 'package:flutter_test1/src/model/task_model.dart';
import 'package:http/http.dart' as http;

class OnlineTask extends StatefulWidget {
  @override
  _OnlineTaskState createState() => _OnlineTaskState();
}

class _OnlineTaskState extends State<OnlineTask> {
  int totalTask;
  List<TaskModel> tasks = List();
  bool checkboxValue = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Task"),
      ),
      body: Column(
        children: [
          Text("there is some notes"),
          ListView.builder(
            shrinkWrap: true,
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
                      Checkbox(
                        value: checkboxValue,
                        onChanged: (value) {
                          setState(() {
                            checkboxValue = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tasks[index].title,
                              style: TextStyle(fontSize: 16.0)),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(tasks[index].description,
                              style: TextStyle(fontSize: 12.0))
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_forever),
                        color: Colors.red,
                        onPressed: () {

                        },
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: tasks.length,
          )
        ],
      )
    );
  }

  loadData(){
    TaskModel newTask = new TaskModel("hello", "some description");
    TaskModel newTask1 = new TaskModel("hello", "some description");
    TaskModel newTask2 = new TaskModel("hello", "some description");
    TaskModel newTask3 = new TaskModel("hello", "some description");

    tasks.add(newTask);
    tasks.add(newTask1);
    tasks.add(newTask2);
    tasks.add(newTask3);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    getData();
  }
  getData() async {
    var url = 'https://jsonplaceholder.typicode.com/posts';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
