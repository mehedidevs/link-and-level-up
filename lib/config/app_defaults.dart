import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';


class AppDefaults {
  static const double radius = 7.5;
  static const double margin = 15;
  static const double padding = 15;
  static const double space = 15;

  /// Used For Border Radius
  static BorderRadius borderRadius = BorderRadius.circular(radius);

  /// Used For Bottom Sheet
  static BorderRadius bottomSheetRadius = const BorderRadius.only(
    topLeft: Radius.circular(radius),
    topRight: Radius.circular(radius),
  );

  /// Used For Top Sheet
  static BorderRadius topSheetRadius = const BorderRadius.only(
    bottomLeft: Radius.circular(radius),
    bottomRight: Radius.circular(radius),
  );

  /// Default Box Shadow used for containers
  static List<BoxShadow> boxShadow = [
    BoxShadow(
      blurRadius: 10,
      spreadRadius: 0,
      offset: const Offset(0, 2),
      color: Colors.black.withOpacity(0.04),
    ),
  ];

  static Duration duration = const Duration(milliseconds: 300);

  static TextStyle titleHeadlineStyle = GoogleFonts.inter(
      fontSize: 20, color: AppColors.text00, fontWeight: FontWeight.w500);

  static TextStyle titleStyle = GoogleFonts.inter(
      fontSize: 14, color: AppColors.text600, fontWeight: FontWeight.w400);

  static TextStyle titleStyleSmall = GoogleFonts.inter(
      fontSize: 12, color: AppColors.textSmall, fontWeight: FontWeight.w400);
  static TextStyle textWhite12_400 = GoogleFonts.inter(
      fontSize: 12, color: AppColors.text00, fontWeight: FontWeight.w400);
  static TextStyle titleStyleReview = GoogleFonts.inter(
      fontSize: 12, color: AppColors.textSmall, fontWeight: FontWeight.w500);

  static TextStyle textWhite600 = GoogleFonts.inter(
      fontSize: 14, color: AppColors.text00, fontWeight: FontWeight.w600);

  static TextStyle textWhite500 = GoogleFonts.inter(
      fontSize: 14, color: AppColors.text00, fontWeight: FontWeight.w500);

  static TextStyle bodyTextStyle = GoogleFonts.inter(
      fontSize: 14, color: AppColors.text00, fontWeight: FontWeight.w400);

  static TextStyle buttonTextStyle = GoogleFonts.inter(
      fontSize: 16, color: AppColors.text00, fontWeight: FontWeight.w600);
  static TextStyle buttonTextStyleSmall = GoogleFonts.inter(
      fontSize: 10, color: AppColors.text00, fontWeight: FontWeight.w400);

  static TextStyle otpTextStyle = GoogleFonts.inter(
      fontSize: 20, color: AppColors.text00, fontWeight: FontWeight.w600);

  static TextStyle menuTextStyle = GoogleFonts.inter(
      fontSize: 16, color: AppColors.text00, fontWeight: FontWeight.w500);

  static TextStyle bodyTitleTextStyle = GoogleFonts.inter(
      fontSize: 20, color: AppColors.text00, fontWeight: FontWeight.w700);

  static TextStyle sectionTitleTextStyle = GoogleFonts.inter(
      fontSize: 20, color: AppColors.text00, fontWeight: FontWeight.w500);
  static TextStyle titleSeeAll = GoogleFonts.inter(
      fontSize: 12, color: AppColors.primary500, fontWeight: FontWeight.w400);

  static TextStyle primaryHeadline = GoogleFonts.inter(
      fontSize: 26, color: AppColors.primary600, fontWeight: FontWeight.w800);

  static const aubergineMapStyle = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8ec3b9"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1a3646"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#4b6878"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#64779e"
      }
    ]
  },
  {
    "featureType": "administrative.province",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#4b6878"
      }
    ]
  },
  {
    "featureType": "landscape.man_made",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#334e87"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#023e58"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#283d6a"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6f9ba5"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#023e58"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3C7680"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#304a7d"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#98a5be"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2c6675"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#255763"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#b0d5ce"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#023e58"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#98a5be"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#283d6a"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3a4762"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#0e1626"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#4e6d70"
      }
    ]
  }
]
''';
}
