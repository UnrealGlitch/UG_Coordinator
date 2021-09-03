//
//  BaseViewController.swift
//  
//
//  Created by Andrey Goryunov on 03.09.2021.
//

import UIKit

open class BaseViewController<T: BaseViewModel>: UIViewController {
    
    // MARK: - Public properties
    
    public let viewModel: T!
    
    // MARK: - Public life cycle
    
    public init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Open life cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
}
