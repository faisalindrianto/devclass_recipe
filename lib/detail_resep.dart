import 'dart:convert';

import 'package:devclass_recipe/model/recipe.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailResep extends StatefulWidget {
  final Recipe recipe;
  const DetailResep({ Key? key, required this.recipe }) : super(key: key);

  @override
  _DetailResepState createState() => _DetailResepState();
}

class _DetailResepState extends State<DetailResep> {
  Future<Map<String, dynamic>> getRecipeDetail() async {
    Uri uri = Uri.parse("https://masak-apa-tomorisakura.vercel.app/api/recipe/" + widget.recipe.key!);
    http.Response response = await http.get(uri);
    Map<String, dynamic> result = jsonDecode(response.body);

    return result['results'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Resep"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getRecipeDetail(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.recipe.thumb ?? '',
                          ),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      widget.recipe.title ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Divider(height: 32),
                    Text(
                      snapshot.data?['desc'] ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Divider(height: 32),
                    Text(
                      "Bahan yang dibutuhkan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data?['ingredient'].length,
                      itemBuilder: (context, index) {
                        return Text(
                          snapshot.data?['ingredient'][index] ?? ''
                        );
                      }
                    ),
                    Divider(height: 32),
                    Text(
                      "Cara membuat",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data?['step'].length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text(
                            snapshot.data?['step'][index]
                          ),
                        );
                      }
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}