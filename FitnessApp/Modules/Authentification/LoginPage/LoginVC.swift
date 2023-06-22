//
//  LoginVC.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class LoginVC: UIViewController {
    private weak var registerButton: UIButton!
    private weak var forgotPasswordButton: UIButton!
    
    private var viewModel: LoginVMProtocol
    
    init(viewModel: LoginVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setUpViewsAndConstraints()
        setUpActions()
    }
}

extension LoginVC {
    private func setUpActions() {
        registerButton.addTarget(self,
                                action: #selector(openRegisterPage),
                                for: .touchUpInside)
                
        forgotPasswordButton.addTarget(self,
                                        action: #selector(openForgotPasswordPage),
                                        for: .touchUpInside)
    }
    
    @objc private func openRegisterPage() {
            viewModel.openRegisterPage()
        }
        
        @objc private func openForgotPasswordPage() {
            viewModel.openForgotPasswordPage()
        }
}

extension LoginVC {
    private func setUpViewsAndConstraints() {
        setUpRegisterButton()
        setUpForgotPasswordButton()
    }
    
    private func setUpForgotPasswordButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Forgot Password", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        view.addSubview(btn)
        forgotPasswordButton = btn
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: view.topAnchor,
                                                        constant: 100.0),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                            constant: -20.0),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44.0),
                ])
    }
    
    private func setUpRegisterButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Register", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        view.addSubview(btn)
        registerButton = btn
        NSLayoutConstraint.activate([
                    registerButton.topAnchor.constraint(equalTo: view.topAnchor,
                                                        constant: 100.0),
                    registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                            constant: 20.0),
                    registerButton.heightAnchor.constraint(equalToConstant: 44.0),
                ])
    }
}
