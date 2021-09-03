//
//  Coordinator.swift
//  
//
//  Created by Andrey Goryunov on 03.09.2021.
//

public protocol Coordinator: AnyObject {
    
    typealias CoordinatorHandler = (Coordinator) -> Void
    var flowCompletion: CoordinatorHandler? { get set }
    func start()
    
}
