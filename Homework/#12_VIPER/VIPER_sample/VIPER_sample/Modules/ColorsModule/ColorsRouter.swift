//
//  ColorsRouter.swift
//  VIPER_sample
//
//  Created by Даниил Ярмоленко on 21.11.2022.
//  
//

import UIKit

final class ColorsRouter {
}

extension ColorsRouter: ColorsRouterInput {
    
    func itemSelected(with view: ColorsViewInput?, and model: ColorModel) {
        guard let view = view as? UIViewController else {return}
        
        let detailColor =  ColorDetailContainer.assemble(with: ColorDetailContext(colorType: model.colorType))
        view.navigationController?.pushViewController(detailColor.viewController, animated: true)
    }
    
}
