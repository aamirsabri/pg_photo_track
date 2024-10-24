import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, String fontFamily,FontWeight fontWieght,Color fontColor){
  return TextStyle(fontSize:fontSize, fontFamily: fontFamily,color: fontColor,fontWeight: fontWieght);
}

TextStyle getRegularStyle({double fontSize = FontSize.s12, String fontFamily = FontConstant.fontFamily,FontWeight fontWieght = FontWeightManger.regular,required Color fontColor}){
  return TextStyle(fontSize:fontSize, fontFamily: fontFamily,color: fontColor,fontWeight: fontWieght);
}

TextStyle getLightStyle({double fontSize = FontSize.s12,String fontFamily = FontConstant.fontFamily, FontWeight fontWeight = FontWeightManger.light,required Color fontColor}){
    return _getTextStyle(fontSize, fontFamily, fontWeight, fontColor);
}

TextStyle getMediumStyle({double fontSize = FontSize.s12,String fontFamily = FontConstant.fontFamily, FontWeight fontWeight = FontWeightManger.medium,required Color fontColor}){
    return _getTextStyle(fontSize, fontFamily, fontWeight, fontColor);
}

TextStyle getSemiBoldStyle({double fontSize = FontSize.s12,String fontFamily = FontConstant.fontFamily, FontWeight fontWeight = FontWeightManger.semiBold,required Color fontColor}){
    return _getTextStyle(fontSize, fontFamily, fontWeight, fontColor);
}

TextStyle getBoldStyle({double fontSize = FontSize.s12,String fontFamily = FontConstant.fontFamily, FontWeight fontWeight = FontWeightManger.bold,required Color fontColor}){
    return _getTextStyle(fontSize, fontFamily, fontWeight, fontColor);
}