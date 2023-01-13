//
//  NewsRouter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 06.01.2023.
//  
//

import UIKit

final class NewsRouter {
    weak var navigationController: UINavigationController?
}

extension NewsRouter: NewsRouterInput {
    func newsSelected(news: NewsModel) {
        let newsDetail = NewsDetailContainer.assemble(with: NewsDetailContext(news: news))
        self.navigationController?.pushViewController(newsDetail.viewController, animated: true)
    }
    
}
