import 'package:coffe_app/components/toggle_widget.dart';
import 'package:coffe_app/model.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class DrinkDetails extends StatefulWidget {
  const DrinkDetails({super.key});

  @override
  State<DrinkDetails> createState() => _DrinkDetailsState();
}

class _DrinkDetailsState extends State<DrinkDetails> {
  final PageController _controller = PageController(viewportFraction: 0.5);
  double _currentPage = 0;
  int? selectedSize;
  double drinkSize = 1.1;

  final drinks = DrinkModel.drinks;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              /// العنوان والسعر
              Positioned(
                top: constraints.maxHeight * 0.04,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // الاسم والوصف
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          drinks[_currentPage.round()].name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          drinks[_currentPage.round()].title,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    // السعر
                    Text(
                      "£${drinks[_currentPage.round()].price}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              /// PageView بالصور
              Positioned(
                top: constraints.maxHeight * 0.15,
                left: 0,
                right: 0,
                height: constraints.maxHeight * 0.45,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: drinks.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final scale =
                        (drinkSize - (_currentPage - index).abs()).clamp(0.85, 1.0);
                    final translateY = (_currentPage - index).abs() * 25;

                    return Transform.translate(
                      offset: Offset(0, translateY),
                      child: Transform.scale(
                        scale: scale,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              drinks[index].image,
                              height: constraints.maxHeight * 0.42,
                              fit: BoxFit.contain,
                            ),
                            Positioned(
                              bottom: 0,
                              child: Image.asset(
                                "assets/drinks/Ellipse 2.png",
                                height: constraints.maxHeight * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// الجزء السفلي للحجم والكمية
              Positioned(
                left: 20,
                right: 20,
                bottom: 0,
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // اختيار الحجم
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(11),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: selectedSize == index
                                    ? Colors.orange
                                    : Colors.white,
                                border: Border.all(
                                  color: selectedSize == index
                                      ? Colors.orange
                                      : Colors.black,
                                ),
                              ),
                              child: SvgPicture.asset(
                                "assets/Vector.svg",
                                color: selectedSize == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),

                      // DrinkToggle و QuantitySelector
                      Row(
                        children: [
                          Expanded(child: DrinkToggle()),
                          const SizedBox(width: 20),
                          Expanded(child: QuantitySelector()),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
