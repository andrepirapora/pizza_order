import 'package:flutter/material.dart';
import '../controller/pizza_order_provider.dart';

class PizzaCartIcon extends StatefulWidget {
  @override
  _PizzaCartIconState createState() => _PizzaCartIconState();
}

class _PizzaCartIconState extends State<PizzaCartIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationScaleOut;
  late Animation<double> _animationScaleIn;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationScaleOut = CurvedAnimation(
      curve: const Interval(0.0, 0.5),
      parent: _controller,
    );
    _animationScaleIn = CurvedAnimation(
      curve: const Interval(0.5, 1.0),
      parent: _controller,
    );
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final bloc = PizzaOrderProvider.of(context)!;
      bloc.notifierCartIconAnimation.addListener(() {
        counter = bloc.notifierCartIconAnimation.value;
        _controller.forward(from: 0.0);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, snapshot) {
          late double scale;
          const scaleFactor = 0.4;
          if (_animationScaleOut.value < 1.0) {
            scale = 1.0 + scaleFactor * _animationScaleOut.value;
          } else if (_animationScaleIn.value <= 1.0) {
            scale = (1.0 + scaleFactor) - scaleFactor * _animationScaleIn.value;
          }
          return Transform.scale(
            alignment: Alignment.center,
            scale: scale,
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.brown,
                  ),
                  onPressed: () {},
                ),
                if (_animationScaleOut.value > 0)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Transform.scale(
                      alignment: Alignment.center,
                      scale: _animationScaleOut.value,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                        child: Text(
                          counter.toString(),
                          style: const TextStyle(fontSize: 9),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
