//
//  ForgotPasswordVC.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class ForgotPasswordVC: UIViewController {
    private weak var imageView: UIImageView!
    private weak var emailLabel: UILabel!
    private weak var emailTextField: UITextField!
    private weak var forgotPasswordButton: UIButton!
    
    private var viewModel: ForgotPasswordVMProtocol

    init(viewModel: ForgotPasswordVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsAndConstraints()
        setUpActions()
    }
    
    override func willMove(toParent parent: UIViewController?) {
            super.willMove(toParent: parent)
            if parent == nil {
                viewModel.finish(shouldMoveToParent: false)
            }
    }
}

// MARK: Actions
extension ForgotPasswordVC {
    private func setUpActions() {
        
        forgotPasswordButton.addTarget(self,
                                action: #selector(forgotPasswordDidTap),
                                for: .touchUpInside)
                
    }
    
    @objc private func forgotPasswordDidTap() {
        viewModel.forgotPassword(email: emailTextField.text)
    }
        
}

// MARK: Set up UI
extension ForgotPasswordVC {
    private func setUpViewsAndConstraints() {
        view.backgroundColor = .white
        
        setUpImageView()
        
        setUpEmailLabel()
        
        setUPEmailTextField()
        
        setUpForgotPasswordButton()

    }
    
    private func setUpImageView() {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "forgot-password-image")
        img.contentMode = .scaleAspectFit
        view.addSubview(img)
        imageView = img
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height / 3)
        ])
    }
    
    private func setUpEmailLabel() {
        let label = UILabel()
        label.setupLabel(text: "Email", color: .black, fontName: (.mSemiBold16 ?? .systemFont(ofSize: 16, weight: .semibold)) )
        view.addSubview(label)
        self.emailLabel = label
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0)
        ])
    }
    
    private func setUPEmailTextField() {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.placeholder = "Enter your email"
        textField.text = viewModel.email
        textField.borderStyle = .roundedRect
        textField.font = .mRegular14
        view.addSubview(textField)
        textField.delegate = self
        self.emailTextField = textField
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor,
                                                        constant: 8.0),
                    emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                            constant: 20.0),
                    emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                             constant: -20.0),
                    emailTextField.heightAnchor.constraint(equalToConstant: 44.0),
                ])
    }
    
    private func setUpForgotPasswordButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Reset Password", for: .normal)
        btn.titleLabel?.font = .mSemiBold16
        btn.layer.cornerRadius = 12
        btn.backgroundColor = UIColor(red: 0.2, green: 0.41, blue: 0.95, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        view.addSubview(btn)
        forgotPasswordButton = btn
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,
                                                        constant: 20.0),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                            constant: -20.0),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 50.0),
                ])
        
    }
}

//MARK: - UITextFieldDelegate
extension ForgotPasswordVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField {
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                viewModel.email = updatedText
            }
        }
        return true
    }
}
