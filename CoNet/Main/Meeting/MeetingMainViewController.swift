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
    let scrollview = UIScrollView().then { $0.backgroundColor = .clear }
    let contentView = UIView().then { $0.backgroundColor = .clear }
    
    // 사이드바 버튼
    let sidebarButton = UIButton().then { $0.setImage(UIImage(named: "sidebarButton"), for: .normal) }
    
    // 뒤로가기 버튼
    let backButton = UIButton().then { $0.setImage(UIImage(named: "meetingMainBackButton"), for: .normal) }
    
    // 상단 모임 이미지
    let whiteGradientView = WhiteGradientView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    let meetingImage = UIImageView().then {
        $0.image = UIImage(named: "space")
        $0.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색 .white로 지정
        view.backgroundColor = .white
        
        // navigation bar title "iOS 스터디"로 지정
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.title = "iOS 스터디"
        
        // 네비게이션 바 item 추가 - 뒤로가기, 사이드바 버튼
        addNavigationBarItem()
        
        layoutContraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func addNavigationBarItem() {
        // 사이드바 버튼 추가
        sidebarButton.addTarget(self, action: #selector(sidebarButtonTapped), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: sidebarButton)
        navigationItem.rightBarButtonItem = barButtonItem
        
        // 뒤로가기 버튼 추가
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let leftbarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftbarButtonItem
    }
    
    // 뒤로가기 버튼 동작
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // 사이드바 버튼 동작
    @objc private func sidebarButtonTapped() {
        let popupVC = SideBarViewController()
        popupVC.delegate = self
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true, completion: nil)
    }
    
    // 전체 layout constraints
    private func layoutContraints() {
        scrollviewConstraints() // 스크롤뷰
        imageConstraints() // 상단 이미지
    }
    
    // scrollview 추가
    private func scrollviewConstraints() {
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
    }
    
    // 상단 이미지 constraints
    private func imageConstraints() {
        contentView.addSubview(meetingImage)
        meetingImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
            make.top.equalTo(scrollview.snp.top).offset(-98)
        }
        
        contentView.addSubview(whiteGradientView)
        whiteGradientView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(100)
            make.top.equalTo(scrollview.snp.top).offset(-98)
        }
    }
}

extension MeetingMainViewController: ModalViewControllerDelegate {
    func sendDataBack(data: SideBarMenu) {
        var nextVC: UIViewController
        
        switch data {
        case .editInfo: nextVC = MeetingInfoEditViewController()
        case .wait: nextVC = WaitingPlanListViewController()
        case .decided: nextVC = DecidedPlanListViewController()
        case .past: nextVC = PastPlanListViewController()
        case .history: nextVC = HistoryViewController()
        default: nextVC = WaitingPlanListViewController()
        }
        
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
