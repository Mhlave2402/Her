import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:her_user_app/util/dimensions.dart';

class OnboardContent extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 250,
          width: 250,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.fontSizeOverLarge,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: Dimensions.fontSizeLarge,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
