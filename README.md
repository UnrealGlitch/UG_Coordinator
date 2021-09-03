# UG_Coordinator

MVVM + Coordinator

## How to use

### Create view controller

```swift

let settingsVm = SettingsViewModel(output: self)
let settingsVc = SettingsViewController(viewModel: settingsVm)

```
### Create coordinator

```swift

final class AppCoordinator: BaseCoordinator {
    
    // MARK: - Private properties
    
    private weak var window: UIWindow?
    private let router: Router
    
    // MARK: - Life cycle
    
    init(window: UIWindow) {
        self.window = window
        let rootViewController = UINavigationController()
        
        window.rootViewController = rootViewController
        
        router = DefaultRouter(rootController: rootViewController)
        
        super.init()
    }
    
    // MARK: - Internal functions
    
    override func start() {
        startMainFlowCoordinator()
    }
    
}

// MARK: - Private

private extension AppCoordinator {
    
    func startMainFlowCoordinator() {
        let coordinator = MainFlowCoordinator(router: router)
        
        addDependency(coordinator)
        coordinator.start()
    }
    
}

```

### Navigation

```swift

import Routing

final class MainFlowCoordinator: BaseCoordinator {
    
    // MARK: - Private properties
    
    private let router: Router?
    private var gameCoordinator: GameFlowCoordinator?
    private var settingsCoordinator: SettingsFlowCoordinator?
    
    // MARK: - Life cycle
    
    init(router: Router) {
        self.router = router
        
        super.init()
    }
    
    // MARK: - Internal
    
    override func start() {
        super.start()
        
        showMainScreen()
    }
    
}

// MARK: - Private

private extension MainFlowCoordinator {
    
    func showMainScreen() {
        let mainScreenVm = MainScreenViewModel(output: self)
        let mainScreenVc = MainScreenViewController(viewModel: mainScreenVm)
        router?.push(mainScreenVc, animated: true)
    }
    
}

// MARK: - MainScreenViewModelOutput

extension MainFlowCoordinator: MainScreenViewModelOutput {
    
    func onMainScreenPlayButtonTap(_ viewModel: MainScreenViewModel) {
        guard let router = router else {
            return
        }
        let gameCoordinator = GameFlowCoordinator(router: router)
        addDependency(gameCoordinator)
        
        gameCoordinator.flowCompletion = { [weak self] coordinator in
            guard let self = self, let router = self.router else {
                return
            }
            
            router.pop(animated: true)
            self.removeDependency(coordinator)
        }
        
        gameCoordinator.start()
        
        self.gameCoordinator = gameCoordinator
    }
    
    func onMainScreenSettingsButtonTap(_ viewModel: MainScreenViewModel) {
        guard let router = router else {
            return
        }
        let settingsCoordinator = SettingsFlowCoordinator(router: router, output: self)
        addDependency(settingsCoordinator)
        
        settingsCoordinator.flowCompletion = { [weak self] coordinator in
            guard let self = self, let router = self.router else {
                return
            }
            
            router.pop(animated: true)
            self.removeDependency(coordinator)
        }
        
        settingsCoordinator.start()
        
        self.settingsCoordinator = settingsCoordinator
    }
    
    func onMainScreenBackButtonTap(_ viewModel: MainScreenViewModel) {
        router?.pop(animated: true)
    }
    
}

// MARK: - SettingsFlowCoordinatorOutput

extension MainFlowCoordinator: SettingsFlowCoordinatorOutput {
    
    func onSettingsFinishFlow() {
        guard 
            let settingsCoordinator = settingsCoordinator, 
            let completion = settingsCoordinator.flowCompletion 
        else {
            return
        }
        
        completion(settingsCoordinator)
    }
    
}

```
