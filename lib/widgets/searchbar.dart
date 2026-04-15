import 'package:flutter/material.dart';

class GifzaSearchBar extends StatelessWidget {
  GifzaSearchBar({super.key});

  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 250),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Color(0xFF141f38), borderRadius: BorderRadius.circular(50)),
        child: Padding(
          padding: EdgeInsets.only(left: 40, right: 10),
          child: Row(
            spacing: 3,
            children: [
              Icon(Icons.search),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search my library ...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey)),
              )),
              Container(
                height: 60,
                width: 160,
                decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(48)),
                child: Center(
                  child: Text('Search', style: textTheme.bodyMedium),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
