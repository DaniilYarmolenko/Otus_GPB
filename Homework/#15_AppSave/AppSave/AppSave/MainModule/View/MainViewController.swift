//
//  MainViewController.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//  
//

import UIKit
import UIView_Shimmer

enum TypeData {
    case CoreData
    case Cache
    case none
    case all
}

extension UIImageView: ShimmeringViewProtocol {}
final class MainViewController: UIViewController {
    private let output: MainViewOutput
    
    internal var imageView = UIImageView()
    
    internal var textField = CustomTextField()
    internal let line = UIView()
    internal let labelError = UILabel()
    
    internal var coreDataButton = UIButton()
    internal var cacheButton = UIButton()
    internal var nextButton = UIButton()
    
    private var imageIsLoaded: Bool = false
    private var errorFounded: Bool = false
    internal var verification: VerificationProtocol?
    internal var myHeightAnchor: NSLayoutConstraint
    init(output: MainViewOutput) {
        self.output = output
        myHeightAnchor = labelError.heightAnchor.constraint(equalToConstant: 0)
        myHeightAnchor.isActive = true
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        output.getData()
        setUpNotification()
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
        view.setTemplateWithSubviews(!imageIsLoaded, viewBackgroundColor: .lightGray)
    }
    func setUp(){
        setUpImage()
        setUpTextfield()
        setUpErrorLabel()
        setUpLine()
        setUpCoreDataButton()
        setUpCacheButton()
        setUpNextButton()
    }
    
    func setUpTextfield() {
        view.addSubview(textField)
        textField.delegate = self
        textField.isEnabled = false
        textField.placeholder = "Введите имя перед тем как сохранить"
        textField.keyboardType = .alphabet
        verification = NameVerification()
        
    }
    func setUpImage() {
        self.view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
    }
    
