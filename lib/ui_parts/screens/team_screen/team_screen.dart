import 'package:flutter/material.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meet our team members"),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyInfoColumn(
                    description:
                        "Create login and sign up page with all user requirement.  Add firebase in login and signup page make the code efficient. He also create animation that make the application more professional and attractive.",
                    image: "assets/images/umair.JPG",
                    name: 'Umair Liaqat',
                  ),
                  MyInfoColumn(
                    description:
                        "Create UI of the app and add category section to make the application more attractive that the lay men can also easily use the application and record there expenses.",
                    image: "assets/images/moasib.png",
                    name: 'Syed Moasib Ali Shah',
                  ),
                  MyInfoColumn(
                    description:
                        "Handle all Calculation and record that a user enter in the application. He manage user items in the sense that all calculation work perfectly or not.",
                    image: "assets/images/mansab.png",
                    name: 'Syed Mansab Ali Shah',
                  ),
                  MyInfoColumn(
                    description:
                        "Create visual Graph that record expense in the form that a user easily see there expense on the graph. The graph work like a day in week and record expenses.",
                    image: "assets/images/person.jpg",
                    name: 'Hafiz Muhammad Hamza Sabir',
                  ),
                  MyInfoColumn(
                    description:
                        "Create login and signup page with Umair liaqat. Helped him adding firebase to our project that it work perfectly. He is also tester that any bug or error will not effect our application.",
                    image: "assets/images/person.jpg",
                    name: 'Umair Ahmed',
                  ),
                  MyInfoColumn(
                    description:
                        "Create graph with Hamza Sabir that it work perfectly and handle animation that the actual prize of product show exact percentage on graph.  ",
                    image: "assets/images/ali hassan.jpg",
                    name: 'Ali Hassan',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyInfoColumn extends StatelessWidget {
  const MyInfoColumn({
    super.key,
    required this.description,
    required this.image,
    required this.name,
  });
  final String name;
  final String image;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 100,
          height: 100,
          child: ClipOval(
            child: Image.asset(image),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          "What he did?",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          description,
        ),
        const Divider(
          thickness: 1.5,
        ),
      ],
    );
  }
}
