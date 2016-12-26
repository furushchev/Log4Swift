//
//  String+Color.swift
//  Log4Swift
//
//  Created by FurutaYuki on 2016/12/26.
//
//

import Foundation

extension String {
    enum Ansi: Int {
        case StyleReset = 0
        case StyleBold = 1
        case StyleDim = 2
        case StyleUnderscore = 4
        case StyleBlink = 5
        case StyleReverse = 7
        case StyleHidden = 8
        case StyleStrikeThrough = 9
        case ForeBlack = 30, ForeRed, ForeGreen, ForeYellow, ForeBlue, ForeMagenta, ForeCyan, ForeWhite
        case BackBlack = 40, BackRed, BackGreen, BackYellow, BackBlue, BackMagenta, BackCyan, BackWhite
        case ForeLightBlack = 90, ForeLightRed, ForeLightGreen, ForeLightYellow, ForeLightBlue, ForeLightMagenta, ForeLightCyan, ForeLightWhite
        case BackLightBlack = 100, BackLightRed, BackLightGreen, BackLightYellow, BackLightBlue, BackLightMagenta, BackLightCyan, BackLightWhite
        
        func code() -> String {
            return "\u{1b}\u{5b}\(String(self.rawValue))m"
        }
    }
    
    func WithAnsi(_ code: Ansi, closure: @autoclosure () -> String) -> String {
        let msg = closure()
        let suffix = msg.hasSuffix(Ansi.StyleReset.code()) ? Ansi.StyleReset.code() : String()
        return "\(code.code())\(msg)\(suffix)"
    }
    
    var StyleReset: String { get { return WithAnsi(.StyleReset, closure: self) }}
    var StyleBold: String { get { return WithAnsi(.StyleBold, closure: self) }}
    var StyleDim: String { get { return WithAnsi(.StyleDim, closure: self) }}
    var StyleUnderscore: String { get { return WithAnsi(.StyleUnderscore, closure: self) }}
    var StyleBlink: String { get { return WithAnsi(.StyleBlink, closure: self) }}
    var StyleReverse: String { get { return WithAnsi(.StyleReverse, closure: self) }}
    var StyleHidden: String { get { return WithAnsi(.StyleHidden, closure: self) }}
    var StyleStrikeThrough: String { get { return WithAnsi(.StyleStrikeThrough, closure: self) }}
    
    var ForeBlack: String { get { return WithAnsi(.ForeBlack, closure: self) }}
    var ForeRed: String { get { return WithAnsi(.ForeRed, closure: self) }}
    var ForeGreen: String { get { return WithAnsi(.ForeGreen, closure: self) }}
    var ForeYellow: String { get { return WithAnsi(.ForeYellow, closure: self) }}
    var ForeBlue: String { get { return WithAnsi(.ForeBlue, closure: self) }}
    var ForeMagenta: String { get { return WithAnsi(.ForeMagenta, closure: self) }}
    var ForeCyan: String { get { return WithAnsi(.ForeCyan, closure: self) }}
    var ForeWhite: String { get { return WithAnsi(.ForeWhite, closure: self) }}
    
    var ForeLightBlack: String { get { return WithAnsi(.ForeLightBlack, closure: self) }}
    var ForeLightRed: String { get { return WithAnsi(.ForeLightRed, closure: self) }}
    var ForeLightGreen: String { get { return WithAnsi(.ForeLightGreen, closure: self) }}
    var ForeLightYellow: String { get { return WithAnsi(.ForeLightYellow, closure: self) }}
    var ForeLightBlue: String { get { return WithAnsi(.ForeLightBlue, closure: self) }}
    var ForeLightMagenta: String { get { return WithAnsi(.ForeLightMagenta, closure: self) }}
    var ForeLightCyan: String { get { return WithAnsi(.ForeLightCyan, closure: self) }}
    var ForeLightWhite: String { get { return WithAnsi(.ForeLightWhite, closure: self) }}
    
    var BackBlack: String { get { return WithAnsi(.BackBlack, closure: self) }}
    var BackRed: String { get { return WithAnsi(.BackRed, closure: self) }}
    var BackGreen: String { get { return WithAnsi(.BackGreen, closure: self) }}
    var BackYellow: String { get { return WithAnsi(.BackYellow, closure: self) }}
    var BackBlue: String { get { return WithAnsi(.BackBlue, closure: self) }}
    var BackMagenta: String { get { return WithAnsi(.BackMagenta, closure: self) }}
    var BackCyan: String { get { return WithAnsi(.BackCyan, closure: self) }}
    var BackWhite: String { get { return WithAnsi(.BackWhite, closure: self) }}
    
    var BackLightBlack: String { get { return WithAnsi(.BackLightBlack, closure: self) }}
    var BackLightRed: String { get { return WithAnsi(.BackLightRed, closure: self) }}
    var BackLightGreen: String { get { return WithAnsi(.BackLightGreen, closure: self) }}
    var BackLightYellow: String { get { return WithAnsi(.BackLightYellow, closure: self) }}
    var BackLightBlue: String { get { return WithAnsi(.BackLightBlue, closure: self) }}
    var BackLightMagenta: String { get { return WithAnsi(.BackLightMagenta, closure: self) }}
    var BackLightCyan: String { get { return WithAnsi(.BackLightCyan, closure: self) }}
    var BackLightWhite: String { get { return WithAnsi(.BackLightWhite, closure: self) }}
}
