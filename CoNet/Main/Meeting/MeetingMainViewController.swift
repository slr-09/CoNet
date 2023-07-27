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
    
    // 즐겨찾기 버튼
    let starButton = UIImageView().then {
        $0.image = UIImage(named: "meetingStarOff")
    }
    
    // 모임 이름
    let meetingName = UILabel().then {
        $0.text = "iOS 스터디"
        $0.font = UIFont.headline1
        $0.textColor = UIColor.textHigh
    }
    
    // 약속 만들기 버튼
    let addMeetingButton = UIButton().then {
        $0.setTitle("약속 만들기", for: .normal)
        $0.setTitleColor(UIColor.textHigh, for: .normal)
        $0.titleLabel?.font = UIFont.body2Medium
        $0.layer.cornerRadius = 16.5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.purpleMain?.cgColor
    }
    
    // 멤버 이미지
    let memberImage = UIImageView().then {
        $0.image = UIImage(named: "meetingMember")
    }
    
    // 멤버 수
    let memberNum = UILabel().then {
        $0.text = "n명"
        $0.textColor = UIColor.textMedium
        $0.font = UIFont.body1Medium
    }
    
    // 캘린더뷰
    let calendarView = CalendarView().then {
        $0.layer.borderWidth = 0.2
        $0.layer.borderColor = UIColor.gray300?.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색 .white로 지정
        view.backgroundColor = .white
        
        // navigation bar title "iOS 스터디"로 지정
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "iOS 스터디"
        
        // 네비게이션 바 item 추가 - 뒤로가기, 사이드바 버튼
        addNavigationBarItem()
        
        layoutContraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
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
        scrollviewConstraints()     // 스크롤뷰
        imageConstraints()          // 상단 이미지
        headerConstraints()         // 모임 정보
        calendarViewConstraints()   // 캘린더 뷰
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
    
    // 캘린더 뷰 위 모임 정보 constraints
    private func headerConstraints() {
        // 즐겨찾기 버튼
        contentView.addSubview(starButton)
        starButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.leading.equalTo(contentView.snp.leading)
            make.centerY.equalTo(meetingImage.snp.bottom)
        }
        
        // 모임 이름
        contentView.addSubview(meetingName)
        meetingName.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.top.equalTo(starButton.snp.bottom).offset(12)
        }
        
        // 약속 만들기 버튼
        contentView.addSubview(addMeetingButton)
        addMeetingButton.snp.makeConstraints { make in
            make.width.equalTo(103)
            make.height.equalTo(33)
            make.centerY.equalTo(meetingName.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
        }
        
        // 멤버 이미지
        contentView.addSubview(memberImage)
        memberImage.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.top.equalTo(meetingName.snp.bottom).offset(6)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        
        // 멤버 수
        contentView.addSubview(memberNum)
        memberNum.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.leading.equalTo(memberImage.snp.trailing).offset(4)
            make.centerY.equalTo(memberImage.snp.centerY)
        }
    }
    
    // 캘린더뷰
    func calendarViewConstraints() {
        contentView.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(memberImage.snp.bottom).offset(40)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(443)
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
