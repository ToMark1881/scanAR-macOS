//  VIPER Template created by Vladyslav Vdovychenko
//  
//  HomeWireframe.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 16.01.2023.
//

import Foundation

final class HomeWireframe: BaseWireframe {
    
    override func storyboardName() -> String {
        return "Home"
    }
    
    override func identifier() -> String {
        return "HomeViewController"
    }
    
    func createModule(moduleInput: inout HomeModuleInput?,
                      moduleOutput: HomeModuleOutput?) -> HomeViewController? {
        guard let view: HomeViewController = initializeController() else { return nil }
        
        let presenter = HomePresenter()
        let router = HomeRouter()
        let interactor = HomeInteractor()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.output = presenter
        router.output = presenter
        
        router.view = view
        presenter.moduleOutput = moduleOutput
        
        interactor.output = presenter
        
        moduleInput = presenter
        
        return view
    }
    
}
