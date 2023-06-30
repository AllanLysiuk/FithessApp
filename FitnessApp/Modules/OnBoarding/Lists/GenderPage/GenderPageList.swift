//
//  GenderPageList.swift
//  FitnessApp
//
//  Created by Allan on 29.06.23.
//

import Foundation
import UIKit

final class GenderPageList: UIViewController {

    private weak var titleLabel: UILabel!
    private weak var maleButton: UIButton!
    private weak var womanButton: UIButton!
    private weak var subtitleLabel: UILabel!
    private weak var saveButton: UIButton!
    
    private var viewModel: GenderVMProtocol
    
    init(viewModel: GenderVMProtocol) {
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
extension GenderPageList {
    private func setUpActions() {
        maleButton.addTarget(self,
                                action: #selector(maleButtonDidTap),
                                for: .touchUpInside)
        
        womanButton.addTarget(self,
                                action: #selector(womanButtonDidTap),
                                for: .touchUpInside)
                
        saveButton.addTarget(self,
                                action: #selector(saveButtonDidTap),
                                for: .touchUpInside)
    }
    
    @objc private func maleButtonDidTap() {
        maleButton.isSelected = !maleButton.isSelected
        womanButton.unselectButton()
        maleButton.backgroundColor = maleButton.isSelected ? .red : .white
    }
    
    @objc private func womanButtonDidTap() {
        womanButton.isSelected = !womanButton.isSelected
        maleButton.unselectButton()
        womanButton.backgroundColor = womanButton.isSelected ? .red : .white
        
    }
        
    @objc private func saveButtonDidTap() {
        if maleButton.isSelected || womanButton.isSelected {
            let gender = maleButton.isSelected ? "Male" : "Woman"
            viewModel.saveTapped(gender: gender)
        } else {
            saveButton.shake()
        }
    }

}

// MARK: Set up UI
extension GenderPageList {
    private func setUpViewsAndConstraints() {
        view.backgroundColor = UIColor(red: 244.0 / 255.0, green: 246.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
        
        setUpTitleLabel()
        
        setUpMaleButton()
        
        setUpWomanButton()
        
        setUpSaveButton()
    }
    
    private func setUpTitleLabel() {
        let label = UILabel()
        label.setupLabel(text: "Which one are you?", color: .black, fontName: (.mSemiBold20 ?? .systemFont(ofSize: 20, weight: .semibold)) )
        view.addSubview(label)
        self.titleLabel = label
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200.0),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    
    private func setUpMaleButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.createTitleInTwoLines(btnTitle: "\u{1F64B}\nMale", firstLineFont: .systemFont(ofSize: 50), secondLineFont: .mSemiBold18!)
        btn.backgroundColor = .white
        btn.titleLabel?.textColor = .black
        btn.layer.cornerRadius = 12.0
        view.addSubview(btn)
        maleButton = btn
        
        NSLayoutConstraint.activate([
            maleButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                        constant: 20.0),
            maleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0),
            maleButton.heightAnchor.constraint(equalToConstant: 200.0),
            maleButton.widthAnchor.constraint(equalToConstant: (view.frame.width / 2) - 54.0)
                ])
        
        maleButton.layoutIfNeeded()
    }
    
    private func setUpWomanButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.createTitleInTwoLines(btnTitle: "🙋‍♀️\nWoman", firstLineFont: .systemFont(ofSize: 50), secondLineFont: .mSemiBold18!)
        btn.backgroundColor = .white
        btn.titleLabel?.textColor = .black
        btn.layer.cornerRadius = 12.0
        view.addSubview(btn)
        womanButton = btn
        
        NSLayoutConstraint.activate([
            womanButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                        constant: 20.0),
            womanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50.0),
            womanButton.heightAnchor.constraint(equalToConstant: 200.0),
            womanButton.widthAnchor.constraint(equalToConstant: (view.frame.width / 2) - 54.0)
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


