import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:tech_mobile_app/feature/basketPage/model/basket_model.dart';
import 'package:tech_mobile_app/product/bottom_navbar.dart';

class BasketView extends StatelessWidget {
  BasketView({Key? key}) : super(key: key);

  List<BasketModel> list = [
    BasketModel(
      name: 'Lord Of The Rings',
      price: '250',
      image:
          'https://irs.www.warnerbros.com/keyart-jpeg/movies/media/browser/lord_of_the_rings_fellowship_of_the_ring_2000x3000.jpg',
      id: 0,
    ),
    BasketModel(
      name: 'The Eye Of Istanbul',
      price: '200',
      image:
          'https://m.media-amazon.com/images/M/MV5BNDU2YzcwYzktM2ViMC00MTlmLTk4OWQtODViYThkNzRhZjJlXkEyXkFqcGdeQXVyNTI5NjIyMw@@._V1_FMjpg_UX1000_.jpg',
      id: 1,
    ),
    BasketModel(
      name: 'Don Quijote de la Mancha',
      price: '250',
      image: 'https://tr.web.img2.acsta.net/pictures/17/01/18/09/52/321950.jpg',
      id: 2,
    ),
    BasketModel(
      name: "Barron's New Jersey",
      price: '300',
      image:
          'https://images-na.ssl-images-amazon.com/images/I/51RB-iuO7DL._SX386_BO1,204,203,200_.jpg',
      id: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.45,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            shadowColor: Colors.pink.shade200,
            child: Column(
              children: [
                Container(
                  width: context.width * 0.4,
                  height: context.height * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: context.highBorderRadius,
                    image: DecorationImage(
                      image: NetworkImage(list[index].image),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Text(list[index].name),
                Text('Price : ${list[index].price} TMC'),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavbar(
        pageid: 2,
      ),
    );
  }
}
