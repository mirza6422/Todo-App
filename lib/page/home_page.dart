import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:threee_d_button/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final title = TextEditingController();
  final description = TextEditingController();

  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    loadData(); // Load data when the app starts
  }

  // Load data from shared preferences
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('todo_data');
    if (jsonString != null) {
      List<dynamic> jsonResponse = jsonDecode(jsonString);
      setState(() {
        data = jsonResponse
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
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
    List<Map<String, dynamic>> completedItems =
        data.where((item) => item['checked'] == true).toList();

    final tabs = [
      // First tab: To-Do list
      Container(
        color: const Color(0xff80AF81),
        child: data.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "𝓝𝓸 𝓣𝓸𝓭𝓸",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "𝓒𝓵𝓲𝓬𝓴 𝓸𝓷 + 𝓽𝓸 𝓐𝓭𝓭 𝓣𝓸𝓭𝓸𝓼",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: const Color(0xffD6EFD8),
                      child: Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            extentRatio: 0.2,
                            children: [
                              SlidableAction(
                                onPressed: (BuildContext context) {
                                  setState(() {
                                    data.removeAt(index);
                                    saveData();
                                  });
                                },
                                icon: Icons.delete_rounded,
                                label: 'Delete',
                                padding: EdgeInsets.all(8),
                                backgroundColor: const Color(0xff508D4E),
                                foregroundColor: const Color(0xffD6EFD8),
                                autoClose: true,
                              )
                            ]),
                        startActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            extentRatio: 0.2,
                            children: [
                              SlidableAction(
                                onPressed: (BuildContext context) {},
                                icon: Icons.edit_note_rounded,
                                label: "Edit",
                                backgroundColor: const Color(0xff508D4E),
                                foregroundColor: const Color(0xffD6EFD8),
                              )
                            ]),
                        child: ListTile(
                          title: Text(
                            data[index]['title'],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          subtitle: Text(
                            data[index]['description'],
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          trailing: Checkbox(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            activeColor: const Color(0xff1A5319),
                            value: data[index]['checked'],
                            onChanged: (bool? value) {
                              setState(() {
                                data[index]['checked'] = value!;
                              });
                              saveData(); // Save data after updating
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      Container(
        color: const Color(0xff80AF81),
        child: completedItems.isEmpty
            ? const Center(
                child: Text(
                  "𝓝𝓸 𝓒𝓸𝓶𝓹𝓵𝓮𝓽𝓮𝓭 𝓛𝓲𝓼𝓽",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                itemCount: completedItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: const Color(0xffD6EFD8),
                      child: ListTile(
                        title: Text(
                          completedItems[index]['title'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          completedItems[index]['description'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: const Icon(
                          Icons.check_circle_outline,
                          color: Color(0xff1A5319),
                          size: 30,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    ];

    return Scaffold(
        drawerEnableOpenDragGesture: false,
        drawer: Drawer(
            backgroundColor: const Color(0xffD6EFD8),
            child: Column(
              children: [
                const DrawerHeader(
                    decoration: BoxDecoration(color: Color(0xff508D4E)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundImage:
                              AssetImage('Assets/image/seerox.png'),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Seerox",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Empowering your vision with innovative solutions."
                                  " Let's shape success!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const ListTile(
                        leading: Icon(
                          Icons.pie_chart_rounded,
                          size: 30,
                        ),
                        title: Text(
                          "Dashboard",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const ListTile(
                        leading: Icon(
                          Icons.calendar_month_rounded,
                          size: 30,
                        ),
                        title: Text(
                          "Calendar",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const ListTile(
                        leading: Icon(
                          Icons.auto_graph_rounded,
                          size: 30,
                        ),
                        title: Text(
                          "Activity",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const ListTile(
                        leading: Icon(
                          Icons.insert_chart_outlined_rounded,
                          size: 30,
                        ),
                        title: Text(
                          "Project Plans",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const ListTile(
                        leading: Icon(
                          Icons.settings_rounded,
                          size: 30,
                        ),
                        title: Text(
                          "Settings",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const ListTile(
                        leading: Icon(
                          Icons.info_rounded,
                          size: 30,
                        ),
                        title: Text(
                          "About",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, size: 30), // Increased drawer icon size
              onPressed: () {
                Scaffold.of(context)
                    .openDrawer(); // Open the drawer when tapped
              },
            );
          }),
          actions: const [
            InkWell(
              onTap: null,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notifications_rounded,
                  size: 30,
                ),
              ),
            )
          ],
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: title,
                      maxLines: 1,
                      validator: (title) {
                        if (title!.isEmpty) {
                          return "The title can't be empty ";
                        } else {
                          return 'title';
                        }
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Title',
                        labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    TextFormField(
                      controller: description,
                      maxLines: 4,
                      validator: (description) {
                        if (description!.isEmpty) {
                          return "The description can't be empty ";
                        } else {
                          return 'description';
                        }
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
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
                          setState(() {
                            Map<String, dynamic> newMap = {
                              'title': title.text.toString(),
                              'description': description.text.toString(),
                              'checked': false,
                            };
                            data.add(newMap);
                          });
                          saveData(); // Save data after adding a new item
                          title.clear();
                          description.clear();
                          Navigator.pop(context);
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
        ));
  }
}
