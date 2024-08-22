import 'package:flutter/material.dart';
import 'package:threee_d_button/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final title = TextEditingController();
  final description = TextEditingController();

  // Updated data list with a 'checked' field to manage checkbox states
  List<Map<String, dynamic>> data = [];
  @override
  void initState() {
    super.initState();
    loadData();  // Load data when the app starts
  }

  // Load data from shared preferences
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('todo_data');
    if (jsonString != null) {
      List<dynamic> jsonResponse = jsonDecode(jsonString);
      setState(() {
        data = jsonResponse.map((item) => Map<String, dynamic>.from(item)).toList();
      });
    }
  }

  // Save data to shared preferences
  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(data);
    await prefs.setString('todo_data', jsonString);
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Container(
        color: const Color(0xffD6EFD8),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(

                  title: Text(data[index]['title']),
                  subtitle: Text(data[index]['description']),
                  trailing: Checkbox(
                    side: BorderSide( width: 2 ),
                    activeColor: Color(0xff1A5319),
                    value: data[index]['checked'], // Use the 'checked' field
                    onChanged: (bool? value) {
                      setState(() {
                        data[index]['checked'] = value!; // Update the checkbox state
                      });
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
      Container(
        color: const Color(0xffD6EFD8),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff508D4E),
        title: const Text(
          MyApp.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        foregroundColor: Colors.white,
      ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Add Todo",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: title,
                    maxLines: 1,
                    validator: (title) {
                      if (title!.isEmpty) {
                        return "The title can't be empty ";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Title',
                      labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    controller: description,
                    maxLines: 4,
                    validator: (description) {
                      if (description!.isEmpty) {
                        return "The description can't be empty ";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Description',
                      labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                        WidgetStatePropertyAll(Color(0xff1A5319)),
                      ),
                      onPressed: () {
                        try {
                          setState(() {
                            // Adding a new map with 'checked' field set to false
                            Map<String, dynamic> newMap = {
                              'title': title.text.toString(),
                              'description': description.text.toString(),
                              'checked': false, // Initialize 'checked' as false
                            };
                            data.add(newMap);
                          });
                        } catch (onPressed) {
                          // Handle error
                        } finally {
                          title.clear();
                          description.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          barrierDismissible: false,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: const Color(0xff1A5319),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff508D4E),
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_rounded, size: 40),
            label: "ToDos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_rounded, size: 40),
            label: "Completed",
          ),
        ],
      ),
    );
  }
}
