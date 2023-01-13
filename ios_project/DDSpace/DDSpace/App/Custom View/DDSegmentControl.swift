//
//  DDSegmentControl.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 03.11.2022.
//

import UIKit

protocol DDSegmentControlDelegate: AnyObject {
    func change(to index: Int)
}

class DDSegmentControl: UIView {
    private var buttonTitles = [String]()
    private var buttons = [UIButton]()
    private var selectorView: UIView!
    
    var textUnSelectedColor: UIColor = .gray
    var textSelectColor: UIColor = .black
    var selectorViewColor: UIColor = .black
    var selectorTextColor: UIColor = .black
    var titleFontUnSelected: UIFont = .systemFont(ofSize: 26)
    var titleFontSelected: UIFont = .systemFont(ofSize: 20)
    weak var delegate: DDSegmentControlDelegate?
    
    public var selectedIndex: Int = 0
    
    convenience init(frame: CGRect, buttonTitle: [String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
        updateView()
    }
    
    override func draw(_ rect: CGRect) {
        updateView()
        super.draw(rect)
    }
    
    func setButtonTitles(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        updateView()
    }
    
    func setIndex(index: Int) {
        buttons.forEach({ $0.setTitleColor(textSelectColor, for: .normal) })
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(textUnSelectedColor, for: .normal)
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosition
        }
    }
    
    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            if btn == sender {
                delegate?.change(to: buttonIndex)
                let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                
            }
        }
    }
    func buttonAction(buttonIndex: Int) {
        buttons.forEach { btn in
            btn.setTitleColor(textUnSelectedColor, for: .normal)
            btn.titleLabel?.font = titleFontUnSelected
        }
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
        selectedIndex = buttonIndex
        UIView.animate(withDuration: 0.3) {
            self.selectorView.frame.origin.x = selectorPosition
        }
        buttons[buttonIndex].setTitleColor(selectorTextColor, for: .normal)
        buttons[buttonIndex].titleLabel?.font = titleFontSelected
    }
    
}

// Configuration View
extension DDSegmentControl{
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        selectorView = UIView(frame: CGRect(x: 0 + CGFloat(selectedIndex) * selectorWidth, y: self.frame.height, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.titleLabel?.font = titleFontUnSelected
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(DDSegmentControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textUnSelectedColor, for: .normal)
            buttons.append(button)
        }
        buttons[selectedIndex].setTitleColor(selectorTextColor, for: .normal)
        buttons[selectedIndex].titleLabel?.font = titleFontSelected
    }
}

