//
//  ColorDetailRouter.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import UIKit

final class ColorDetailRouter {
}

extension ColorDetailRouter: ColorDetailRouterInput {
    func openFullScreen(with view: ColorDetailViewInput?, colorData: ColorDetailModel) {
        guard let view = view as? UIViewController else {
            return}
        let colorFullScreenVC = BuyColorContainer.assemble(with: BuyColorContext(modelInput: colorData)).viewController
        colorFullScreenVC.view.backgroundColor = colorData.color
        view.modalPresentationStyle = .popover
        view.navigationController?.show(colorFullScreenVC, sender: nil)
    }
    
}
