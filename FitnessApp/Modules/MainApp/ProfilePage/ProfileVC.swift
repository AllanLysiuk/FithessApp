//
//  ProfileVC.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import UIKit

final class ProfileVC: UIViewController {
    private weak var mainInfoBackgroundView: UIView!
    private weak var emailBackgroundView: UIView!
    private weak var ageBackgroundView: UIView!
    private weak var genderBackgroundView: UIView!
    private weak var weightBackgroundView: UIView!
    private weak var growthBackgroundView: UIView!
    
    private weak var profileImageView: UIImageView!
    
    private weak var emailTitleLabel: UILabel!
    private weak var genderTitleLabel: UILabel!
    private weak var ageTitleLabel: UILabel!
    private weak var weightTitleLabel: UILabel!
    private weak var growthTitleLabel: UILabel!
    
    private weak var nameTextView: UITextView!
    private weak var genderTextField: UITextField!
    private weak var emailTextField: UITextField!
    private weak var ageTextField: UITextField!
    private weak var weightTextField: UITextField!
    private weak var growthTextField: UITextField!
    
    private weak var editButton: UIButton!
    private weak var logOutButton: UIButton!
    
    private var viewModel: ProfileVMProtocol
    
    init(viewModel: ProfileVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        requiredInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func requiredInit() {
        tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 3)
        navigationController?.tabBarItem = tabBarItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setUpDelegate(self)
        setUpViewsAndConstraints()
        setUpActions()
        updateUIWithNewProfile(viewModel.loadProfile())
    }
}

// MARK: Actions
extension ProfileVC {
    private func setUpActions() {
        editButton.addTarget(self,
                             action: #selector(editButtonDidTap),
                             for: .touchUpInside)
        logOutButton.addTarget(self,
                               action: #selector(logOutButtonDidTap),
                               for: .touchUpInside)
    }
    
    @objc private func didTapOnView(_ gesture: UITapGestureRecognizer) {
        viewModel.showImagePicker()
    }
    
    @objc private func logOutButtonDidTap() {
        viewModel.logOut()
    }
    
    @objc private func editButtonDidTap() {
        editButton.isSelected = !editButton.isSelected
        if editButton.isSelected {
            startWobbling()
            editButton.backgroundColor = .white
            makeProfileInfoInteractive(true)
        } else {
            stopWobbling()
            editButton.backgroundColor =  UIColor(red: 114.0 / 255.0, green:  101.0 / 255.0, blue:  227.0 / 255.0, alpha: 1)
            makeProfileInfoInteractive(false)
            viewModel.updateInfoOfProfile(
                email: emailTextField.text ?? "",
                name: nameTextView.text,
                age: Int(String(ageTextField.text ?? "0"))!,
                weight: Double(String(weightTextField.text ?? "0"))!,
                growth: Double(String(growthTextField.text ?? "0"))!,
                gender: genderTextField.text ?? "",
                profileImage: profileImageView.image
            )
        }
    }
    
    @objc private func doneButtonKeyboardDidTap() {
        ageTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
        growthTextField.resignFirstResponder()
    }
    
    
}

// MARK: Set up UI
extension ProfileVC {
    
    private func makeProfileInfoInteractive(_ boolean: Bool) {
        profileImageView.isUserInteractionEnabled = boolean
        nameTextView.isUserInteractionEnabled = boolean
        ageTextField.isUserInteractionEnabled = boolean
        weightTextField.isUserInteractionEnabled = boolean
        growthTextField.isUserInteractionEnabled = boolean
        genderTextField.isUserInteractionEnabled = boolean
    }
    
    private func startWobbling() {
        mainInfoBackgroundView.startWobble()
        ageBackgroundView.startWobble()
        genderBackgroundView.startWobble()
        weightBackgroundView.startWobble()
        growthBackgroundView.startWobble()
        
    }
    
    private func stopWobbling() {
        mainInfoBackgroundView.stopWobble()
        ageBackgroundView.stopWobble()
        genderBackgroundView.stopWobble()
        weightBackgroundView.stopWobble()
        growthBackgroundView.stopWobble()
    }
    
