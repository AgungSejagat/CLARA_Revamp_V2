import 'package:flutter/material.dart';
import 'package:flutter_clara_v1/modules/setting/provider/language_provider.dart';
import 'package:provider/provider.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Language"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                context.read<LanguageProvider>().changeLanguage(context, 'en');
              },
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
                margin: const EdgeInsets.all(10),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                context.read<LanguageProvider>().changeLanguage(context, 'id');
              },
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
                margin: const EdgeInsets.all(10),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                context.read<LanguageProvider>().changeLanguage(context, 'es');
              },
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
                margin: const EdgeInsets.all(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
