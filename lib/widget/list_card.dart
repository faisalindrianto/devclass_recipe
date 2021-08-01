import 'package:devclass_recipe/model/recipe.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final Recipe? recipe;
  const ListCard({ Key? key, @required this.recipe }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                      recipe?.thumb ?? '',
                    ),
                    fit: BoxFit.cover,
                  )
                ),
              ),
              Align(
                alignment: Alignment.topLeft,child:
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(recipe?.dificulty ?? '', style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.green
                      ),
                      Chip(
                        label: Text(recipe?.times ?? '', style: TextStyle(color: Colors.green)),
                        backgroundColor: Colors.white
                      ),
                    ],
                  )
                )
              )
            ],
          ),
          SizedBox(height: 12),
          Text(
            recipe?.title ?? '',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}