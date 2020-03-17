import 'package:flutter/material.dart';


class MyCustomButton extends StatelessWidget {

  IconData _icon;
  double _width;
  double _iconSize;
  Widget _nextPage;
  Color _color;

  MyCustomButton(IconData icon, double width, double iconSize, Color color, Widget nextPage) {
    this._icon = icon;
    this._width = width;
    this._iconSize = iconSize;
    this._nextPage = nextPage;
    this._color = color;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      child: RaisedButton(
          color: Color.fromRGBO(20, 20, 20, 1),
          child: Icon(
            _icon,
            color: _color,
            size: _iconSize,
          ),
          onPressed: () {
            showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(208, 208, 208, 0),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(30),
                        topRight: const Radius.circular(30),
                      ),
                    ),

                    child: _nextPage,
                  );
                }
            );
          }
      ),
    );
  }
}