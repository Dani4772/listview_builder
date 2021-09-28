import 'package:flutter/material.dart';

import 'main.dart';

class ManageTask extends StatefulWidget {
  final Task? task;
  const ManageTask({Key? key,this.task}) : super(key: key);

  @override
  _ManageTaskState createState() => _ManageTaskState();
}

class _ManageTaskState extends State<ManageTask> {
  var formKey = GlobalKey<FormState>();
  var title = TextEditingController();
  var description = TextEditingController();
  DateTime? dueDate;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    if(widget.task!=null){
      isEditMode = true;
      title.text = widget.task!.title;
      description.text = widget.task!.description;
      dueDate = widget.task!.date;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? "Update Task" : "Create Task"),
      ),
      body: Form(
        key: formKey,

        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value!.isEmpty)
                    return "This field is required";
                  else
                    return null;
                },
                controller: title,
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                    if (value!.isEmpty)
                        return "This field is required";
                       else
                        return null;

                },
                controller: description,
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(3000));
                  print(selectedDate);
                  if (selectedDate != null) {
                    dueDate = selectedDate;
                    setState(() {});
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Center(child: Text(dueDate==null  ? "Select Date Time" : dueDate!.toIso8601String())),
                ),
              ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(onPressed: (){
              if (formKey.currentState!.validate()) {
                if(dueDate == null) {
                  ScaffoldMessenger.of(context).
                  showSnackBar(SnackBar(content: Text("You must select due date")));
                } else {
                  Navigator.pop(context,Task(date: dueDate!,
                      description: description.text,
                      title: title.text));
                }
              } else {
                setState(() {
                  autoValidateMode = AutovalidateMode.always;
                });
              }
            },

                child: Text(isEditMode ? "Update" : "Create"))
            ],
          ),
        ),
      ),
    );
  }
}
