//
//  HomeViewController.swift
//  CoNet
//
//  Created by 가은 on 2023/07/08.
//

import SnapKit
import Then
import UIKit

class HomeViewController: UIViewController {
    // 스크롤뷰
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
    }
    
    // 컴포넌트들이 들어갈 뷰
    let contentView = UIView()
    
    // 알림 버튼
    let alarmBtn = UIButton().then {
        $0.setImage(UIImage(named: "bell"), for: .normal)
    }
    
    // label: 오늘의 약속
    let dayPlanLabel = UILabel().then {
        $0.text = "오늘의 약속"
        $0.font = UIFont.headline2Bold
    }
    
    let planNumCircle = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        $0.layer.cornerRadius = 50
        $0.layer.borderColor = UIColor.purpleMain?.cgColor
        $0.layer.borderWidth = 1
    }
    
    // 약속 수
    let planNum = UILabel().then {
        $0.text = "2"
        $0.textColor = UIColor.purpleMain
        $0.font = UIFont.body3Bold
    }
    
    // tableView: 특정 날짜 약속
    let dayPlanTableView = UITableView().then {
        $0.rowHeight = 92
        $0.separatorStyle = .none
//        $0.backgroundColor = UIColor.red
        $0.register(PlanTableViewCell.self, forCellReuseIdentifier: PlanTableViewCell.identifier)
    }
    
    // label: 대기 중 약속
    let waitingPlanLabel = UILabel().then {
        $0.text = "대기 중인 약속"
        $0.font = UIFont.headline2Bold
    }
    
//    let calendarView = CalendarViewController().calendarView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background color를 white로 설정 (default: black)
        view.backgroundColor = .white
        // navigation bar 숨기기
        navigationController?.navigationBar.isHidden = true
        
        dayPlanTableView.dataSource = self
        dayPlanTableView.delegate = self
        
        // layout
        addView()
        layoutConstraints()
    }
    
    func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(alarmBtn)
        contentView.addSubview(dayPlanLabel)
        contentView.addSubview(planNumCircle)
        contentView.addSubview(planNum)
        contentView.addSubview(dayPlanTableView)
        contentView.addSubview(waitingPlanLabel)
    }
    
    // layout
    func layoutConstraints() {
        // 안전 영역
        let safeArea = view.safeAreaLayoutGuide
        
        // 스크롤뷰
        scrollView.snp.makeConstraints { make in
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
            make.top.equalTo(safeArea.snp.top).offset(13)
            make.bottom.equalTo(safeArea.snp.bottom).offset(0)
        }
        
        // 컴포넌트들이 들어갈 뷰
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(1000) // 높이를 설정해야 스크롤이 됨
        }
        
        // 알림 버튼
        alarmBtn.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.top.equalTo(contentView.snp.top).offset(0)
            make.trailing.equalTo(contentView.snp.trailing).offset(0)
        }
        
        // label: 오늘의 약속
        dayPlanLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(0)
            make.top.equalTo(alarmBtn.snp.bottom).offset(451)
        }
        
//        planNumCircle.snp.makeConstraints { make in
//            make.leading.equalTo(dayPlanLabel.snp.trailing).offset(6)
////            make.top.equalTo(alarmBtn.snp.bottom).offset(451)
//            make.centerY.equalTo(dayPlanLabel.snp.centerY)
//        }
        // label: 약속 수
        planNum.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.leading.equalTo(dayPlanLabel.snp.trailing).offset(6)
            make.centerY.equalTo(dayPlanLabel.snp.centerY)
//            make.centerX.equalTo(planNumCircle.snp.centerX)
        }
        
        // TableView: 특정 날짜 약속
        dayPlanTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(dayPlanLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
        }
        
        // label: 대기 중 약속
        waitingPlanLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(0)
            make.top.equalTo(dayPlanTableView.snp.bottom).offset(50)
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    // 셀 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlanTableViewCell.identifier, for: indexPath) as! PlanTableViewCell
//        cell.time.text = dayPlanData[IndexPath.row].
//        cell.planTitle.text = "test"
//        cell.groupName.text = "ios"
        return cell
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        HomeViewController().showPreview(.iPhone14Pro)
    }
}
#endif
