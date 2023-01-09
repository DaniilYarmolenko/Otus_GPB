//
//  HeaderViewCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 07.12.2022.
//

import Foundation
import UIKit
final class HeaderCellView: BaseCell {
    internal var titleLabel = UILabel()
    internal var moreButton = UIButton()

    static let cellIdentifier = "HeaderCellModel"

    override func updateViews() {
        guard let model = model as? HeaderCellViewModel else { return }
        titleLabel.attributedText = model.title.underLined

        if model.action == nil {
            moreButton.isHidden = true
        } else {
            moreButton.setTitle(LabelConstants.AllLabelText, for: .normal)
            moreButton.isHidden = false
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [titleLabel, moreButton].forEach { [weak self] in
            self?.contentView.addSubview($0)
        }
        addConstraintsHeader()
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpBase()
        setUpLabel()
        setUpButton()
    }

    @objc
    private func clickAll() {
        guard let model = model as? HeaderCellViewModel else { return }
        model.action?()
    }

    private func setUpButton() {
        moreButton.addTarget(self, action: #selector(clickAll), for: .touchUpInside)
        moreButton.setTitleColor(ColorConstants.BlackTextColor, for: .normal)
    }

    private func setUpBase() {
        backgroundColor = .clear
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
    }

    private func setUpLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.textColor = ColorConstants.BlackTextColor
        titleLabel.font = UIFont(name: FontConstants.MoniqaMediumNarrow, size: 40)
    }
}
