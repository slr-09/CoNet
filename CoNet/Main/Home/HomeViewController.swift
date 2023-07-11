//
//  HomeViewController.swift
//  CoNet
//
//  Created by 가은 on 2023/07/08.
//

import UIKit

class HomeViewController: UIViewController {

    let label = UILabel().then {
        $0.text = "homeviewcontroller"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide.snp.center).offset(0)
        }
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
