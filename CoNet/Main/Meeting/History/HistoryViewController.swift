//
//  HistoryViewController.swift
//  CoNet
//
//  Created by 가은 on 2023/07/23.
//

import SnapKit
import Then
import UIKit

class HistoryViewController: UIViewController {
    // 추가 버튼
    let addBtn = UIButton().then {
        $0.setTitle("추가", for: .normal)
        $0.titleLabel?.font = UIFont.headline3Medium
        $0.setTitleColor(UIColor.purpleMain, for: .normal)
    }
    
    let data = HistoryData.data
    
    // collectionView: history
    let historyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // navigation bar title "iOS 스터디"로 지정
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "히스토리"
        
        // 네비게이션 바 item 추가 - 뒤로가기, 사이드바 버튼
        addNavigationBarItem()
        
        layoutConstraints()
        collectionViewSetting()
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
        addBtn.addTarget(self, action: #selector(addHistory), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: addBtn)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    // 추가 버튼
    @objc func addHistory() {
        let nextVC = UnResgisteredPlanListViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // history collectionView setting
    func collectionViewSetting() {
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        historyCollectionView.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.identifier)
    }
    
    // 전체 layout
    func layoutConstraints() {
        historyConstraints()
    }
    
    func historyConstraints() {
        historyCollectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(historyCollectionView)
        historyCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalToSuperview()
        }
    }
}

extension HistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 각 셀을 클릭했을 때 이벤트 처리
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected cell at indexPath: \(indexPath)")
    }
    
    // 셀 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.identifier, for: indexPath) as? HistoryCell else {
            return UICollectionViewCell()
        }
        
        cell.date.text = data[indexPath.item].date
        cell.planTitle.text = data[indexPath.item].title
        cell.memberNum.text = data[indexPath.item].memberCount
        if let image = data[indexPath.item].image {
            cell.historyImage.image = image
        }
        if let description = data[indexPath.item].description {
            cell.contents.text = description
        }
        
        return cell
    }
    
    // 셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        var height = CGFloat(200)
        if data[indexPath.item].image != nil {
            height += width
        }
        
        return CGSize(width: width, height: height)
    }
    
    // 셀 사이의 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 원래 80인데 20으로 함
        return 20
    }
}

struct History {
    let date, title, memberCount: String
    let image: UIImage?
    let description: String?
}

struct HistoryData {
    static let data: [History] = [History(date: "2023. 08. 10", title: "iOS 스터디 3차", memberCount: "3명", image: UIImage(named: "space"), description: nil),
                                  History(date: "2023. 08. 02", title: "iOS 스터디 2차", memberCount: "2명", image: nil, description: "아이오에스 스터디를 했습니다. 와!! 아이오에스 스터디를 했습니다. 와!! 아이오에스 스터디를 했습니다. 와!! 아이오에스 스터디를 했습니다. 와!! 아이오에스 스터디를 했습니다. 와!! 아이오에스 스터디를 했습니다. 와!! 아이오에스 스터디를 했습니다. 와!! 아이오에스 스터디를 했습니다. 와!! 아이오에스 스터디를 했습니다. 와!! 아이오에스 스터디를 했습니다. 와!! 아이오에스 스터디를 했습니다. 와!! 아이오에스 스터디를 했습니다. 와!! 아이오에스 스터디를 했습니다. 와!! 아이오에스 스터디를 했습니다. 와!!"),
                                  History(date: "2023. 08. 10", title: "iOS 스터디 3차", memberCount: "3명", image: UIImage(named: "space"), description: "내용내용내용")]
}
