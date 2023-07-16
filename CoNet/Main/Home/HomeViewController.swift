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
    
//    let calendarView = CalendarViewController().calendarView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background color를 white로 설정 (default: black)
        view.backgroundColor = .white
        // navigation bar 숨기기
        self.navigationController?.navigationBar.isHidden = true
        
        // layout
        addView()
        layoutConstraints()
    }
    
    func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(alarmBtn)
//        contentView.addSubview(calendarView)
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
            make.height.equalTo(1000)   // 높이를 설정해야 스크롤이 됨
        }
        
        // 알림 버튼 
        alarmBtn.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.top.equalTo(contentView.snp.top).offset(0)
            make.trailing.equalTo(contentView.snp.trailing).offset(0)
        }
        
//        calendarView.snp.makeConstraints { make in
//            make.leading.equalTo(contentView.snp.leading).offset(0)
//            make.trailing.equalTo(contentView.snp.trailing).offset(0)
//            make.top.equalTo(alarmBtn.snp.bottom).offset(30)
//        }
    }

}
