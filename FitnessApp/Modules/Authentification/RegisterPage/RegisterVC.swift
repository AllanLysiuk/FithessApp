//
//  RegisterVC.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class RegisterVC: UIViewController {
    private weak var emailLabel: UILabel!
    private weak var emailTextField: UITextField!
    private weak var passwordLabel: UILabel!
    private weak var passwordTextField: UITextField!
    private weak var repeatPasswordLabel: UILabel!
    private weak var repeatPasswordTextField: UITextField!
    private weak var registerButton: UIButton!
    
    private var viewModel: RegisterVMProtocol
    
    init(viewModel: RegisterVMProtocol) {
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
        createRightViewSecureButton(textField: passwordTextField, tag: 0)
        createRightViewSecureButton(textField: repeatPasswordTextField, tag: 1)
    }
    
    override func willMove(toParent parent: UIViewController?) {
            super.willMove(toParent: parent)
            if parent == nil {
                viewModel.finish(shouldMoveToParent: false)
            }
    }
}

// MARK: Actions
extension RegisterVC {
    private func setUpActions() {
        
        registerButton.addTarget(self,
                                action: #selector(registerDidTap),
                                for: .touchUpInside)
                
    }
    
    private func createRightViewSecureButton(textField: UITextField, tag: Int) {
        textField.isSecureTextEntry = true
        let secureButton = UIButton(type: .custom)
        secureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        secureButton.tintColor = .blue
        secureButton.tag = tag
        secureButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        secureButton.addTarget(self,
                                action: #selector (securePasswordButtonDidTap),
                                for: .touchUpInside)
        textField.rightView = secureButton
        textField.rightViewMode = .always
    }
       
    @objc private func securePasswordButtonDidTap(_ sender: UIButton) {
        if sender.tag == 0 {
            passwordTextField.togglePasswordVisibility()
            sender.secureButtonToggle(isSecure: passwordTextField.isSecureTextEntry)
        } else {
            repeatPasswordTextField.togglePasswordVisibility()
            sender.secureButtonToggle(isSecure: repeatPasswordTextField.isSecureTextEntry)
        }
    }
    
    @objc private func registerDidTap() {
        viewModel.register(email: emailTextField.text, password: passwordTextField.text, checkPassword: repeatPasswordTextField.text)
    }
        
}

// MARK: Set up UI
extension RegisterVC {
    private func setUpViewsAndConstraints() {
        view.backgroundColor = .white
        
        setUpEmailLabel()
        
        setUPEmailTextField()
        
        setUpPasswordLabel()
        
        setUpPasswordTextField()
        
        setUpRepeatPasswordLabel()
        
        setUpRepeatPasswordTextField()
        
        
        setUpRegisterButton()

    }
    
    private func setUpEmailLabel() {
        let label = UILabel()
        label.setupLabel(text: "Email", color: .black, fontName: (.mSemiBold16 ?? .systemFont(ofSize: 16, weight: .semibold)) )
        view.addSubview(label)
        self.emailLabel = label
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
    
    private func setUpPasswordLabel() {
        let label = UILabel()
        label.setupLabel(text: "Password", color: .black, fontName: (.mSemiBold16 ?? .systemFont(ofSize: 16, weight: .semibold)) )
        view.addSubview(label)
        self.passwordLabel = label
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20.0),
            passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setUpPasswordTextField() {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.borderStyle = .roundedRect
        textField.font = .mRegular14
        view.addSubview(textField)
        textField.delegate = self
        self.passwordTextField = textField
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor,
                                                        constant: 8.0),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                            constant: 20.0),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                             constant: -20.0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44.0),
                ])
    }
    
    private func setUpRepeatPasswordLabel() {
        let label = UILabel()
        label.setupLabel(text: "Repeat Password", color: .black, fontName: (.mSemiBold16 ?? .systemFont(ofSize: 16, weight: .semibold)) )
        view.addSubview(label)
        self.repeatPasswordLabel = label
        
        NSLayoutConstraint.activate([
            repeatPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20.0),
            repeatPasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setUpRepeatPasswordTextField() {
        let textField = UITextField()
        textField.placeholder = "Repeat your password"
        textField.borderStyle = .roundedRect
        textField.font = .mRegular14
        view.addSubview(textField)
        textField.delegate = self
        self.repeatPasswordTextField = textField
        repeatPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repeatPasswordTextField.topAnchor.constraint(equalTo: repeatPasswordLabel.bottomAnchor,
                                                        constant: 8.0),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                            constant: 20.0),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                             constant: -20.0),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 44.0),
                ])
    }
    
    private func setUpRegisterButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Register", for: .normal)
        btn.titleLabel?.font = .mSemiBold16
        btn.layer.cornerRadius = 12
        btn.backgroundColor = UIColor(red: 0.2, green: 0.41, blue: 0.95, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        view.addSubview(btn)
        registerButton = btn
        
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor,
                                                        constant: 20.0),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                            constant: -20.0),
            registerButton.heightAnchor.constraint(equalToConstant: 50.0),
                ])
        
    }
}

//MARK: - UITextFieldDelegate
extension RegisterVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            viewModel.email = updatedText
        }
        return true
    }
}
