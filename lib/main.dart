import 'package:flutter/material.dart';
import 'package:listview_builder/create_task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<Task> task=[
    Task(title: 'Adnan', description: 'I am a student', date: DateTime.now()),
    Task(title: 'Farhan', description: 'I am a student', date: DateTime.now()),
    Task(title: 'Talha', description: 'I am a student', date: DateTime.now()),
    Task(title: 'Ahmad', description: 'I am a student', date: DateTime.now()),
    Task(title: 'Hamza', description: 'I am a student', date: DateTime.now()),
    Task(title: 'Hanan', description: 'I am a student', date: DateTime.now()),


  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView.Builder'),leading: Icon(Icons.account_box_outlined),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          Task? response= await  Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageTask()));
          if(response !=null){
            print('Task details');
            print("Task name : ${response.title}");
            print("Task description : ${response.description}");
            print("Task datetime : ${response.date}");
            task.add(response);
            setState(() {});
          }
          print("user is back from create task page");
        }
        ,child: Icon(Icons.add),),
      body: ListView.builder(
          itemCount: task.length,

          itemBuilder: (BuildContext context, i){
            Task _task = task[i];
            return ListTile(

              onTap: () async{
             Task? updatedTask= await  Navigator.push(context, MaterialPageRoute(builder: (context)=> ManageTask(task: _task) ));
             if(updatedTask!=null){
               task[i] = updatedTask;
               setState(() {});
             }
              },
                leading: Text((i+1).toString()),
                title:Text(task[i].title),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task[i].description),
                  Text(task[i].date.toIso8601String()),
                ],
              ),
             trailing: IconButton(
               icon: Icon(Icons.delete),
               onPressed: (){
                task.removeAt(i);
                setState(() {

                });
               },
             ),

            );
          }),
    );
  }
}

class Task{
  String title;
  String description;
  DateTime date;
  Task({required this.title,required this.description,required this.date});

}
