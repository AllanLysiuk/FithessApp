//
//  ImageProfileList.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation
import UIKit

final class ImageProfileList: UIViewController {
    
    private weak var titleLabel: UILabel!
    private weak var profileImage: UIImageView!
    private weak var saveButton: UIButton!
    
    private var viewModel: ImageProfileVMProtocol
    
    init(viewModel: ImageProfileVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setUpDelegate(self)
        setUpViewsAndConstraints()
        setUpActions()
    }
    
}

// MARK: Actions
extension ImageProfileList {
    private func setUpActions() {
        saveButton.addTarget(self,
                                action: #selector(saveButtonDidTap),
                                for: .touchUpInside)
    }
    
    @objc private func didTapOnView(_ gesture: UITapGestureRecognizer) {
        viewModel.showImagePicker()
    }
        
    @objc private func saveButtonDidTap() {
        viewModel.saveTapped()
    }

}

// MARK: Set up UI
extension ImageProfileList {
    private func setUpViewsAndConstraints() {
        view.backgroundColor = UIColor(red: 244.0 / 255.0, green: 246.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
        
        setUpTitleLabel()
        
        setUpImageView()
        
        setUpSaveButton()
    }
    
    private func setUpTitleLabel() {
        let label = UILabel()
        label.setupLabel(text: "Choose your profile image", color: .black, fontName: (.mSemiBold20 ?? .systemFont(ofSize: 20, weight: .semibold)) )
        view.addSubview(label)
        self.titleLabel = label
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200.0),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setUpImageView() {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "default-profile-image")
        imageView.layer.cornerRadius = 100
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapOnView(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tapGesture)
        
        view.addSubview(imageView)
        profileImage = imageView
        

        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 200.0),
            profileImage.widthAnchor.constraint(equalToConstant: 200.0)
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

extension ImageProfileList: ImageProfileVCDelegate {
    func imagePicked(_ img: UIImage) {
        self.profileImage.image = img
    }
}
