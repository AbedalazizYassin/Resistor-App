import 'package:flutter_application_10/home.dart';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/9.webp",
            fit: BoxFit.cover,
          ),
          const Text(
              "We have the best Resistors in  the best price over all  "),
          const Text("Lebanon!"),
          const SizedBox(
            height: 59,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 120),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: Colors.grey)),
              child: const Text(
                "Get Started",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
