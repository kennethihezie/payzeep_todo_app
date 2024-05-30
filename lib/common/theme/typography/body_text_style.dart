import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/common/theme/size_config.dart';


class TextBodyStyle {
  //================= Large ==================//
  TextStyle get largeBold => GoogleFonts.inter(
      fontWeight: FontWeight.w700,
      fontSize: SizeConfig.pxToTextSize(14),
      height: 17.6.toLineHeight(14));

  TextStyle get largeSemiBold => GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      fontSize: SizeConfig.pxToTextSize(14),
      height: 18.0.toLineHeight(14));

  TextStyle get largeMedium => GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: SizeConfig.pxToTextSize(14),
      height: 22.0.toLineHeight(22));

  TextStyle get largeRegular => GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: SizeConfig.pxToTextSize(14),
      height: 24.0.toLineHeight(14));

  TextStyle get largeLight => GoogleFonts.inter(
      fontWeight: FontWeight.w300,
      fontSize: SizeConfig.pxToTextSize(14),
      height: 17.6.toLineHeight(14));

  //================ Medium ==================//
  TextStyle get mediumRegular => GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: SizeConfig.pxToTextSize(13),
      height: 13.0.toLineHeight(13));

  TextStyle get mediumLight => GoogleFonts.inter(
      fontWeight: FontWeight.w300,
      fontSize: SizeConfig.pxToTextSize(13),
      height: 16.38.toLineHeight(13));

  //================ Small ==================//
  TextStyle get smallMedium => GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: SizeConfig.pxToTextSize(12),
      height: 15.12.toLineHeight(12));

  TextStyle get smallRegular => GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: SizeConfig.pxToTextSize(12),
      height: 15.12.toLineHeight(12));

  TextStyle get smallLight => GoogleFonts.inter(
      fontWeight: FontWeight.w300,
      fontSize: SizeConfig.pxToTextSize(12),
      height: 15.12.toLineHeight(12));

  TextStyle get small => GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: SizeConfig.pxToTextSize(12),
      height: 12.0.toLineHeight(12));

  TextStyle get medium => GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: SizeConfig.pxToTextSize(14),
      height: 18.0.toLineHeight(14));
}
