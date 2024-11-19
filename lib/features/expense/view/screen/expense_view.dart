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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                return Card(
                  elevation: 3,
                  shadowColor: Colors.orange,
                  color: Colors.white,
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: Icon(Icons.home),
                          ),
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "category",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: SizedBox(
                                width: 50,
                                child: Text(
                                  "description",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              " ₹ data",
                            ),
                            Text(
                              "sub",
                            )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () async {},
                                icon: const Icon(Icons.edit)),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
