import 'package:flutter/material.dart';

class ExpenseView extends StatelessWidget {
  const ExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Colors.tealAccent),
            width: MediaQuery.sizeOf(context).width,
            height: 250,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text("Week")),
              ElevatedButton(onPressed: () {}, child: const Text("Month")),
              ElevatedButton(onPressed: () {}, child: const Text("Year"))
            ],
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.amber),
            width: MediaQuery.sizeOf(context).width,
            height: 250,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return const Text("data");
              },
            ),
          )
        ],
      ),
    );
  }
}
