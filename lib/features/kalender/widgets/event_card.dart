

import 'package:flutter/material.dart';


class EventCard extends StatelessWidget {
  final Map<String, String> event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // URoundedImage(
          //   fit: BoxFit.cover,
          //   imageUrl: event['image']!,
          //   isNetworkImage: false,
          //   width: 90,
          //   height: 90,
          //   borderRadius: 8,
          // ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        event['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.arrow_forward_ios, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  event['date']!,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}