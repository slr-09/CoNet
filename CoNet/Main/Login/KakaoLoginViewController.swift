//
//  KakaoLoginViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/04.
//
import Alamofire
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

    @objc func loginButtonTapped() {
        kakaoLogin() // 카카오 로그인 시도
        print("# requestKakaoLogin() 완료")
        
        // 회원 정보 조회
        getUserInfoAndCheckRegistration()
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
    
    func kakaoLogin() {
        // 카카오톡 실행 가능 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoTalk() success")
                    print("Kakao id token: \(String(describing: oauthToken?.idToken) )")
                    
                    // do something
                    _ = oauthToken
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("Kakao id token: \(String(describing: oauthToken?.idToken))")
                    
                    // do something
                    _ = oauthToken
                }
            }
        }
    }
    
    func getUserInfoAndCheckRegistration() {
        // 카카오 사용자 정보 가져오기
        UserApi.shared.me { user, error in
            if let error = error {
                print("# me() 실패")
                print(error)
                return
            }
            // 카카오 사용자 정보 조회 성공
            print("# me() 성공.")

            self.requestIsRegistered(from: "서버 URL") { isRegistered in
                if isRegistered {
                    // 이미 등록된 회원이라면 메인 화면으로 이동
                    self.showMainScreen()
                } else {
                    // 회원이 등록되지 않았다면 회원가입을 진행
                    self.createAccount()
                }
            }
        }
    }
    
    func requestIsRegistered(from url: String, completion: @escaping (Bool) -> Void) {
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let data):
                if let isRegistered = data as? Bool {
                    // 서버에서 받은 isRegistered 값을 반환
                    completion(isRegistered)
                } else {
                    // 값이 잘못 전달된 경우 기본값 false로 처리
                    completion(false)
                }
            case .failure(let error):
                print("서버 요청 실패: \(error)")
                // 요청 실패 시 기본값 false로 처리
                completion(false)
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
                self.showMainScreen()
            }
        }
    }
        
    // 사용자 정보 가져오기
    func printMyUserInfo(completion: @escaping (Bool) -> Void) {
        UserApi.shared.me { user, error in
            if let error = error {
                print("# me() failed")
                print(error)
                completion(false)
            } else {
                print("# me() success.")
                
                // do something
                print("# myInfo's ID : " + (user?.id?.description ?? "ID default value"))
                print("# myInfo's email : " + (user?.kakaoAccount?.email ?? "email default value"))
                print("# myInfo's profileImageUrl : " + (user?.kakaoAccount?.profile?.profileImageUrl?.absoluteString ?? "profileImageUrl default value"))
                print("# myInfo's nickname : " + (user?.kakaoAccount?.profile?.nickname ?? "nickname default value"))
                print("# myInfo's connectedAt : " + (user?.connectedAt?.description ?? "connectedAt default value"))
                
                let isRegistered = Bool.random()
                completion(isRegistered)
            }
        }
    }

    func showMainScreen() {
        let mainViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
}
