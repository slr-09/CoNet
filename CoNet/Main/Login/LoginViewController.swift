//
//  LoginViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/08.
//

import AuthenticationServices
import KakaoSDKUser
import SnapKit
import Then
import UIKit

class LoginViewController: UIViewController {
    let showSignUpButton = UIButton().then {
        $0.setTitle("회원가입(이용약관) 페이지로", for: .normal)
        $0.setTitleColor(UIColor.purpleMain, for: .normal)
    }
    
    let showMainButton = UIButton().then {
        $0.setTitle("메인 페이지로", for: .normal)
        $0.setTitleColor(UIColor.purpleMain, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tempButtonUI()
        
        showSignUpButton.addTarget(self, action: #selector(showSignUp(_:)), for: .touchUpInside)
        showMainButton.addTarget(self, action: #selector(showMain(_:)), for: .touchUpInside)
    }
    
    @objc func showSignUp(_ sender: UIView) {
        let nextVC = TermsOfUseViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func showMain(_ sender: UIView) {
        let nextVC = TabbarViewController()
        navigationController?.pushViewController(nextVC, animated: true)
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootVC(TabbarViewController(), animated: false)
    }
    
    func tempButtonUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(showSignUpButton)
        showSignUpButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea.snp.centerX)
            make.bottom.equalTo(safeArea.snp.bottom).offset(-60)
        }
        
        view.addSubview(showMainButton)
        showMainButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea.snp.centerX)
            make.bottom.equalTo(safeArea.snp.bottom).offset(-30)
        }
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white

        let titleLabel = UILabel().then {
            $0.text = "우리들의 모임관리"
            $0.font = UIFont.headline3Regular
            $0.textColor = .black
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.02
            
            let attributedText = NSMutableAttributedString(string: "우리들의 모임관리", attributes: [
                NSAttributedString.Key.kern: -0.45,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
            $0.attributedText = attributedText
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(214)
            make.centerX.equalToSuperview().offset(0.5)
            make.width.equalTo(126)
            make.height.equalTo(22)
        }
        
        let logoImageView = UIImageView().then {
            $0.image = UIImage(named: "LaunchScreenImage")
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .clear
        }
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(266)
            make.left.equalToSuperview().offset(130)
            make.right.equalToSuperview().offset(-130)
            make.height.equalTo(198.64)
        }
        
        let kakaoButton = UIButton().then {
            $0.backgroundColor = UIColor(red: 0.976, green: 0.922, blue: 0, alpha: 1)
            $0.layer.cornerRadius = 12
            $0.addTarget(self, action: #selector(kakaoButtonTapped), for: .touchUpInside)
        }
        view.addSubview(kakaoButton)
        kakaoButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(574)
                        make.left.equalToSuperview().offset(24)
                        make.right.equalToSuperview().offset(-24)
                        make.height.equalTo(52)
        }

        let kakaoStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 8
        }
        kakaoButton.addSubview(kakaoStackView)
        kakaoStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        let kakaoImageView = UIImageView().then {
            $0.image = UIImage(named: "kakao")
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .clear
            $0.transform = CGAffineTransform(scaleX: 1, y: 1.02)
        }
        kakaoStackView.addArrangedSubview(kakaoImageView)
        kakaoImageView.snp.makeConstraints { make in
            make.width.equalTo(21)
            make.height.equalTo(19)
        }

        let kakaoLabel = UILabel().then {
            $0.text = "카카오톡으로 3초만에 시작하기"
            $0.font = UIFont.body1Bold
            $0.textColor = .black
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.05
            
            let attributedText = NSMutableAttributedString(string: "카카오톡으로 3초만에 시작하기", attributes: [
                NSAttributedString.Key.kern: -0.4,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
            $0.attributedText = attributedText
        }
        kakaoStackView.addArrangedSubview(kakaoLabel)

        let appleButton = UIButton().then {
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 12
            $0.addTarget(self, action: #selector(appleButtonTapped), for: .touchUpInside)
        }
        view.addSubview(appleButton)
        appleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(634)
                        make.left.equalToSuperview().offset(24)
                        make.right.equalToSuperview().offset(-24)
                        make.height.equalTo(52)
        }

        let appleStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 8
        }
        appleButton.addSubview(appleStackView)
        appleStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        let appleImageView = UIImageView().then {
            $0.image = UIImage(named: "apple")
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .clear
        }
        appleStackView.addArrangedSubview(appleImageView)
        appleImageView.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(19)
        }

        let appleLabel = UILabel().then {
            $0.text = "Apple로 계속하기"
            $0.font = UIFont.body1Bold
            $0.textColor = .white
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.05
            
            let attributedText = NSMutableAttributedString(string: "Apple로 계속하기", attributes: [
                NSAttributedString.Key.kern: -0.4,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
            $0.attributedText = attributedText
        }
        appleStackView.addArrangedSubview(appleLabel)

        }
        
        @objc private func kakaoButtonTapped() {
            kakaoLogin()
        }
        
        @objc private func appleButtonTapped() {
            appleLogin()
        }
        
        // MARK: - Login Actions
        private func kakaoLogin() {
            
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
        
        /*private func handleKakaoLoginSuccess(token: oauthToken?) {
            // 로그인 성공 처리
            // 예시: 토큰을 이용해 필요한 작업 수행
            if let token = token {
                print("Kakao access token: \(token.accessToken)")
                // 추가 작업 수행
            }
        }*/
        
        private func appleLogin() {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
        
    }

    // MARK: - ASAuthorizationControllerDelegate

    extension LoginViewController: ASAuthorizationControllerDelegate {
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                // 애플 로그인 성공
                // handleAppleLoginSuccess(appleIDCredential: appleIDCredential)
            }
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            print("Apple login error: \(error)")
        }
        
    }

    // MARK: - ASAuthorizationControllerPresentationContextProviding

    extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
        
        func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
            return self.view.window!
        }
        
    }
    
    private func createButton(color: UIColor) -> UIButton {
        return UIButton().then {
            $0.backgroundColor = color
            $0.layer.cornerRadius = 12
        }
    }
