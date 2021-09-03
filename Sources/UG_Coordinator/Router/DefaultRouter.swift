//
//  DefaultRouter.swift
//  
//
//  Created by Andrey Goryunov on 03.09.2021.
//

import UIKit

final public class DefaultRouter: NSObject {
    
    // MARK: - Internal properties
    
    let rootController: UINavigationController
    
    // MARK: - Public life cycle
    
    public init(rootController: UINavigationController) {
        rootController.navigationBar.isHidden = true
        self.rootController = rootController
    }

}

extension DefaultRouter: Router {
    
    public func toPresent() -> UIViewController? {
        rootController
    }
    
    public func push(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent(), (controller is UINavigationController == false) else {
            assertionFailure("WARNING: [DefaultRouter.push]: Deprecated push UINavigationController")
            return
        }

        rootController.pushViewController(controller, animated: animated)
    }
    
    public func pop(animated: Bool) {
        rootController.popViewController(animated: animated)
    }
    
}
