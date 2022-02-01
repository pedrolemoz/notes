import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NoteCardShimmer extends StatelessWidget {
  final shimmerDuration = const Duration(seconds: 2);

  NoteCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Shimmer.fromColors(
              period: shimmerDuration,
              baseColor: Theme.of(context).colorScheme.secondaryVariant,
              highlightColor: Theme.of(context).colorScheme.secondary,
              child: Container(
                height: 23,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryVariant,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Shimmer.fromColors(
                  period: shimmerDuration,
                  baseColor: Theme.of(context).colorScheme.secondaryVariant,
                  highlightColor: Theme.of(context).colorScheme.secondary,
                  child: Container(
                    height: 23 * 3,
                    decoration: const BoxDecoration(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
