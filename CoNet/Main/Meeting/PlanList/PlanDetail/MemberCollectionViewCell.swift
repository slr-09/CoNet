//
//  MemberCollectionView.swift
//  CoNet
//
//  Created by 정아현 on 2023/08/08.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {
    private let memberImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 21
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let memberNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.body2Medium
        label.text = "참여자 이름"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(memberImageView)
        addSubview(memberNameLabel)
        
        memberImageView.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
        
        memberNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(memberImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    func configure(with member: PlanDetail) {
        memberImageView.image = UIImage(named: "defaultProfile")
        memberNameLabel.text = member.members[0].name
    }
}

