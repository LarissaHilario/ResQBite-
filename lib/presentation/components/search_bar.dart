import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBarComponent extends StatelessWidget {
  final MaterialStateProperty<EdgeInsets>? padding;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final Widget? leading;

  const SearchBarComponent({
    Key? key,
    this.padding,
    this.onTap,
    this.onChanged,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.0, 
      height: 52.0, 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color:
            const Color(0xFF88B04F).withOpacity(0.20), 
        border: Border.all(
          color: const Color(0xFF88B04F).withOpacity(0.5),
          width: 3.0, 
        ),
      ),
      child: Container(
        padding: padding?.resolve({}),
        child: TextField(
          onTap: onTap,
          onChanged: onChanged,
          style: TextStyle(
            color: Colors.black.withOpacity(.5), 
            fontWeight: FontWeight.w300,
            fontFamily: 'FiraSansCondensed',
            fontSize: 16
          ),
          decoration: InputDecoration(
            hintText: 'Buscar tu categoría ...',
            hintStyle:
                const TextStyle(color: Colors.grey), 
            prefixIcon: leading,
            suffixIcon: SvgPicture.asset(
              'assets/images/arrow-right.svg', 
            ),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0), 
            border: InputBorder.none, 
          ),
        ),
      ),
    );
  }
}
