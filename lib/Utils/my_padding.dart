import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'size_config.dart';




//padding
///////////////////
EdgeInsets PADDING_symmetric({double horizontalFactor,double verticalFactor}) {
  if(horizontalFactor!=null&&verticalFactor!=null)
  {
    return  EdgeInsets.symmetric(
        horizontal: SizeConfig.safeBlockHorizontal * horizontalFactor,
        vertical: SizeConfig.safeBlockVertical * verticalFactor);
  }
  else if(horizontalFactor==null&&verticalFactor!=null)
  {
    return  EdgeInsets.symmetric(
        vertical: SizeConfig.safeBlockVertical * verticalFactor);

  }
  else if(horizontalFactor!=null&&verticalFactor==null)
  {
    return  EdgeInsets.symmetric(
        horizontal: SizeConfig.safeBlockHorizontal * horizontalFactor);
  }
  else
  {
    return EdgeInsets.symmetric(
        horizontal: SizeConfig.safeBlockHorizontal ,
        vertical: SizeConfig.safeBlockVertical );
  }

}

EdgeInsets PADDING_only({double left,double right,double top,double bottom}) {

  return  EdgeInsets.only(
    left: left!=null? SizeConfig.safeBlockHorizontal * left :0,
    right: right!=null? SizeConfig.safeBlockVertical * right :0,
    top: top!=null?  SizeConfig.safeBlockVertical * top :0,
    bottom: bottom!=null? SizeConfig.safeBlockVertical * bottom :0,
  );


}

EdgeInsets PADDING_all({double factor}) {
  return EdgeInsets.all( SizeConfig.safeBlockHorizontal*factor );
}