    private func updateUIWithNewProfile(_ profile: Profile) {
        profileImageView.image = viewModel.loadPhotoBy(profile.imagePath ?? "")
        nameTextView.text = profile.name
        genderTextField.text = profile.gender
        emailTextField.text = profile.email
        ageTextField.text = "\(profile.age)"
        weightTextField.text = "\(profile.weight)"
        growthTextField.text = "\(profile.growth)"
    }
    
    private func setUpViewsAndConstraints() {
        view.backgroundColor = .white
        
        setUpMainInfoBackgroundView()
        
        setUpEmailBackgroundView()
        
        setUpAgeBackgroundView()
        
        setUpGenderBackgroundView()
        
        setUpWeightBackgroundView()
        
        setUpGrowthBackgroundView()
       
        setUpImageView()
        
        setUpNameTextView()
        
        setUpEmailTitleLabel()
        
        setUpEmailTextField()
        
        setUpGenderTitleLabel()
        
        setUpGenderTextField()
        
        setUpAgeTitleLabel()
        
        setUpAgeTextField()
        
        setUpGrowthTitleLabel()
        
        setUpGrowthTextField()
        
        setUpWeightTitleLabel()
        
        setUpWeightTextField()
        
        setUPDoneButtonKeyboard()
        
        setUpEditButton()
        
        setUpLogOutButton()
    }
    
