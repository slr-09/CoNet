//
//  FontExtension.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/05.
//

import UIKit

/*
    사용 방법 - lineHeight는 별도 지정 필요
    
    let lable = UILable()
    lable.font = UIFont.headline1
    lable.lineHeight = 36
 */

extension UIFont {
    // headline1: lineHeight 36
    static let headline1 = UIFont.systemFont(ofSize: 26, weight: .bold)
    
    // headline2: lineHeight 26
    static let headline2Regular = UIFont.systemFont(ofSize: 20, weight: .regular)
    static let headline2Bold = UIFont.systemFont(ofSize: 20, weight: .bold)
    
    // headline3: lineHeight 22
    static let headline3Regular = UIFont.systemFont(ofSize: 18, weight: .regular)
    static let headline3Bold = UIFont.systemFont(ofSize: 18, weight: .bold)
    
    // body1: lineHeight 20
    static let body1Regular = UIFont.systemFont(ofSize: 16, weight: .regular)
    static let body1Medium = UIFont.systemFont(ofSize: 16, weight: .medium)
    static let body1Bold = UIFont.systemFont(ofSize: 16, weight: .bold)
    
    // body2: lineHeight 18
    static let body2Medium = UIFont.systemFont(ofSize: 14, weight: .medium)
    static let body2Bold = UIFont.systemFont(ofSize: 14, weight: .bold)
    
    // body3: lineHeight 16
    static let body3Medium = UIFont.systemFont(ofSize: 12, weight: .medium)
    static let body3Bold = UIFont.systemFont(ofSize: 12, weight: .bold)
    
    // caption: lineHeight 16
    static let caption = UIFont.systemFont(ofSize: 12, weight: .regular)
    
    // overline: lineHeight 12
    static let overline = UIFont.systemFont(ofSize: 10, weight: .regular)
}
