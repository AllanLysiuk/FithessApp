//
//  LoginVC.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class LoginVC: UIViewController {
    private weak var imageView: UIImageView!
    private weak var emailLabel: UILabel!
    private weak var passwordLabel: UILabel!
    private weak var emailTextField: UITextField!
    private weak var passwordTextField: UITextField!
    private weak var loginButton: UIButton!
    private weak var registerButton: UIButton!
    private weak var forgotPasswordButton: UIButton!
    private weak var googleButton: UIButton!
    
    private var viewModel: LoginVMProtocol
    
    init(viewModel: LoginVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.setupViewDelegate(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsAndConstraints()
        setUpActions()
        createRightViewSecureButton(textField: passwordTextField)
    }
}

//MARK: LoginVCDelegate
extension LoginVC: LoginVCDelegate {
    func setEmail(_ email: String?) {
        emailTextField.text = email
    }
}

// MARK: Actions
extension LoginVC {
    private func setUpActions() {
        loginButton.addTarget(self,
                              action: #selector(login),
                              for: .touchUpInside)
        
        registerButton.addTarget(self,
                                action: #selector(openRegisterPage),
                                for: .touchUpInside)
                
        forgotPasswordButton.addTarget(self,
                                       action: #selector(openForgotPasswordPage),
                                       for: .touchUpInside)
        googleButton.addTarget(self,
                               action: #selector(loginWithGoogle),
                               for: .touchUpInside)
    }
    
    private func createRightViewSecureButton(textField: UITextField) {
        textField.isSecureTextEntry = true
        let secureButton = UIButton(type: .custom)
        secureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        secureButton.tintColor = .blue
        secureButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        secureButton.addTarget(self,
                                action: #selector (securePasswordButtonDidTap),
                                for: .touchUpInside)
        textField.rightView = secureButton
        textField.rightViewMode = .always
    }
       
    @objc private func securePasswordButtonDidTap(_ sender: UIButton) {
        passwordTextField.togglePasswordVisibility()
        sender.secureButtonToggle(isSecure: passwordTextField.isSecureTextEntry)
    }
    
    @objc private func login() {
        viewModel.login(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @objc private func openRegisterPage() {
        viewModel.openRegisterPage(with: emailTextField.text)
    }
        
    @objc private func openForgotPasswordPage() {
        viewModel.openForgotPasswordPage(with: emailTextField.text)
    }
    
    @objc private func loginWithGoogle() {
        viewModel.loginWithGoogle(viewContext: ViewContext(viewController: self))
    }
}

// MARK: Set up UI
extension LoginVC {
    private func setUpViewsAndConstraints() {
        view.backgroundColor = .white
        
        setUpImageView()
        
        setUpEmailLabel()
        
        setUPEmailTextField()
        
        setUpPasswordLabel()
        
        setUpPasswordTextField()
        
        setUpLoginButton()
        
        setUpForgotPasswordButton()
        
        setUpRegisterButton()
        
        setUpGoogleButton()

    }
    
    private func setUpImageView() {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "login-image")
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
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
        ])
    }
    
    private func setUPEmailTextField() {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.placeholder = "Enter your email"
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
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
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
    
    private func setUpLoginButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.backgroundColor = UIColor(red: 0.2, green: 0.41, blue: 0.95, alpha: 1)
        btn.layer.cornerRadius = 12.0
        btn.titleLabel?.font = .mSemiBold16
        view.addSubview(btn)
        loginButton = btn
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                                        constant: 20.0),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                            constant: -20.0),
            loginButton.heightAnchor.constraint(equalToConstant: 50.0),
                ])
        
        loginButton.layoutIfNeeded()
    }
    
    private func setUpForgotPasswordButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor(red: 0.2, green: 0.41, blue: 0.95, alpha: 1).cgColor
        btn.setTitle("Forgot Password", for: .normal)
        btn.titleLabel?.font = .mSemiBold14
        btn.setTitleColor(UIColor(red: 0.2, green: 0.41, blue: 0.95, alpha: 1), for: .normal)
        view.addSubview(btn)
        forgotPasswordButton = btn
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor,
                                                        constant: 8.0),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                            constant: -20.0),
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: (loginButton.frame.width / 2) - 4),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44.0),
                ])
    }
    
    private func setUpRegisterButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Register", for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor(red: 0.2, green: 0.41, blue: 0.95, alpha: 1).cgColor
        btn.setTitleColor(UIColor(red: 0.2, green: 0.41, blue: 0.95, alpha: 1), for: .normal)
        btn.titleLabel?.font = .mSemiBold14
        view.addSubview(btn)
        registerButton = btn
        
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor,
                                                        constant: 8.0),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: 20.0),
            registerButton.widthAnchor.constraint(equalToConstant: (loginButton.frame.width / 2) - 4),
            registerButton.heightAnchor.constraint(equalToConstant: 44.0),
        ])
    }
    
    private func setUpGoogleButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "google-logo"), for: .normal)
        btn.contentMode = .scaleAspectFit
        view.addSubview(btn)
        googleButton = btn
        
        NSLayoutConstraint.activate([
            googleButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor,
                                                        constant: 20.0),
            googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                            constant: 20.0),
            googleButton.widthAnchor.constraint(equalToConstant: 60.0),
            googleButton.heightAnchor.constraint(equalToConstant: 60.0)
        ])
    }
}

//MARK: - UITextFieldDelegate
extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
