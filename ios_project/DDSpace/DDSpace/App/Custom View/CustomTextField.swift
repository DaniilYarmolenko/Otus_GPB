//
//  CustomTextField.swift
//  AppSave
//
//  Created by Даниил Ярмоленко on 01.12.2022.
//

import UIKit

final class CustomTextField: UITextField {
    // MARK: - Subviews
    
    private lazy var lblPlaceholder: UILabel = {
        let view = UILabel()
        if let font = self.font {
            view.font = font
        }
        view.textColor = .lightGray
        return view
    }()
    
    // MARK: - Properties
    
    private weak var _delegate: UITextFieldDelegate?
    
    override var placeholder: String? {
        get { lblPlaceholder.text }
        set { lblPlaceholder.text = newValue }
    }
    
    override var attributedPlaceholder: NSAttributedString? {
        get { lblPlaceholder.attributedText }
        set { lblPlaceholder.attributedText = newValue }
    }
    
    override var delegate: UITextFieldDelegate? {
        get { _delegate }
        set { _delegate = newValue }
    }
    
    override var text: String? {
        didSet { slidePlaceholderIfNeeded(newText: text) }
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupUI()
        super.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        addSubview(lblPlaceholder)
        
        lblPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        lblPlaceholder.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lblPlaceholder.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor).isActive = true
        lblPlaceholder.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        guard let clearButton = self.value(forKey: "_clearButton") as? UIButton else {
            return
        }
        let templateImage = clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        clearButton.setImage(templateImage, for: .normal)
        clearButton.setImage(templateImage, for: .highlighted)
        clearButton.tintColor = .gray
    }
    
    private func slidePlaceholderIfNeeded(newText: String?) {
        let text = newText ?? ""
        let lineHieght = font?.lineHeight ?? 0
        let translationY = lineHieght + 4
        let transform = text.isEmpty
        ? CGAffineTransform.identity
        : CGAffineTransform(translationX: 0, y: -translationY).scaledBy(x: 0.95, y: 0.95)
        let size: CGFloat = text.isEmpty ? 16 : 12
        let fontWeight = text.isEmpty ? UIFont.Weight.regular : UIFont.Weight.thin
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.lblPlaceholder.transform = transform
                self.lblPlaceholder.font = UIFont.systemFont(ofSize: size, weight: fontWeight)
            }
        )
    }
}

// MARK: - UITextFieldDelegate
extension CustomTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        slidePlaceholderIfNeeded(newText: text)
        return _delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        _delegate?.textFieldDidEndEditing?(textField)
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        let shouldClear = _delegate?.textFieldShouldClear?(textField) ?? true
        if shouldClear {
            slidePlaceholderIfNeeded(newText: nil)
        }
        return shouldClear
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let shouldReturn = delegate?.textFieldShouldReturn?(textField) else { return false }
        return shouldReturn
    }
}
