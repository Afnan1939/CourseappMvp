import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(UserController());
  runApp(MyApp());
}

// ---------------- CONTROLLER ----------------
class UserController extends GetxController {
  var username = "".obs;
  void setName(String name) {
    username.value = name;
  }
}

// ---------------- MAIN APP ----------------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

// ---------------- LOGIN PAGE ----------------
class LoginPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Enter your name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                userController.setName(nameController.text);
                Get.off(() => MainPage());
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- MAIN PAGE WITH NAV ----------------
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      CoursesPage(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coursera MVP"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Get.offAll(() => LoginPage());
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// ---------------- HOME PAGE ----------------
class HomePage extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() => Text(
        "Welcome, ${userController.username.value}!",
        style: TextStyle(fontSize: 24),
      )),
    );
  }
}

// ---------------- COURSES PAGE ----------------
class CoursesPage extends StatelessWidget {
  final List<Map<String, String>> courses = [
    {
      "title": "Flutter for Beginners",
      "description": "Learn to build apps using Flutter & Dart."
    },
    {
      "title": "Firebase Authentication",
      "description": "Secure your app with Firebase login."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text(
              course["title"]!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(course["description"]!),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.to(() => CourseDetailPage(
                title: course["title"]!,
                description: course["description"]!,
              ));
            },
          ),
        );
      },
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final String title;
  final String description;

  CourseDetailPage({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(description, style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.snackbar("Enrolled", "You enrolled in $title");
              },
              child: Text("Enroll"),
            )
          ],
        ),
      ),
    );
  }
}



// ---------------- PROFILE PAGE ----------------
class ProfilePage extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() => Text(
        "Profile of ${userController.username.value}",
        style: TextStyle(fontSize: 24),
      )),
    );
  }
}
