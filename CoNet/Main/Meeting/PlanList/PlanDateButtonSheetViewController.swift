import Then
import UIKit

class PlanDateButtonSheetViewController: UIViewController {
    
    let background = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    let bottomSheetView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    let grayLine = UIView().then {
        $0.layer.backgroundColor = UIColor.iconDisabled?.cgColor
        $0.layer.cornerRadius = 1.5
    }
    
    let calendarView = CalendarView()
    
    let applyButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 345, height: 44)
        $0.backgroundColor = UIColor.gray200
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("적용하기", for: .normal)
        $0.titleLabel?.font = UIFont.body1Medium
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(background)
        view.addSubview(bottomSheetView)
        view.addSubview(grayLine)
        view.addSubview(calendarView)
        view.addSubview(applyButton)
        
        layoutConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closePopUp))
        background.addGestureRecognizer(tapGesture)
    }
    
    @objc func closePopUp() {
        dismiss(animated: true, completion: nil)
    }
    
    private func layoutConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bottomSheetView.snp.makeConstraints { make in
            make.height.equalTo(469)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
        calendarView.snp.makeConstraints { make in
            make.height.equalTo(307)
            make.top.equalTo(bottomSheetView.snp.top).offset(0)
            make.leading.equalTo(bottomSheetView.snp.leading).offset(0)
            make.trailing.equalTo(bottomSheetView.snp.trailing).offset(0)
        }
        applyButton.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo(44)
            make.top.equalTo(calendarView.snp.bottom).offset(22)
            make.leading.equalTo(bottomSheetView.snp.leading).offset(24)
            make.trailing.equalTo(bottomSheetView.snp.trailing).offset(-24)
            make.bottom.equalTo(view.snp.bottom).offset(-45)
        }
    }
}
