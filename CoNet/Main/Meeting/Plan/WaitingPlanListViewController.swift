//
//  WaitingPlanListViewController.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/22.
//

import SnapKit
import Then
import UIKit

class WaitingPlanCell: UICollectionViewCell {
    static let registerId = "\(WaitingPlanCell.self)"
    
    // 배경
    let background = UIView().then {
        $0.backgroundColor = UIColor.grayWhite
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        
        $0.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        $0.layer.borderWidth = 1
    }
    
    // 날짜View - 시작 날짜, 구분선, 끝 날짜
    let dateView = UIView().then { $0.backgroundColor = .clear }
    let startDateLabel = UILabel().then {
        $0.text = "2023. 07. 02"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textHigh
    }
    let finishDateLabel = UILabel().then {
        $0.text = "2023. 07. 08"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textHigh
    }
    let divider = UILabel().then {
        $0.text = "-"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textHigh
    }
    
    // 세로 구분선
    let verticalDivider = UIView().then { $0.backgroundColor = UIColor.iconDisabled }
    
    // 약속 이름
    let planTitleLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.text = "제목은 최대 두 줄, 더 늘어나면 말줄임표로"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textHigh
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutContraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutContraints()
    }
    
    // 전체 constraints
    private func layoutContraints() {
        backgroundConstraints()
        dateViewConstraints()
        verticalDividerConstraints()
        planTitleConstraints()
    }
    
    private func backgroundConstraints() {
        addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    private func dateViewConstraints() {
        dateView.addSubview(startDateLabel)
        startDateLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.top.equalTo(dateView.snp.top)
        }
        
        dateView.addSubview(finishDateLabel)
        finishDateLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.bottom.equalTo(dateView.snp.bottom)
        }
        
        dateView.addSubview(divider)
        divider.snp.makeConstraints { make in
            make.center.equalTo(dateView.snp.center)
        }
        
        background.addSubview(dateView)
        dateView.snp.makeConstraints { make in
            make.width.equalTo(startDateLabel.snp.width)
            make.height.equalTo(background).offset(-40)
            make.top.equalTo(background.snp.top).offset(20)
            make.leading.equalTo(background.snp.leading).offset(20)
        }
    }
    
    private func verticalDividerConstraints() {
        background.addSubview(verticalDivider)
        verticalDivider.snp.makeConstraints { make in
            make.height.equalTo(26)
            make.width.equalTo(1)
            make.centerY.equalTo(background.snp.centerY)
            make.leading.equalTo(dateView.snp.trailing).offset(20)
        }
    }
    
    private func planTitleConstraints() {
        background.addSubview(planTitleLabel)
        planTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.centerY.equalTo(background.snp.centerY)
            make.leading.equalTo(verticalDivider.snp.trailing).offset(20)
            make.trailing.equalTo(background.snp.trailing).offset(-20)
        }
    }
}

class PlanListCollectionView: UIView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        $0.backgroundColor = UIColor.gray50
        $0.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        collectionView.showsVerticalScrollIndicator = false
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.centerY.equalToSuperview()
        }
    }
}

class WaitingPlanListViewController: UIViewController {
    private lazy var mainView = PlanListCollectionView.init(frame: self.view.frame)

//    static func instance() -> ViewController {
//        return ViewController.init(nibName: nil, bundle: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainView
        
        view.backgroundColor = UIColor.gray50
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(WaitingPlanCell.self, forCellWithReuseIdentifier: WaitingPlanCell.registerId)
    }
}

extension WaitingPlanListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 각 셀을 클릭했을 때 이벤트 처리
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected cell at indexPath: \(indexPath)")
    }
    
    // 셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    // 셀
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaitingPlanCell.registerId, for: indexPath) as? WaitingPlanCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    // 셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize.init(width: width, height: 92)
    }
    
    // 셀 사이의 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        WaitingPlanListViewController().showPreview(.iPhone14Pro)
    }
}
#endif
