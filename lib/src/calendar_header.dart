import 'package:flutter/material.dart';
import 'default_styles.dart' show defaultHeaderTextStyle;

class CalendarHeader extends StatelessWidget {
  /// Passing in values for [leftButtonIcon] or [rightButtonIcon] will override [headerIconColor]
  CalendarHeader(
      {@required String headerTitle,
      this.headerMargin,
      this.showHeader,
      this.headerTextStyle,
      this.showHeaderButtons,
      this.headerIconColor,
      this.leftButtonIcon,
      this.rightButtonIcon,
      @required this.onLeftButtonPressed,
      @required this.onRightButtonPressed,
      this.isTitleTouchable,
      @required this.onHeaderTitlePressed}) :
  headerTitle = toFirstLettersUpperCase(headerTitle);

  final String headerTitle;
  final EdgeInsetsGeometry headerMargin;
  final bool showHeader;
  final TextStyle headerTextStyle;
  final bool showHeaderButtons;
  final Color headerIconColor;
  final Widget leftButtonIcon;
  final Widget rightButtonIcon;
  final VoidCallback onLeftButtonPressed;
  final VoidCallback onRightButtonPressed;
  final bool isTitleTouchable;
  final VoidCallback onHeaderTitlePressed;

  TextStyle get getTextStyle =>
      headerTextStyle != null ? headerTextStyle : defaultHeaderTextStyle;

  Widget _leftButton() => IconButton(
        onPressed: onLeftButtonPressed,
        icon: leftButtonIcon ?? Icon(Icons.chevron_left, color: headerIconColor),
      );

  Widget _rightButton() => IconButton(
        onPressed: onRightButtonPressed,
        icon: rightButtonIcon ?? Icon(Icons.chevron_right, color: headerIconColor),
      );

  Widget _headerTouchable() => FlatButton(
        onPressed: onHeaderTitlePressed,
        child: Text(headerTitle, 
          semanticsLabel: headerTitle,
          style: getTextStyle,
        ),
      );

  @override
  Widget build(BuildContext context) => showHeader
      ? Container(
          margin: headerMargin,
          child: DefaultTextStyle(
              style: getTextStyle,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    showHeaderButtons ? _leftButton() : Container(),
                    isTitleTouchable
                        ? _headerTouchable()
                        : Text(headerTitle, style: getTextStyle),
                    showHeaderButtons ? _rightButton() : Container(),
                  ])),
        )
      : Container();

  static String toFirstLettersUpperCase(String text) {
    if (text == null || text.isEmpty) {
      return text;
    }

    var split = text.split(' ');
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i != split.length; i++) {
      String part = split[i];

      if (part.length > 0) {
        buffer.write(part[0].toUpperCase());
        buffer.write(part.substring(1));

        if (i < split.length - 1) {
          buffer.write(' ');
        }
      }
    }

    return buffer.toString();
  }
}
