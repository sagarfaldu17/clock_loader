import 'package:flutter/services.dart';
import 'package:sf_biomatric_auth/Helper/constents.dart';

class MethodChannelService {

  factory MethodChannelService() {
    return _methodChannelServiceSingleton;
  }
  static final _methodChannelServiceSingleton = MethodChannelService._internal();
  MethodChannelService._internal();

  Future<String> getDeviceBioMatricType() async {
    const _kBioMatricMethodChannel = MethodChannel(kBioMatricMethodChannel);
    final String _deviceBioMatricType =
    await _kBioMatricMethodChannel.invokeMethod(kGetDeviceBioMatricType);
    return _deviceBioMatricType;
  }

  Future<bool> isBioMatricAvailable() async {
    const _kBioMatricMethodChannel = MethodChannel(kBioMatricMethodChannel);
    final bool _isBioMatricAvailable = await _kBioMatricMethodChannel.invokeMethod(kIsBioMatricAvailable);
    return _isBioMatricAvailable;
  }
}