//
//  KakaoLoginViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/04.
//

import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import SnapKit
import UIKit

class KakaoLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLoginButton()
    }
    
    func setupLoginButton() {
        let loginButton = UIButton()
        
        // 이미지 파일을 버튼의 배경 이미지로 설정
        let kakaoImage = UIImage(named: "kakao_login")
        loginButton.setBackgroundImage(kakaoImage, for: .normal)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    @objc func loginButtonTapped() {
        
        // requestKakaoLogin()
        kakaoLogin() // 예외 처리 가정
        print("# requestKakaoLogin() 완료")
        
        printMyUserInfo()
        
    }
    
    func kakaoLogin() {
        
        // 카카오톡 실행 가능 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoTalk() success")
                    print("Kakao id token: (oauthToken.idToken)")
                    
                    // do something
                    _ = oauthToken
                }
            }
        }
        
        // 카카오계정으로 로그인
        else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("Kakao id token: (oauthToken.idToken)")
                    
                    // do something
                    _ = oauthToken
                }
            }
        }
        
    }
    
    // 카카오계정 가입 후 로그인하기
    func createAccount() {
        UserApi.shared.loginWithKakaoAccount(prompts: [.Create]) {(oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoAccount() success.")
                
                // do something
                _ = oauthToken
            }
        }
    }
        
    // 사용자 정보 가져오기
    func printMyUserInfo() {
            
        UserApi.shared.me {(user, error) in
            if let error = error {
                print("# me() failed")
                print(error)
            } else {
                print("# me() success.")
                    
                // do something
                print("# myInfo's ID : " + (user?.id?.description ?? "ID default value"))
                print("# myInfo's email : " + (user?.kakaoAccount?.email ?? "email default value"))
                print("# myInfo's profileImageUrl : " + (user?.kakaoAccount?.profile?.profileImageUrl?.absoluteString ?? "profileImageUrl default value"))
                print("# myInfo's nickname : " + (user?.kakaoAccount?.profile?.nickname ?? "nickname default value"))
                print("# myInfo's connectedAt : " + (user?.connectedAt?.description ?? "connectedAt default value"))
                    
            }
        }
            
    }
        
}
