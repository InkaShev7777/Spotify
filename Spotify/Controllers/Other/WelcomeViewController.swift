//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Ilya Schevchenko on 21.12.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let signInButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
     
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 20, 
                                    y: view.height - 50-view.safeAreaInsets.bottom,
                                    width: view.width-40,
                                    height: 50)
    }
    @objc func didTapSignIn(){
        let vcAuth = AuthViewController()
        vcAuth.completionHandler = {[weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vcAuth.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vcAuth, animated: true)
    }
    
    private func handleSignIn(success:Bool){
        // Log user In  error
    }
}
