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
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "background")
        return imageView
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.7
        return view
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo-removebg-preview"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.text = "Millions of songs.\nFree on Spotify."
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Spotify"
        view.addSubview(imageView)
        view.addSubview(overlayView)
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
      
        view.addSubview(logoImageView)
        view.addSubview(label)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = view.bounds
        overlayView.frame = view.bounds
        signInButton.frame = CGRect(
            x: 20,
            y: view.height-50-view.safeAreaInsets.bottom,
            width: view.width-40,
            height: 50
        )
        
        logoImageView.frame = CGRect(x: (view.width-120)/2, y: (view.height-350)/2, width: 120, height: 120)
        label.frame = CGRect(x: 30, y: logoImageView.bottom+20, width: view.width-60, height: 150)
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
        guard success else {
            let alert = UIAlertController(title: "Oops", message: "Somthing went wrong when signing in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismis", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        let mainAppTabBarVC = TabBarViewController()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVC, animated: true)
    }
}
