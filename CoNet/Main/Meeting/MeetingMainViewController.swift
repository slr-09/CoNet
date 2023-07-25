//
//  MeetingMainViewController.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/25.
//

import SnapKit
import Then
import UIKit

class MeetingMainViewController: UIViewController {
    
    let scrollview = UIScrollView().then {
        $0.backgroundColor = .clear
    }
    
    let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    // 사이드바 버튼
    let sidebarButton = UIButton().then {
        $0.setImage(UIImage(named: "sidebarButton"), for: .normal)
    }
    
    // 뒤로가기 버튼
    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "meetingMainBackButton"), for: .normal)
    }
    
    let meetingImage = UIImageView().then {
        $0.image = UIImage(named: "space")
        $0.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.title = "iOS 스터디"
        
        sidebarButton.addTarget(self, action: #selector(sidebarButtonTapped), for: .touchUpInside)
        // UIBarButtonItem 생성
        let barButtonItem = UIBarButtonItem(customView: sidebarButton)
        
        // 네비게이션 바에 추가
        navigationItem.rightBarButtonItem = barButtonItem
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        // UIBarButtonItem 생성
        let leftbarButtonItem = UIBarButtonItem(customView: backButton)
        
        // 네비게이션 바에 추가
        navigationItem.leftBarButtonItem = leftbarButtonItem
        
        layoutContraints()
    }
    
    @objc private func backButtonTapped() {
        // 이미지 버튼이 탭되었을 때 동작할 코드를 여기에 작성
        print("Image Button Tapped!")
    }
    
    @objc private func sidebarButtonTapped() {
        // 이미지 버튼이 탭되었을 때 동작할 코드를 여기에 작성
        print("Image Button Tapped!")
    }
    
    private func layoutContraints() {
        view.addSubview(scrollview)
        scrollview.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
        
        scrollview.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollview.contentLayoutGuide)
            make.width.equalTo(scrollview.frameLayoutGuide)
            make.height.equalTo(2000)
        }
        
        imageConstaints()
    }

    private func imageConstaints() {
        contentView.addSubview(meetingImage)
        meetingImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
            make.top.equalTo(scrollview.snp.top).offset(-98)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        MeetingMainViewController().showPreview(.iPhone14Pro)
    }
}
#endif
