import 'package:flutter/material.dart';

class UploadAssetModal extends StatelessWidget {
  UploadAssetModal({super.key});

  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Dialog(
      child: Container(
        height: 650,
        width: 600,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        decoration: BoxDecoration(
            color: Color(0xFF1A2744), borderRadius: BorderRadius.circular(40)),
        child: Column(
          children: [
            Text(
              'Index New Assets',
              style: TextStyle(
                  fontFamily: 'Jakarta',
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Add new images or GIF\'s to your vault',
              style: TextStyle(
                  fontFamily: 'Vietnam', fontSize: 20, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 250,
              decoration: BoxDecoration(
                  color: Color(0xFF141f38),
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: scheme.primary.withOpacity(0.1)),
                  child: Icon(
                    Icons.upload,
                    color: scheme.primary,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF141f38),
              ),
              height: 80,
              width: 700,
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                      hint: Text('E.g Pic of me with Gandhi'),
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 80,
              width: 700,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: scheme.primary),
              child: Center(
                child: Text('Index'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
