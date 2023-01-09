//
//  EventFutureCell.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 11.12.2022.
//

import Foundation
import UIKit
final class EventFutureCell: UICollectionViewCell {
    static let cellIdentifier = String(describing: EventFutureCell.self)
    
    internal var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        setUpImageView()
    }
    
    private func setUpImageView() {
        self.clipsToBounds = true
        self.autoresizesSubviews = true
        
        imageView.frame = self.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(imageView)
    }
    
    func configure(model: EventModel, complition: @escaping () -> (Bool)) {
        guard !model.photos.isEmpty else {return}
    }
}
