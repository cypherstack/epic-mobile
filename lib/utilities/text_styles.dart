import 'package:epicmobile/utilities/theme/color_theme.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class STextStyles {
  static StackColors _theme(BuildContext context) =>
      Theme.of(context).extension<StackColors>()!;

  static TextStyle pageTitleH1(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        );
    }
  }

  static TextStyle pageTitleH2(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        );
    }
  }

  static TextStyle titleH1(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 40,
          height: 52 / 40,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 40,
          height: 52 / 40,
        );
    }
  }

  static TextStyle titleH2(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 32,
          height: 41.6 / 32,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 32,
          height: 41.6 / 32,
        );
    }
  }

  static TextStyle titleH3(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 24,
          height: 31.2 / 24,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 24,
          height: 31.2 / 24,
        );
    }
  }

  static TextStyle titleH4(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          height: 23.4 / 18,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          height: 23.4 / 18,
        );
    }
  }

  static TextStyle body(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 22.4 / 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 22.4 / 16,
        );
    }
  }

  static TextStyle bodyBold(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 22.4 / 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 22.4 / 16,
        );
    }
  }

  static TextStyle titleBold12_400(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        );
    }
  }

  static TextStyle subtitle(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        );
    }
  }

  static TextStyle subtitle500(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        );
    }
  }

  static TextStyle subtitle600(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        );
    }
  }

  static TextStyle buttonText(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textDark,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textDark,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        );
    }
  }

  static TextStyle largeMedium14(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        );
    }
  }

  static TextStyle smallMed14(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textDark,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textDark,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        );
    }
  }

  static TextStyle smallMed12(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textDark,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textDark,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
    }
  }

  static TextStyle label(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textSubtitle1,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textSubtitle1,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        );
    }
  }

  static TextStyle labelExtraExtraSmall(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textFieldActiveSearchIconRight,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 14 / 14,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textFieldActiveSearchIconRight,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 14 / 14,
        );
    }
  }

  static TextStyle overLine(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 10,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 10,
        );
    }
  }

  static TextStyle overLineBold(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textMedium,
          fontWeight: FontWeight.w700,
          fontSize: 10,
          height: 12.1 / 10,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textMedium,
          fontWeight: FontWeight.w700,
          fontSize: 10,
          height: 12.1 / 10,
        );
    }
  }

  static TextStyle itemSubtitle(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).infoItemLabel,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).infoItemLabel,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
    }
  }

  static TextStyle itemSubtitle12(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
    }
  }

  static TextStyle itemSubtitle12_600(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
    }
  }

  static TextStyle fieldLabel(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textSubtitle2,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.5,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textSubtitle2,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.5,
        );
    }
  }

  static TextStyle field(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.5,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.5,
        );
    }
  }

  static TextStyle baseXS(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        );
    }
  }

  static TextStyle link(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).accentColorRed,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).accentColorRed,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
    }
  }

  static TextStyle link2(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).infoItemIcons,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).infoItemIcons,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
    }
  }

  static TextStyle richLink(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).accentColorBlue,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).accentColorBlue,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        );
    }
  }

  static TextStyle bodySmall(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 21 / 14,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 21 / 14,
        );
    }
  }

  static TextStyle bodySmallBold(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          height: 21 / 14,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          height: 21 / 14,
        );
    }
  }

  static TextStyle syncPercent(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        );
    }
  }

  static TextStyle buttonSmall(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        );
    }
  }

  static TextStyle errorSmall(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textError,
          fontWeight: FontWeight.w500,
          fontSize: 10,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textError,
          fontWeight: FontWeight.w500,
          fontSize: 10,
        );
    }
  }

  static TextStyle infoSmall(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textSubtitle1,
          fontWeight: FontWeight.w500,
          fontSize: 10,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textSubtitle1,
          fontWeight: FontWeight.w500,
          fontSize: 10,
        );
    }
  }

