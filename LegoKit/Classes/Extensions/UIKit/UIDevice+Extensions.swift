//
//  UIDevice+Extensions.swift
//  DFLibrary
//
//  Created by forkon on 15/9/10.
//
//

import UIKit
import AudioToolbox

extension UIDevice {
    
    public enum DeviceModel {
        case iPodTouch1G
        case iPodTouch2G
        case iPodTouch3G
        case iPodTouch4G
        case iPodTouch5G
        
        case iPhone2G
        case iPhone3G
        case iPhone3GS
        case iPhone4
        case iPhone4S
        case iPhone5
        case iPhone5C
        case iPhone5S
        case iPhone6
        case iPhone6Plus
        case iPhone6s
        case iPhone6sPlus

        case iPad1
        case iPad2
        case iPad3
        case iPad4
        case iPadAir
        case iPadAir2
        case iPadMini
        case iPadMini2
        case iPadMini3
        
        case simulator
        case unkown
    }
    
    public var deviceCode: String {
        var sysInfo: [CChar] = Array(repeating: 0, count: MemoryLayout<utsname>.size)
    
        let code = sysInfo.withUnsafeMutableBufferPointer {
            (ptr: inout UnsafeMutableBufferPointer<CChar>) -> String in
            uname(UnsafeMutableRawPointer(ptr.baseAddress!).assumingMemoryBound(to: utsname.self))
            let machinePtr = ptr.baseAddress?.advanced(by: Int(_SYS_NAMELEN * 4))
            return String(cString: machinePtr!)
        }
    
        return code
    }
    
    public var deviceModel: DeviceModel {
        
        var model : DeviceModel
        let deviceCode = UIDevice().deviceCode
        switch deviceCode {
            
        case "iPod1,1":                                 model = DeviceModel.iPodTouch1G
        case "iPod2,1":                                 model = DeviceModel.iPodTouch2G
        case "iPod3,1":                                 model = DeviceModel.iPodTouch3G
        case "iPod4,1":                                 model = DeviceModel.iPodTouch4G
        case "iPod5,1":                                 model = DeviceModel.iPodTouch5G
            
        case "iPhone1,1":                               model = DeviceModel.iPhone2G
        case "iPhone1,2":                               model = DeviceModel.iPhone3G
        case "iPhone2,1":                               model = DeviceModel.iPhone3GS
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     model = DeviceModel.iPhone4
        case "iPhone4,1":                               model = DeviceModel.iPhone4S
        case "iPhone5,1", "iPhone5,2":                  model = DeviceModel.iPhone5
        case "iPhone5,3", "iPhone5,4":                  model = DeviceModel.iPhone5C
        case "iPhone6,1", "iPhone6,2":                  model = DeviceModel.iPhone5S
        case "iPhone7,2":                               model = DeviceModel.iPhone6
        case "iPhone7,1":                               model = DeviceModel.iPhone6Plus
        case "iPhone8,2":                               model = DeviceModel.iPhone6
        case "iPhone8,1":                               model = DeviceModel.iPhone6Plus
            
        case "iPad1,1":                                 model = DeviceModel.iPad1
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":model = DeviceModel.iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":           model = DeviceModel.iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":           model = DeviceModel.iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":           model = DeviceModel.iPadAir
        case "iPad5,1", "iPad5,3", "iPad5,4":           model = DeviceModel.iPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":           model = DeviceModel.iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           model = DeviceModel.iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":           model = DeviceModel.iPadMini3
            
        case "i386", "x86_64":                          model = DeviceModel.simulator
        default:                                        model = DeviceModel.unkown //If unknown
        }
        
        return model
    }
    
    /// Has top notch
    ///
    /// Return true if current device is iPhone X, XS, XS Max, XR etc.
    ///
    /// See https://stackoverflow.com/questions/46192280/detect-if-the-device-is-iphone-x/47067296
    ///
    var hasTopNotch: Bool {
        if #available(iOS 11.0,  *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        
        return false
    }
    
    public func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    public func isIPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
