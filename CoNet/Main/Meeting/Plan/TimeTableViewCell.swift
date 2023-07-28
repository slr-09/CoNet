//
//  TimeTableViewCell.swift
//  CoNet
//
//  Created by 가은 on 2023/07/27.
//

import UIKit

class TimeTableViewCell: UICollectionViewCell {
    static let identifier = "\(TimeTableViewCell.self)"

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray100?.cgColor
//        contentView.backgroundColor = UIColor.purpleDisabled
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
