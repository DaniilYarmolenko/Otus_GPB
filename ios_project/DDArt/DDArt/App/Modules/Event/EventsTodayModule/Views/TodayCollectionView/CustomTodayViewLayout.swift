//
//  CustomViewLayout.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 15.11.2022.
//

import UIKit

protocol CustomTodayLayoutDelegate: AnyObject {
    
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat, complition:  @escaping (CGFloat) -> Void)

    func collectionView(_ collectionView: UICollectionView, heightForDescriptionAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
}

final class CustomTodayLayoutAttributes: UICollectionViewLayoutAttributes {
    var imageHeight: CGFloat = 0

    override func copy(with zone: NSZone?) -> Any {
        guard let copy = super.copy(with: zone) as? CustomTodayLayoutAttributes else {
            return (Any).self
        }
        copy.imageHeight = imageHeight
        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? CustomTodayLayoutAttributes {
            if attributes.imageHeight == imageHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}

final class CustomTodayViewLayout: UICollectionViewLayout {
    weak var delegate: CustomTodayLayoutDelegate!
    var numberOfColumns = 2
    var cellPadding: CGFloat = 10

    var cache = [CustomTodayLayoutAttributes]()
    fileprivate var contentHeight: CGFloat = 0
    fileprivate var width: CGFloat {
        guard let collectionView =  collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        if contentHeight == 0 { prepare() }
        return CGSize(width: width, height: contentHeight)
    }

    override class var layoutAttributesClass: AnyClass {
        return CustomTodayLayoutAttributes.self
    }

    override func prepare() {
        if cache.isEmpty {
            guard let collectionView =  collectionView else { return }
            let columnWidth = width / CGFloat(numberOfColumns)

            var xOffsets = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffsets.append(CGFloat(column) * columnWidth)
            }

            var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)

            var column = 0
            for item in 0..<collectionView.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)

                let width = columnWidth - (cellPadding * 2)
                delegate.collectionView(collectionView, heightForImageAtIndexPath: indexPath, withWidth: width) { float in
                    let descriptionHeight = self.delegate.collectionView(
                        collectionView,
                        heightForDescriptionAtIndexPath: indexPath,
                        withWidth: width
                    )
                    let height = self.cellPadding + float + descriptionHeight + self.cellPadding

                    let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                    let insetFrame = frame.insetBy(dx: self.cellPadding, dy: self.cellPadding)
                    let attributes = CustomTodayLayoutAttributes(forCellWith: indexPath)
                    attributes.frame = insetFrame
                    attributes.imageHeight = float
                    self.cache.append(attributes)
                    self.contentHeight = max(self.contentHeight, frame.maxY)
                    yOffsets[column] = yOffsets[column] + height
                    column = column >= (self.numberOfColumns - 1) ? 0 : column + 1
                }
            }
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if indexPath.isEmpty { return nil }
        if indexPath.item >= cache.count { return nil }
        return cache.contains(cache[indexPath.item]) ? cache[indexPath.item]: nil
    }
}
