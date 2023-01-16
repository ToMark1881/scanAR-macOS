//  VIPER Template created by Vladyslav Vdovychenko
//  
//  HomePresenter.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 16.01.2023.
//

import Foundation

final class HomePresenter: BasePresenter {
    
    weak var view: HomeViewInput!
    var interactor: HomeInteractorInput!
    var router: HomeRouterInput!
    
    weak var moduleOutput: HomeModuleOutput?
    
}

// MARK: - Module Input
extension HomePresenter: HomeModuleInput {
    
}

// MARK: - View - Presenter
extension HomePresenter: HomeViewOutput {
    
}

// MARK: - Interactor - Presenter
extension HomePresenter: HomeInteractorOutput {
    
}

// MARK: - Router - Presenter
extension HomePresenter: HomeRouterOutput {
    
}
