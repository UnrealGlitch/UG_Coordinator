//
//  BaseCoordinator.swift
//  
//
//  Created by Andrey Goryunov on 03.09.2021.
//

open class BaseCoordinator: Coordinator {
    
    // MARK: - Public properties
    
    public var flowCompletion: CoordinatorHandler?
    
    // MARK: - Private properties
    
    private var childCoordinators: [Coordinator] = []
    
    // MARK: - Public life cycle
    
    public init() {
        
    }
    
    // MARK: - Open functions
    
    open func start() {
        //[COMMENT]: should be overriden
    }
    
    // MARK: - Public functions
    
    public func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    public func removeDependency(_ coordinator: Coordinator?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else {
            return
        }
        
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
    
}
