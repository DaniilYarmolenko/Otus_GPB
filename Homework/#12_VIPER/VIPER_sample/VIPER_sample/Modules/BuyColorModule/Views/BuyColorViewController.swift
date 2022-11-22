//
//  BuyColorViewController.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 22.11.2022.
//  
//

import UIKit

final class BuyColorViewController: UIViewController {
	private let output: BuyColorViewOutput
    internal var buyButton = UIButton()
    init(output: BuyColorViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        output.itemDidLoad()
        output.viewDidLoad()
        setUpNotification()
        setUp()
	}
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
    }
    private func setUp() {
        buyButton.addTarget(self, action: #selector(clickBuy), for: .touchUpInside)
        setUpButton(btn: buyButton)
        self.view.addSubview(buyButton)
    }
    private func setUpButton(btn: UIButton) {
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.cyan.cgColor
        btn.clipsToBounds = true
        btn.setTitleColor(UIColor.cyan, for: .normal)
        btn.setTitleColor( .white, for: .highlighted)
        btn.setTitleColor( .white, for: .selected)
        btn.setBackgroundColor(color: .cyan, forState: .highlighted)
        btn.setBackgroundColor(color: .cyan, forState: .selected)
        btn.setBackgroundColor(color: .clear, forState: .normal)
        btn.setTitle("В корзине", for: .selected)
        btn.setTitle("Купить", for: .normal)
    }
    
    @objc
    private func clickBuy() {
        buyButton.isSelected.toggle()
        output.itemDidLoad()
        output.clickBuy(selected: buyButton.isSelected)
    }
    @objc
    private func notificationAction() {
        output.checkCart()
    }
    private func setUpNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAction), name: NSNotification.Name("delete_cart"), object: nil)
    }
}

extension BuyColorViewController: BuyColorViewInput {
    func updateButton(selected: Bool) {
        buyButton.isSelected = selected
    }
    
}
