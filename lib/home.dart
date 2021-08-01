import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:devclass_recipe/widget/list_card.dart';
import 'package:http/http.dart' as http;
import 'package:devclass_recipe/model/recipe.dart';

import 'detail_resep.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> recipeList = [];
  bool loading = true;

  getData() async {
    Uri url =
        Uri.parse('https://masak-apa-tomorisakura.vercel.app/api/recipes');
    http.Response response = await http.get(url);
    Map<String, dynamic> result = jsonDecode(response.body);

    result['results'].forEach((menu) {
      setState(() {
        recipeList.add(Recipe.fromJson(menu));
        loading = false;
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Devclass Recipe",
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recipeList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailResep(recipe: recipeList[index]),
                              ),
                            );
                          },
                          child: ListCard(recipe: recipeList[index]),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