    private func setUPDoneButtonKeyboard() {
        let keypadToolbar: UIToolbar = UIToolbar()
        keypadToolbar.items = [
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: UITextField(), action: #selector(doneButtonKeyboardDidTap)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        ]
        keypadToolbar.sizeToFit()
        ageTextField.inputAccessoryView = keypadToolbar
        growthTextField.inputAccessoryView = keypadToolbar
        weightTextField.inputAccessoryView = keypadToolbar
    }
    
    private func setUpMainInfoBackgroundView() {
        let bckView = UIView()
        bckView.translatesAutoresizingMaskIntoConstraints = false
        bckView.backgroundColor = UIColor(red: 216.0 / 255.0, green: 209.0 / 255.0, blue: 244.0 / 255.0, alpha: 1)
        bckView.layer.cornerRadius = 20
        view.addSubview(bckView)
        mainInfoBackgroundView = bckView
        
        NSLayoutConstraint.activate([
            mainInfoBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            mainInfoBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            mainInfoBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            mainInfoBackgroundView.heightAnchor.constraint(equalToConstant: 180.0)
        ])
    }
    
    private func setUpEmailBackgroundView() {
        let bckView = UIView()
        bckView.translatesAutoresizingMaskIntoConstraints = false
        bckView.backgroundColor = UIColor(red: 216.0 / 255.0, green: 209.0 / 255.0, blue: 244.0 / 255.0, alpha: 1)
        bckView.layer.cornerRadius = 20
        view.addSubview(bckView)
        emailBackgroundView = bckView
        
        NSLayoutConstraint.activate([
            emailBackgroundView.topAnchor.constraint(equalTo: mainInfoBackgroundView.bottomAnchor, constant: 8.0),
            emailBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            emailBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            emailBackgroundView.heightAnchor.constraint(equalToConstant: 80.0)
        ])
        emailBackgroundView.layoutIfNeeded()
    }
    
    private func setUpAgeBackgroundView() {
        let bckView = UIView()
        bckView.translatesAutoresizingMaskIntoConstraints = false
        bckView.backgroundColor = UIColor(red: 216.0 / 255.0, green: 209.0 / 255.0, blue: 244.0 / 255.0, alpha: 1)
        bckView.layer.cornerRadius = 20
        view.addSubview(bckView)
        ageBackgroundView = bckView
        
        NSLayoutConstraint.activate([
            ageBackgroundView.topAnchor.constraint(equalTo: emailBackgroundView.bottomAnchor, constant: 8.0),
            ageBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            ageBackgroundView.widthAnchor.constraint(equalToConstant: (emailBackgroundView.frame.width / 2) - 5),
            ageBackgroundView.heightAnchor.constraint(equalToConstant: 80.0)
        ])
    }
    
    private func setUpGenderBackgroundView() {
        let bckView = UIView()
        bckView.translatesAutoresizingMaskIntoConstraints = false
        bckView.backgroundColor = UIColor(red: 216.0 / 255.0, green: 209.0 / 255.0, blue: 244.0 / 255.0, alpha: 1)
        bckView.layer.cornerRadius = 20
        view.addSubview(bckView)
        genderBackgroundView = bckView
        
        NSLayoutConstraint.activate([
            genderBackgroundView.topAnchor.constraint(equalTo: emailBackgroundView.bottomAnchor, constant: 8.0),
            genderBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            genderBackgroundView.widthAnchor.constraint(equalToConstant: (emailBackgroundView.frame.width / 2) - 5),
            genderBackgroundView.heightAnchor.constraint(equalToConstant: 80.0)
        ])
    }
    
    private func setUpWeightBackgroundView() {
        let bckView = UIView()
        bckView.translatesAutoresizingMaskIntoConstraints = false
        bckView.backgroundColor = UIColor(red: 216.0 / 255.0, green: 209.0 / 255.0, blue: 244.0 / 255.0, alpha: 1)
        bckView.layer.cornerRadius = 20
        view.addSubview(bckView)
        weightBackgroundView = bckView
        
        NSLayoutConstraint.activate([
            weightBackgroundView.topAnchor.constraint(equalTo: ageBackgroundView.bottomAnchor, constant: 8.0),
            weightBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            weightBackgroundView.widthAnchor.constraint(equalToConstant: (emailBackgroundView.frame.width / 2) - 5),
            weightBackgroundView.heightAnchor.constraint(equalToConstant: 80.0)
        ])
    }
    
    private func setUpGrowthBackgroundView() {
        let bckView = UIView()
        bckView.translatesAutoresizingMaskIntoConstraints = false
        bckView.backgroundColor = UIColor(red: 216.0 / 255.0, green: 209.0 / 255.0, blue: 244.0 / 255.0, alpha: 1)
        bckView.layer.cornerRadius = 20
        view.addSubview(bckView)
        growthBackgroundView = bckView
        
        NSLayoutConstraint.activate([
            growthBackgroundView.topAnchor.constraint(equalTo: genderBackgroundView.bottomAnchor, constant: 8.0),
            growthBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            growthBackgroundView.widthAnchor.constraint(equalToConstant: (emailBackgroundView.frame.width / 2) - 5),
            growthBackgroundView.heightAnchor.constraint(equalToConstant: 80.0)
        ])
    }
    
    private func setUpImageView() {
        let img = UIImageView()
        img.isUserInteractionEnabled = false
        img.layer.masksToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapOnView(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        img.addGestureRecognizer(tapGesture)
        img.layer.cornerRadius = 75
        img.image = UIImage(named: "default-profile-image")
        img.contentMode = .scaleAspectFill
        view.addSubview(img)
        profileImageView = img

        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: mainInfoBackgroundView.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: mainInfoBackgroundView.leadingAnchor, constant: 16.0),
            profileImageView.widthAnchor.constraint(equalToConstant: 150.0),
            profileImageView.heightAnchor.constraint(equalToConstant: 150.0)
        ])

    }
    
    private func setUpNameTextView() {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = false
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.text = "Name"
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        view.addSubview(textView)
        //textField.delegate = self
        nameTextView = textView

        NSLayoutConstraint.activate([
            nameTextView.topAnchor.constraint(equalTo: mainInfoBackgroundView.topAnchor,
                                                        constant: 32.0),
            nameTextView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor,
                                                            constant: 16.0),
            nameTextView.trailingAnchor.constraint(equalTo: mainInfoBackgroundView.trailingAnchor,
                                                                constant: -20.0),
            nameTextView.bottomAnchor.constraint(equalTo: mainInfoBackgroundView.bottomAnchor,
                                                        constant: 32.0),
        ])
    }
    
    private func setUpEmailTitleLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Email", color: .white, fontName: (.mRegular14 ?? .systemFont(ofSize: 14, weight: .regular)) )
        view.addSubview(label)
        self.emailTitleLabel = label
        
        NSLayoutConstraint.activate([
            emailTitleLabel.topAnchor.constraint(equalTo: emailBackgroundView.topAnchor, constant: 10.0),
            emailTitleLabel.centerXAnchor.constraint(equalTo: emailBackgroundView.centerXAnchor),
        ])
    }
    
    private func setUpEmailTextField() {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.textAlignment = .center
        textField.text = "Email"
        textField.isUserInteractionEnabled = false
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        textField.delegate = self
        view.addSubview(textField)
        emailTextField = textField
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailTitleLabel.bottomAnchor, constant: 0),
            emailTextField.leadingAnchor.constraint(equalTo:emailBackgroundView.leadingAnchor, constant: 8.0),
            emailTextField.trailingAnchor.constraint(equalTo: emailBackgroundView.trailingAnchor, constant: -8.0),
            emailTextField.bottomAnchor.constraint(equalTo: emailBackgroundView.bottomAnchor)
        ])
    }
    
    private func setUpGenderTitleLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Gender", color: .white, fontName: (.mRegular14 ?? .systemFont(ofSize: 14, weight: .regular)) )
        view.addSubview(label)
        self.genderTitleLabel = label
        
        NSLayoutConstraint.activate([
            genderTitleLabel.topAnchor.constraint(equalTo: genderBackgroundView.topAnchor, constant: 10.0),
            genderTitleLabel.centerXAnchor.constraint(equalTo: genderBackgroundView.centerXAnchor),
        ])
    }
    
    private func setUpGenderTextField() {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.textAlignment = .center
        textField.text = "Gender"
        textField.isUserInteractionEnabled = false
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        textField.delegate = self
        view.addSubview(textField)
        genderTextField = textField
        
        NSLayoutConstraint.activate([
            genderTextField.topAnchor.constraint(equalTo: genderTitleLabel.bottomAnchor, constant: 0),
            genderTextField.leadingAnchor.constraint(equalTo:genderBackgroundView.leadingAnchor, constant: 8.0),
            genderTextField.trailingAnchor.constraint(equalTo: genderBackgroundView.trailingAnchor, constant: -8.0),
            genderTextField.bottomAnchor.constraint(equalTo: genderBackgroundView.bottomAnchor)
        ])
    }
    
    private func setUpAgeTitleLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Age", color: .white, fontName: (.mRegular14 ?? .systemFont(ofSize: 14, weight: .regular)) )
        view.addSubview(label)
        self.ageTitleLabel = label
        
        NSLayoutConstraint.activate([
            ageTitleLabel.topAnchor.constraint(equalTo: ageBackgroundView.topAnchor, constant: 10.0),
            ageTitleLabel.centerXAnchor.constraint(equalTo: ageBackgroundView.centerXAnchor),
        ])
    }
    
    private func setUpAgeTextField() {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.text = "20"
        textField.isUserInteractionEnabled = true
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        textField.delegate = self
        view.addSubview(textField)
        ageTextField = textField
        
        NSLayoutConstraint.activate([
            ageTextField.topAnchor.constraint(equalTo: ageTitleLabel.bottomAnchor, constant: 0.0),
            ageTextField.leadingAnchor.constraint(equalTo: ageBackgroundView.leadingAnchor, constant: 8.0),
            ageTextField.trailingAnchor.constraint(equalTo: ageBackgroundView.trailingAnchor, constant: -8.0),
            ageTextField.bottomAnchor.constraint(equalTo: ageBackgroundView.bottomAnchor)
        ])
    }
    
    private func setUpWeightTitleLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Weight", color: .white, fontName: (.mRegular14 ?? .systemFont(ofSize: 14, weight: .regular)) )
        view.addSubview(label)
        self.weightTitleLabel = label
        
        NSLayoutConstraint.activate([
            weightTitleLabel.topAnchor.constraint(equalTo: weightBackgroundView.topAnchor, constant: 10.0),
            weightTitleLabel.centerXAnchor.constraint(equalTo: weightBackgroundView.centerXAnchor),
        ])
    }
    
    private func setUpWeightTextField() {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.text = "80"
        textField.isUserInteractionEnabled = false
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        textField.delegate = self
        view.addSubview(textField)
        weightTextField = textField
        
        NSLayoutConstraint.activate([
            weightTextField.topAnchor.constraint(equalTo: weightTitleLabel.bottomAnchor, constant: 0.0),
            weightTextField.leadingAnchor.constraint(equalTo: weightBackgroundView.leadingAnchor, constant: 8.0),
            weightTextField.trailingAnchor.constraint(equalTo: weightBackgroundView.trailingAnchor, constant: -8.0),
            weightTextField.bottomAnchor.constraint(equalTo: weightBackgroundView.bottomAnchor)
        ])
    }
    
    private func setUpGrowthTitleLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Growth", color: .white, fontName: (.mRegular14 ?? .systemFont(ofSize: 14, weight: .regular)) )
        view.addSubview(label)
        self.growthTitleLabel = label
        
        NSLayoutConstraint.activate([
            growthTitleLabel.topAnchor.constraint(equalTo: growthBackgroundView.topAnchor, constant: 10.0),
            growthTitleLabel.centerXAnchor.constraint(equalTo: growthBackgroundView.centerXAnchor),
        ])
    }
    
    private func setUpGrowthTextField() {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.text = "193"
        textField.isUserInteractionEnabled = false
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.font = UIFont(name: "Montserrat-SemiBold", size: 22)
        textField.delegate = self
        view.addSubview(textField)
        growthTextField = textField
        
        NSLayoutConstraint.activate([
            growthTextField.topAnchor.constraint(equalTo: growthTitleLabel.bottomAnchor),
            growthTextField.leadingAnchor.constraint(equalTo: growthBackgroundView.leadingAnchor, constant: 8.0),
            growthTextField.trailingAnchor.constraint(equalTo: growthBackgroundView.trailingAnchor, constant: -8.0),
            growthTextField.bottomAnchor.constraint(equalTo: growthBackgroundView.bottomAnchor)
        ])
    }
    
    private func setUpEditButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setTitle("Edit", for: .normal)
        btn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.backgroundColor = UIColor(red: 114.0 / 255.0, green:  101.0 / 255.0, blue:  227.0 / 255.0, alpha: 1)
        
        btn.setTitle("Save", for: .selected)
        btn.setTitleColor( UIColor(red: 114.0 / 255.0, green:  101.0 / 255.0, blue:  227.0 / 255.0, alpha: 1), for: .selected)

        btn.layer.borderWidth = 1
        btn.layer.borderColor =  UIColor(red: 114.0 / 255.0, green:  101.0 / 255.0, blue:  227.0 / 255.0, alpha: 1).cgColor
        btn.layer.cornerRadius = 12.0
        btn.titleLabel?.font = .mSemiBold18
        view.addSubview(btn)
        editButton = btn
        
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: growthTextField.bottomAnchor,
                                                        constant: 8.0),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                            constant: -20.0),
            editButton.heightAnchor.constraint(equalToConstant: 80.0),
        ])
    }
    
    private func setUpLogOutButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setTitle("Log Out", for: .normal)
        btn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.backgroundColor = UIColor(red: 114.0 / 255.0, green:  101.0 / 255.0, blue:  227.0 / 255.0, alpha: 1)

        btn.layer.cornerRadius = 12.0
        btn.titleLabel?.font = .mSemiBold18
        view.addSubview(btn)
        logOutButton = btn
        
        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: editButton.bottomAnchor,
                                                        constant: 8.0),
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                            constant: -20.0),
            logOutButton.heightAnchor.constraint(equalToConstant: 80.0),
        ])
    }

}

//MARK: - UITextFieldDelegate
extension ProfileVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

extension ProfileVC: ProfileVCDelegate {
    func imagePicked(_ img: UIImage) {
        self.profileImageView.image = img
    }
}
