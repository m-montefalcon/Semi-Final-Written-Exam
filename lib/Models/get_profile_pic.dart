
import 'package:flutter/material.dart';

class ProfilePic {
  var primaryImage = AssetImage('assets/images/profile.png');

  setProfilePic(var pic){
    primaryImage = pic;
  }

  getProfilePic(){
    return primaryImage;
  }
}