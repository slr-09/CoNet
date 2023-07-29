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
        contentView.backgroundColor = UIColor.white
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                changeCellColor()
            } 
        }
    }
    
    // 셀 클릭 시 background color 바꾸기
    func changeCellColor() {
        if contentView.backgroundColor == UIColor.white {
            contentView.layer.backgroundColor = UIColor(red: 0.677, green: 0.525, blue: 1, alpha: 0.5).cgColor
        } else {
            contentView.layer.backgroundColor = UIColor.white.cgColor
        }
        
    }
    
}