// Desktop

  static TextStyle desktopH1(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 40,
          height: 40 / 40,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 40,
          height: 40 / 40,
        );
    }
  }

  static TextStyle desktopH2(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 32,
          height: 32 / 32,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 32,
          height: 32 / 32,
        );
    }
  }

  static TextStyle desktopH3(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 24,
          height: 24 / 24,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 24,
          height: 24 / 24,
        );
    }
  }

  static TextStyle desktopTextMedium(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 30 / 20,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 30 / 20,
        );
    }
  }

  static TextStyle desktopTextMediumRegular(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 20,
          height: 30 / 20,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 20,
          height: 30 / 20,
        );
    }
  }

  static TextStyle desktopSubtitleH2(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 20,
          height: 28 / 20,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 20,
          height: 28 / 20,
        );
    }
  }

  static TextStyle desktopSubtitleH1(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 24,
          height: 33 / 24,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 24,
          height: 33 / 24,
        );
    }
  }

  static TextStyle desktopButtonEnabled(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).buttonTextPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 26 / 20,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).buttonTextPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 26 / 20,
        );
    }
  }

  static TextStyle desktopButtonDisabled(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).buttonTextPrimaryDisabled,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 26 / 20,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).buttonTextPrimaryDisabled,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 26 / 20,
        );
    }
  }

  static TextStyle desktopButtonSecondaryEnabled(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).buttonTextSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 26 / 20,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).buttonTextSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 26 / 20,
        );
    }
  }

  static TextStyle desktopButtonSecondaryDisabled(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).buttonTextSecondaryDisabled,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 26 / 20,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).buttonTextSecondaryDisabled,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 26 / 20,
        );
    }
  }

  static TextStyle desktopTextSmall(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          height: 27 / 18,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).buttonTextPrimaryDisabled,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          height: 27 / 18,
        );
    }
  }

  static TextStyle desktopTextExtraSmall(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).buttonTextPrimaryDisabled,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 24 / 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).buttonTextPrimaryDisabled,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 24 / 16,
        );
    }
  }

  static TextStyle desktopTextExtraExtraSmall(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textSubtitle1,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 21 / 14,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textSubtitle1,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 21 / 14,
        );
    }
  }

  static TextStyle desktopTextExtraExtraSmall600(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          height: 21 / 14,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          height: 21 / 14,
        );
    }
  }

  static TextStyle desktopButtonSmallSecondaryEnabled(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).buttonTextSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 24 / 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).buttonTextSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 24 / 16,
        );
    }
  }

  static TextStyle desktopTextFieldLabel(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textSubtitle2,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 30 / 20,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textSubtitle2,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 30 / 20,
        );
    }
  }

  static TextStyle desktopMenuItem(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight.withOpacity(0.8),
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 20.8 / 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight.withOpacity(0.8),
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 20.8 / 16,
        );
    }
  }

  static TextStyle desktopMenuItemSelected(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 20.8 / 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 20.8 / 16,
        );
    }
  }

  static TextStyle settingsMenuItem(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight.withOpacity(0.5),
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 20.8 / 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight.withOpacity(0.5),
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 20.8 / 16,
        );
    }
  }

  static TextStyle settingsMenuItemSelected(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 20.8 / 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          height: 20.8 / 16,
        );
    }
  }

  static TextStyle stepIndicator(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.roboto(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 8,
        );
      case ThemeType.dark:
        return GoogleFonts.roboto(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w600,
          fontSize: 8,
        );
    }
  }

  static TextStyle numberDefault(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.roboto(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 32,
          height: 34 / 32,
        );
      case ThemeType.dark:
        return GoogleFonts.roboto(
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 32,
          height: 34 / 32,
        );
    }
  }

  static TextStyle datePicker400(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          letterSpacing: 0.5,
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          letterSpacing: 0.5,
          color: _theme(context).textLight,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        );
    }
  }

  static TextStyle datePicker600(BuildContext context) {
    switch (_theme(context).themeType) {
      case ThemeType.light:
        return GoogleFonts.poppins(
          letterSpacing: 0.5,
          color: _theme(context).textDark,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        );
      case ThemeType.dark:
        return GoogleFonts.poppins(
          letterSpacing: 0.5,
          color: _theme(context).textDark,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        );
    }
  }
}
