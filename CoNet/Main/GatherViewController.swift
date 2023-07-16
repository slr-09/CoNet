//
//  GatherViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/15.
//

import SnapKit
import Then
import UIKit

class MeetingCell: UICollectionViewCell {
    static let identifier = "MeetingCell"

    let imageView = UIImageView()
    let titleLabel = UILabel()
    let starButton = UIButton()
    var onStarButtonTapped: (() -> Void)?
    
    @objc func starButtonTapped() {
        onStarButtonTapped?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(starButton)

        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.width.equalTo(164)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }

        starButton.snp.makeConstraints { make in
            make.top.equalTo(imageView).offset(8)
            make.right.equalTo(imageView).offset(-8)
        }
        
        titleLabel.numberOfLines = 2
        titleLabel.text = "제목은 최대 두 줄, 더 길어지면 말 줄임표를 사용"
        titleLabel.font = UIFont.body1Bold

        starButton.setImage(UIImage(named: "star"), for: .normal)
        starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var item: UIStackView!
    var meetings = [Int](repeating: 0, count: 4)
    var favoritedMeetings = [Int]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if selectedTabIndicator.frame.origin.x == favTab.frame.origin.x {
            return favoritedMeetings.count
        } else {
            return meetings.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MeetingCell.identifier, for: indexPath) as! MeetingCell

        let meetingIndex: Int
        // If the favorites tab is selected, only use the favorited meetings
        if selectedTabIndicator.frame.origin.x == favTab.frame.origin.x {
            meetingIndex = favoritedMeetings[indexPath.row]
        } else {
            meetingIndex = indexPath.row
        }

        let imageName = favoritedMeetings.contains(meetingIndex) ? "fullstar" : "star"
        cell.starButton.setImage(UIImage(named: imageName), for: .normal)

        // Handle the star button tap
        cell.onStarButtonTapped = {
            if let index = self.favoritedMeetings.firstIndex(of: meetingIndex) {
                // If the meeting is already favorited, unfavorite it
                self.favoritedMeetings.remove(at: index)
            } else {
                // Otherwise, favorite the meeting
                self.favoritedMeetings.append(meetingIndex)
            }

            // Update the star image for the cell
            let newImageName = self.favoritedMeetings.contains(meetingIndex) ? "fullstar" : "star"
            cell.starButton.setImage(UIImage(named: newImageName), for: .normal)

            // Always reload the collection view because both tabs need to be updated
            collectionView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let _: CGFloat = (collectionView.frame.width / 2) - 17
        return CGSize(width: 164, height: 232)
    }
    
    let gatherLabel = UILabel().then {
        $0.text = "모임"
        $0.font = UIFont.headline1
    }
    
    let gatherMark = UIImageView().then {
        $0.image = UIImage(systemName: "gather")
    }
    
    let allTab = UIButton().then {
        $0.setTitle("전체", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.headline3Bold
    }
    
    let favTab = UIButton().then {
        $0.setTitle("즐겨찾기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.headline3Bold
    }
    
    let selectedTabIndicator = UIView().then {
        $0.backgroundColor = UIColor.purpleMain
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
        
    let plusButton = UIButton().then {
        $0.setImage(UIImage(named: "plus"), for: .normal)
    }
    
    let peopleButton = UIButton().then {
        $0.setImage(UIImage(named: "add"), for: .normal)
    }
    
    let participateButton = UIButton().then {
        $0.setImage(UIImage(named: "gatherPeople"), for: .normal)
    }
    
    let joinLabel = UILabel().then {
        $0.text = "모임 참여"
        $0.font = UIFont.body1Bold
        $0.textColor = UIColor.white
    }
    
    let addLabel = UILabel().then {
        $0.text = "모임 추가"
        $0.font = UIFont.body1Bold
        $0.textColor = UIColor.white
    }
    
    let overlayView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        item = UIStackView(arrangedSubviews: [allTab, favTab]).then {
            $0.axis = .horizontal
            $0.spacing = 17
        }
        
        self.view.backgroundColor = .white
        self.view.addSubview(gatherLabel)
        self.view.addSubview(item)
        self.view.addSubview(selectedTabIndicator)
        
        applyConstraintsToTabs(stackView: item)

        allTab.addTarget(self, action: #selector(didSelectAllTab), for: .touchUpInside)
        favTab.addTarget(self, action: #selector(didSelectFavoriteTab), for: .touchUpInside)
        
        self.view.addSubview(plusButton)
        applyConstraintsToPlusButton()
        
        self.view.addSubview(collectionView)
        applyConstraintsToCollectionView()

        setupCollectionView()
        self.view.addSubview(peopleButton)
        self.view.addSubview(joinLabel)
        self.view.addSubview(participateButton)
        self.view.addSubview(addLabel)

        applyConstraintsToPlusButton()
        applyConstraintsToPeopleButtonAndJoinLabel()
        applyConstraintsToPartButtonAndAddLabel()

        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            overlayView.frame = self.view.bounds
            overlayView.alpha = 0
            self.view.addSubview(overlayView)
            
            // Adjust the view order here so that the selected elements are above the overlay
            self.view.bringSubviewToFront(plusButton)
            self.view.bringSubviewToFront(peopleButton)
            self.view.bringSubviewToFront(participateButton)
            self.view.bringSubviewToFront(addLabel)
            self.view.bringSubviewToFront(joinLabel)
        
        UIView.animate(withDuration: 0.3) {
            self.peopleButton.alpha = 0
            self.participateButton.alpha = 0
            self.joinLabel.alpha = 0
            self.addLabel.alpha = 0
            self.overlayView.alpha = 0  // Change alpha here
        }
    }
    
    func applyConstraintsToPlusButton() {
        plusButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.right.equalTo(self.view).offset(-24)
        }
    }
        
    func applyConstraintsToCollectionView() {
        let safeArea = view.safeAreaLayoutGuide
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(selectedTabIndicator.snp.bottom).offset(16)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
            make.bottom.equalTo(plusButton.snp.top).offset(-16)
        }
    }

    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MeetingCell.self, forCellWithReuseIdentifier: MeetingCell.identifier)
    }
    
