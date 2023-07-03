//
//  AgePageList.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation
import UIKit

final class PickerPageList: UIViewController {

    private weak var titleLabel: UILabel!
    private weak var picker: UIPickerView!
    private weak var subtitleLabel: UILabel!
    private weak var saveButton: UIButton!
    
    private var viewModel: PickerVMProtocol
    
    private var titleLabelText: String
    
    init(viewModel: PickerVMProtocol, titleLabelText: String) {
        self.viewModel = viewModel
        self.titleLabelText = titleLabelText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsAndConstraints()
        setUpActions()
        viewModel.setUpPickerView(picker)
        viewModel.setUpRangeOfItems()
    }
    
}

// MARK: Actions
extension PickerPageList {
    private func setUpActions() {
                
        saveButton.addTarget(self,
                                action: #selector(saveButtonDidTap),
                                for: .touchUpInside)
    }
    
    
        
    @objc private func saveButtonDidTap() {
        if true {
            viewModel.saveTapped()
        } else {
            saveButton.shake()
        }
    }

}

// MARK: Set up UI
extension PickerPageList {
    private func setUpViewsAndConstraints() {
        view.backgroundColor = UIColor(red: 244.0 / 255.0, green: 246.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
        
        setUpTitleLabel()
        
        setUPPickerView()
        
        setUpSaveButton()
    }
    
    private func setUpTitleLabel() {
        let label = UILabel()
        label.setupLabel(text: titleLabelText, color: .black, fontName: (.mSemiBold20 ?? .systemFont(ofSize: 20, weight: .semibold)) )
        view.addSubview(label)
        self.titleLabel = label
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200.0),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setUPPickerView() {
        let newPicker = UIPickerView()
        newPicker.backgroundColor = .white
        newPicker.layer.cornerRadius = 10
        newPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newPicker)
        self.picker = newPicker
        
        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0),
            picker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picker.widthAnchor.constraint(equalToConstant: 300.0),
            picker.heightAnchor.constraint(equalToConstant: 200.0),
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
