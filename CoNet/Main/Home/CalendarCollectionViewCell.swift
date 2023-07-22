//
//  CalendarCollectionViewCell.swift
//  CoNet
//
//  Created by 가은 on 2023/07/20.
//
import SnapKit
import Then
import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    
    private lazy var dayLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureday(text: String) {
        self.addSubview(dayLabel)
        
        dayLabel.text = text
        dayLabel.font = UIFont.body2Bold
        
        dayLabel.snp.makeConstraints { make in
//            make.width.equalTo(48)
//            make.height.equalTo(48)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    func setSundayColor() {
        dayLabel.textColor = UIColor.error
    }
    
    func setWeekdayColor() {
        dayLabel.textColor = UIColor.black
    }
}
