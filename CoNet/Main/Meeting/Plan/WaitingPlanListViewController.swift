//
//  WaitingPlanListViewController.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/22.
//

import SnapKit
import Then
import UIKit

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
