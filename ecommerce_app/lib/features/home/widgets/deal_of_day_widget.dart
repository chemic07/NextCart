import 'package:flutter/material.dart';

class DealOfDayWidget extends StatefulWidget {
  const DealOfDayWidget({super.key});

  @override
  State<DealOfDayWidget> createState() => _DealOfDayWidgetState();
}

class _DealOfDayWidgetState extends State<DealOfDayWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "Deal of the day",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Image.network(
          "https://media.geeksforgeeks.org/wp-content/uploads/20240216084522/bfs-vs-dfs-(1).png",
          height: 223,
          fit: BoxFit.fitHeight,
        ),

        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15),
          child: const Text(
            "\$100",
            style: TextStyle(fontSize: 18),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            "rivaan",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                "https://media.geeksforgeeks.org/wp-content/uploads/20240216084522/bfs-vs-dfs-(1).png",
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                "https://media.geeksforgeeks.org/wp-content/uploads/20240216084522/bfs-vs-dfs-(1).png",
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                "https://media.geeksforgeeks.org/wp-content/uploads/20240216084522/bfs-vs-dfs-(1).png",
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
              Image.network(
                "https://media.geeksforgeeks.org/wp-content/uploads/20240216084522/bfs-vs-dfs-(1).png",
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),

        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: const Text(
            "See all deals",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.cyan),
          ),
        ),
      ],
    );
  }
}