    private func setUpErrorLabel() {
        view.addSubview(labelError)
        labelError.text = "ERROR. Name count char > 6"
        labelError.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin)
        labelError.textColor = .red
    }
    private func setUpLine() {
        view.addSubview(line)
        line.layer.borderWidth = 1.0
        line.layer.borderColor = UIColor.black.cgColor
        line.alpha = 0.2
    }
    
    private func setUpCoreDataButton() {
        view.addSubview(coreDataButton)
        coreDataButton.addTarget(self, action: #selector(addToCoreData), for: .touchUpInside)
        coreDataButton.isEnabled = false
        setUpButton(btn: coreDataButton, normalText: "add to CoreData", selectedText: "IN COREDATA", backgroundColorNormal: .white, backgroundColorSelected: .red, textColor: .red)
    }
    
    private func setUpCacheButton() {
        view.addSubview(cacheButton)
        setUpButton(btn: cacheButton, normalText: "add To Cashe", selectedText: "IN CACHE", backgroundColorNormal: .white, backgroundColorSelected: .red, textColor: .red)
        cacheButton.isEnabled = false
        cacheButton.addTarget(self, action: #selector(addToCache), for: .touchUpInside)
    }
    private func setUpNextButton() {
        view.addSubview(nextButton)
        setUpButton(btn: nextButton, normalText: "Next", selectedText: "Next", backgroundColorNormal: .white, backgroundColorSelected: .green, textColor: .green)
        nextButton.isEnabled = false
        nextButton.addTarget(self, action: #selector(nextImage), for: .touchUpInside)
    }
    
    @objc
    private func addToCache() {
        if cacheButton.isSelected {
            print("1 \(cacheButton.isSelected)")
            output.addToCache(name: textField.text ?? " ", selected: true)
            cacheButton.isSelected = false
        } else if !output.inCacheData(name: textField.text ?? " "){
            labelError.text = "ERROR.Only latin letters and number(one word) letters count > 6"
            isInputCorrect(true, type: .Cache)
            print("2 \(cacheButton.isSelected)")
            output.addToCache(name: textField.text ?? " ", selected: false)
            cacheButton.isSelected = true
        } else if !errorFounded {
            print("3 \(cacheButton.isSelected)")
            labelError.text = "Такое имя уже есть в Cache"
            errorFounded = false
            isInputCorrect(true, type: .Cache)
            cacheButton.isSelected = false
        } else {
            print("4 \(cacheButton.isSelected)")
            errorFounded = false
            isInputCorrect(false, type: .Cache)
            labelError.text = "ERROR.Only latin letters and number(one word) letters count > 6"
        }
    }
    @objc
    private func addToCoreData() {
        if coreDataButton.isSelected {
            print("1 \(coreDataButton.isSelected)")
            output.addToCoreData(name: textField.text ?? " ", selected: true)
            coreDataButton.isSelected = false
        } else if !output.inCoreData(name: textField.text ?? " "){
            labelError.text = "ERROR.Only latin letters and number(one word) letters count > 6"
            isInputCorrect(true, type: .CoreData)
            print("2 \(coreDataButton.isSelected)")
            output.addToCoreData(name: textField.text ?? " ", selected: false)
            coreDataButton.isSelected = true
        } else if !errorFounded {
            print("3 \(coreDataButton.isSelected)")
            labelError.text = "Такое имя уже есть в Core Data"
            errorFounded = false
            isInputCorrect(true, type: .CoreData)
            coreDataButton.isSelected = false
        } else {
            print("4 \(coreDataButton.isSelected)")
            errorFounded = false
            isInputCorrect(false, type: .CoreData)
            labelError.text = "ERROR. Name count char > 6"
        }
    }
    @objc
    private func nextImage() {
        output.getData()
        self.imageIsLoaded = false
        self.view.setTemplateWithSubviews(true)
        self.textField.text = ""
        isInputCorrect(true, type: .all)
        self.cacheButton.isEnabled = false
        self.coreDataButton.isEnabled = false
        
    }
    
    private func setUpButton(btn: UIButton, normalText: String, selectedText: String, backgroundColorNormal: UIColor, backgroundColorSelected: UIColor, textColor: UIColor) {
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
        btn.layer.borderWidth = 2
        btn.layer.borderColor = textColor.cgColor
        btn.clipsToBounds = true
        btn.setTitleColor(textColor, for: .normal)
        btn.setTitleColor(.white, for: .highlighted)
        btn.setTitleColor(.white, for: .selected)
        btn.setBackgroundColor(color: backgroundColorSelected, forState: .highlighted)
        btn.setBackgroundColor(color: backgroundColorSelected, forState: .selected)
        btn.setBackgroundColor(color: .clear, forState: .normal)
        btn.setTitle(selectedText, for: .selected)
        btn.setTitle(normalText, for: .normal)
        btn.layer.cornerRadius = CGFloat(10)
    }
    
    private func updateHeight(with error: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.myHeightAnchor.constant = error ? 24 : 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func isInputCorrect(_ verify: Bool, type: TypeData) {
        switch type {
        case .CoreData:
            coreDataButton.isEnabled = verify
        case .Cache:
            cacheButton.isEnabled = verify
        case .none:
            cacheButton.isEnabled = verify
            coreDataButton.isEnabled = verify
            cacheButton.isSelected = false
            coreDataButton.isSelected = false
        case .all:
            cacheButton.isEnabled = verify
            coreDataButton.isEnabled = verify
            cacheButton.isSelected = false
            coreDataButton.isSelected = false
        }
        line.backgroundColor = verify == true ? .black : .red
        line.layer.borderColor = verify == true ? UIColor.black.cgColor : UIColor.red.cgColor
        line.alpha = verify == true ? 0.2 : 1
        labelError.isHidden = verify
        updateHeight(with: !verify)
    }
    
    private func setUpNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(notificationActionCoreData), name: NSNotification.Name("coreData_delete"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationActionCacheData), name: NSNotification.Name("cacheData_delete"), object: nil)
    }
    @objc
    private func notificationActionCoreData() {
        coreDataButton.isSelected = false
    }
    @objc
    private func notificationActionCacheData() {
        cacheButton.isSelected = false
    }
}

extension MainViewController: MainViewInput {
    func reloadImage(model: ImageApiModel) {
        DispatchQueue.global().async {
            ImageLoader.shared.image(with: model.first?.url ?? "") { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.view.setTemplateWithSubviews(false)
                    self.imageIsLoaded = true
                    self.textField.isEnabled = true
                    self.nextButton.isEnabled = true
                }
            }
        }
    }
    
}




extension MainViewController: UITextFieldDelegate {
    //    MARK: FOR Phone mask
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //        guard let formatter = formatter else { return true }
    //        return formatter.mask(textField, range: range, replacementString: string)
    //    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let verification = verification else { return }
        if verification.verify(from: textField.text ?? "") {
            errorFounded = false
            isInputCorrect(true, type: TypeData.none)
        } else {
            labelError.text = "ERROR.Only latin letters and number(one word) letters count > 6"
            isInputCorrect(false, type: .none)
            errorFounded = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
