//
//  NamePageList.swift
//  FitnessApp
//
//  Created by Allan on 3.07.23.
//

import Foundation
import UIKit

final class NamePageList: UIViewController {

    private weak var titleLabel: UILabel!
    private weak var nameTextField: UITextField!
    private weak var saveButton: UIButton!
    
    private var viewModel: NamePageVMProtocol
    
    init(viewModel: NamePageVMProtocol) {
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
    
}

// MARK: Actions
extension NamePageList {
    private func setUpActions() {
                
        saveButton.addTarget(self,
                                action: #selector(saveButtonDidTap),
                                for: .touchUpInside)
    }
        
    @objc private func saveButtonDidTap() {
        if let text = nameTextField.text, !text.isEmpty {
            viewModel.saveTapped(name: text)
        } else {
            saveButton.shake()
        }
    }

}

// MARK: Set up UI
extension NamePageList {
    private func setUpViewsAndConstraints() {
        view.backgroundColor = UIColor(red: 244.0 / 255.0, green: 246.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
        
        setUpTitleLabel()
        
        setUpNameTextField()
        
        setUpSaveButton()
    }
    
    private func setUpTitleLabel() {
        let label = UILabel()
        label.setupLabel(text: "Enter your Name", color: .black, fontName: (.mSemiBold20 ?? .systemFont(ofSize: 20, weight: .semibold)) )
        view.addSubview(label)
        self.titleLabel = label
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200.0),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    
    private func setUpNameTextField() {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.font = .mRegular14
        view.addSubview(textField)
        textField.delegate = self
        nameTextField = textField
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                        constant: 8.0),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                            constant: 20.0),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                             constant: -20.0),
            nameTextField.heightAnchor.constraint(equalToConstant: 44.0),
                ])
    }
    
    private func setUpSaveButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Save", for: .normal)
        btn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.backgroundColor = UIColor(red: 0.2, green: 0.41, blue: 0.95, alpha: 1)
        btn.layer.cornerRadius = 20.0
        btn.titleLabel?.font = .mSemiBold16
        view.addSubview(btn)
        saveButton = btn
        
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                        constant: -10.0),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                            constant: -20.0),
            saveButton.heightAnchor.constraint(equalToConstant: 60.0),
                ])
    }
}

//MARK: - UITextFieldDelegate
extension NamePageList: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
