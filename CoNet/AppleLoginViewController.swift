//
//  AppleLoginViewController.swift
//  CoNet
//
//  Created by 가은 on 2023/06/28.
//

import AuthenticationServices
import UIKit

class AppleLoginViewController: UIViewController {

    let appleLoginBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        willShowButton()
        
        appleLoginBtn.addTarget(self, action: #selector(didClickAppleLoginBtn), for: .touchUpInside)
    }
    
    // 임시 애플 로그인 버튼
    func willShowButton() {
        
        view.backgroundColor = .white
        view.addSubview(appleLoginBtn)
        // constraint 잡아주기 위해
        appleLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        
        appleLoginBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        appleLoginBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        appleLoginBtn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        appleLoginBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        appleLoginBtn.setTitle("apple login", for: .normal)
        appleLoginBtn.setTitleColor(.black, for: .normal)
        appleLoginBtn.backgroundColor = .gray
    }
    
    // 애플 로그인 버튼 클릭 시
    @objc func didClickAppleLoginBtn(_ sender: UITapGestureRecognizer) {
        // request 생성
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        // request를 보내줄 controller 생성
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self as? ASAuthorizationControllerDelegate
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        
        // 요청 보내기
        controller.performRequests()
    }

    
}


extension AppleLoginViewController: ASAuthorizationControllerDelegate {
    // 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let idToken = credential.identityToken!
            let tokenStr = String(data: idToken, encoding: .utf8)
            print(tokenStr)
            
            guard let code = credential.authorizationCode else { return }
            let codeStr = String(data: code, encoding: .utf8)
            print(codeStr)
            
            let user = credential.user
            print(user)
        }
    }
    // 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            print("error")
        }
}
