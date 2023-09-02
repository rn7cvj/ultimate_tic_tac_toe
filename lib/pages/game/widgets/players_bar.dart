import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayersBar extends StatelessWidget {
  const PlayersBar({super.key, required this.title, required this.svgPath, required this.quarterTurns});

  final String title;
  final String svgPath;
  final int quarterTurns;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: RotatedBox(
              quarterTurns: quarterTurns,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    svgPath,
                    height: 25,
                    width: 25,
                    // color: Theme.of(context).colorScheme.secondary,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
                  ),
                  Text(title),
                  const SizedBox(
                    height: 25,
                    width: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
