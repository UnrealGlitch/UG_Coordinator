//
//  Router.swift
//  
//
//  Created by Andrey Goryunov on 03.09.2021.
//

public protocol Router: Presentable {
    
    func pop(animated: Bool)
    func push(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?, animated: Bool)
    func dismiss(animated: Bool)
    
}
