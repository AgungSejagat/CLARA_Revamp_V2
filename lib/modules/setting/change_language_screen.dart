import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Language"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/en/thumb/a/ae/Flag_of_the_United_Kingdom.svg/1024px-Flag_of_the_United_Kingdom.svg.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              margin: EdgeInsets.all(10),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2012/04/10/23/01/indonesia-26817__480.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              margin: EdgeInsets.all(10),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://media.istockphoto.com/id/967321166/vector/vector-flag-of-spain-proportion-2-3-spanish-national-bicolor-flag-rojigualda.jpg?s=612x612&w=0&k=20&c=FK8YG5rnLACfcXLzhpdCqwxUFySs5mojqPqQG15sBc0=',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              margin: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}
