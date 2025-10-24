import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  const StyledText(
    this.text, {
    this.overflow = TextOverflow.ellipsis,
    super.key,
  });

  final String text;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.bodyMedium,
      ),
      overflow: overflow,
    );
  }
}

class StyledHeadline extends StatelessWidget {
  const StyledHeadline(
    this.text, {
    this.overflow = TextOverflow.ellipsis,
    super.key,
  });

  final String text;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.headlineMedium,
      ),
      overflow: overflow,
    );
  }
}

class StyledTitle extends StatelessWidget {
  const StyledTitle(
    this.text, {
    this.overflow = TextOverflow.ellipsis,
    super.key,
  });

  final String text;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.titleMedium,
      ),
      overflow: overflow,
    );
  }
}
