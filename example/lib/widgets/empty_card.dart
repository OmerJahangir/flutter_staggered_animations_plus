import 'package:flutter/material.dart';

// class EmptyCard extends StatelessWidget {
//   final double? width;
//   final double? height;
//   final int? index;

//   const EmptyCard({super.key, this.width, this.height, this.index});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.symmetric(vertical: 6.0),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: Colors.deepPurple.shade100,
//           child: Text(
//             '${index! + 1}',
//             style: TextStyle(
//               color: Colors.deepPurple.shade700,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         title: Text('Animated Item ${index! + 1}'),
//         subtitle: const Text('Slide + Fade staggered animation'),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//       ),
//     );
//     //  Container(
//     //   width: width,
//     //   height: height,
//     //   margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//     //   decoration: BoxDecoration(
//     //     color: Colors.blue[200],
//     //     borderRadius: BorderRadius.all(Radius.circular(4.0)),
//     //     boxShadow: <BoxShadow>[
//     //       BoxShadow(
//     //         color: Colors.black12,
//     //         blurRadius: 4.0,
//     //         offset: Offset(0.0, 4.0),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }

/* class EmptyCard extends StatelessWidget {



  final double? width;
  final double? height;
  final int? index;

  /// Show index badge (for List/Grid)
  final bool showIndex;

  /// Custom title & subtitle
  final String? title;
  final String? subtitle;

  /// Optional icon override
  final Widget? leading;

  /// Tap callback
  final VoidCallback? onTap;

  const EmptyCard({
    super.key,
    this.width,
    this.height,
    this.index,
    this.showIndex = true,
    this.title,
    this.subtitle,
    this.leading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final int displayIndex = (index ?? 0) + 1;

    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              width: width,
              height: height,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              decoration: BoxDecoration(
                // color: Colors.blue[200],
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                // boxShadow: <BoxShadow>[
                //   BoxShadow(
                //     color: Colors.black12,
                //     blurRadius: 4.0,
                //     offset: Offset(0.0, 4.0),
                //   ),
                // ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildLeading(displayIndex),
                      Text(
                        title ?? 'Animated Item $displayIndex',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Text(
                    subtitle ?? 'Slide + Fade staggered animation',
                  ),
                ],
              ),
            ),

            // ListTile(
            //   leading: _buildLeading(displayIndex),
            //   title: Text(
            //     title ?? 'Animated Item $displayIndex',
            //     style: const TextStyle(fontWeight: FontWeight.w600),
            //   ),
            //   subtitle: Text(
            //     subtitle ?? 'Slide + Fade staggered animation',
            //   ),
            //   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            // ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeading(int displayIndex) {
    if (leading != null) return leading!;

    if (showIndex && index != null) {
      return CircleAvatar(
        backgroundColor: Colors.deepPurple.shade100,
        child: Text(
          '$displayIndex',
          style: TextStyle(
            color: Colors.deepPurple.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Icon(
      Icons.animation,
      color: Colors.deepPurple.shade400,
    );
  }
}
 */
enum CardLayoutType {
  list,
  grid,
  compact,
}

class EmptyCard extends StatelessWidget {
  final double? width;
  final double? height;
  final int? index;
  final bool showIndex;
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;

  final CardLayoutType layoutType;

  const EmptyCard({
    super.key,
    this.width,
    this.height,
    this.index,
    this.showIndex = true,
    this.title,
    this.subtitle,
    this.onTap,
    this.layoutType = CardLayoutType.list,
  });

  @override
  Widget build(BuildContext context) {
    final int displayIndex = (index ?? 0) + 1;

    switch (layoutType) {
      case CardLayoutType.grid:
        return _buildGrid(context, displayIndex);

      case CardLayoutType.compact:
        return _buildCompact(context, displayIndex);

      case CardLayoutType.list:
        return _buildList(context, displayIndex);
    }
  }

  // =========================================================
  // 🔹 LIST (ListTile)
  // =========================================================

  Widget _buildList(BuildContext context, int displayIndex) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        child: ListTile(
          onTap: onTap,
          leading: _buildLeading(displayIndex),
          title: Text(title ?? 'Animated Item $displayIndex'),
          subtitle: Text(subtitle ?? 'Slide + Fade staggered animation'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }

  // =========================================================
  // 🔹 GRID (GridTile)
  // =========================================================

  Widget _buildGrid(BuildContext context, int displayIndex) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: 2,
        child: GridTile(
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: _buildLeading(displayIndex),
            ),
          ),
          footer: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title ?? 'Item $displayIndex',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          child: const Center(
            child: Icon(Icons.animation, size: 40),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // 🔹 COMPACT (Column safe)
  // =========================================================

  Widget _buildCompact(BuildContext context, int displayIndex) {
    return Container(
      width: width,
      height: height ?? 60,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _buildLeading(displayIndex),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title ?? 'Item $displayIndex',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // 🔹 COMMON LEADING
  // =========================================================

  Widget _buildLeading(int displayIndex) {
    if (showIndex && index != null) {
      return CircleAvatar(
        radius: 14,
        backgroundColor: Colors.deepPurple.shade100,
        child: Text(
          '$displayIndex',
          style: TextStyle(
            fontSize: 12,
            color: Colors.deepPurple.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Icon(
      Icons.animation,
      color: Colors.deepPurple.shade400,
    );
  }
}