    func applyConstraintsToTabs(stackView: UIStackView) {
        gatherLabel.snp.makeConstraints { make in
            let safeArea = view.safeAreaLayoutGuide
            make.top.equalTo(safeArea.snp.top).offset(38)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        item.snp.makeConstraints { make in
            make.top.equalTo(gatherLabel.snp.bottom).offset(24)
            make.left.equalTo(self.view).offset(24)
        }
        selectedTabIndicator.snp.makeConstraints { make in
            make.top.equalTo(allTab.snp.bottom).offset(4)
            make.height.equalTo(2)
            make.left.right.equalTo(allTab)
        }
    }
    
    func applyConstraintsToPeopleButtonAndJoinLabel() {
        peopleButton.snp.makeConstraints { make in
            make.bottom.equalTo(plusButton.snp.top).offset(-14)
            make.centerX.equalTo(plusButton)
        }
        
        joinLabel.snp.makeConstraints { make in
            make.centerY.equalTo(peopleButton)
            make.right.equalTo(peopleButton.snp.left).offset(-11)
        }
    }

    func applyConstraintsToPartButtonAndAddLabel() {
        participateButton.snp.makeConstraints { make in
            make.bottom.equalTo(peopleButton.snp.top).offset(-14)
            make.centerX.equalTo(plusButton)
        }
        
        addLabel.snp.makeConstraints { make in
            make.centerY.equalTo(participateButton)
            make.right.equalTo(participateButton.snp.left).offset(-11)
        }
    }
    
    @objc func didSelectAllTab() {
        selectedTabIndicator.snp.remakeConstraints { make in
            make.top.equalTo(allTab.snp.bottom).offset(4)
            make.height.equalTo(2)
            make.left.right.equalTo(allTab)
        }

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func didSelectFavoriteTab() {
        selectedTabIndicator.snp.remakeConstraints { make in
            make.top.equalTo(favTab.snp.bottom).offset(4)
            make.height.equalTo(2)
            make.left.right.equalTo(favTab)
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        collectionView.reloadData()
    }
    
    @objc func didTapPlusButton() {
        if plusButton.currentImage == UIImage(named: "plus") {
            plusButton.setImage(UIImage(named: "x"), for: .normal)
            
            UIView.animate(withDuration: 0.3) {
                self.peopleButton.alpha = 1
                self.participateButton.alpha = 1
                self.joinLabel.alpha = 1
                self.addLabel.alpha = 1
                self.overlayView.alpha = 0.8  // Change alpha here
            }
        } else {
            plusButton.setImage(UIImage(named: "plus"), for: .normal)
            
            UIView.animate(withDuration: 0.3) {
                self.peopleButton.alpha = 0
                self.participateButton.alpha = 0
                self.joinLabel.alpha = 0
                self.addLabel.alpha = 0
                self.overlayView.alpha = 0  // Change alpha here
            }
        }
    }
}
