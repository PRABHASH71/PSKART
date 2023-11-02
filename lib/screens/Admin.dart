import "package:flutter/material.dart";

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(
              radius: 37,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Prabhash Ranjan",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text("prabahshmickey@gmail.com",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                )),
            SizedBox(
              height: 10,
            ),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: _dashboardItem.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> singledash = _dashboardItem[index];
                return Card(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            color: Color.fromARGB(255, 172, 172, 172)),
                      ],
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(255, 255, 255, 255)
                      ]),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          singledash["title"],
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(singledash["subtitle"]),
                      ],
                    ),
                  ),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }

  static final List<Map<String, dynamic>> _dashboardItem = [
    {
      "title": "400",
      "subtitle": "Users",
    },
    {
      "title": "5",
      "subtitle": "Categories",
    },
    {
      "title": "5",
      "subtitle": "Products",
    },
    {
      "title": "\$500",
      "subtitle": "Earnings",
    },
    {
      "title": "+",
      "subtitle": "Add Products",
    },
  ];
}
