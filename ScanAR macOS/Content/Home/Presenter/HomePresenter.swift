//  VIPER Template created by Vladyslav Vdovychenko
//  
//  HomePresenter.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 16.01.2023.
//

import Foundation
import Cocoa

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
    
    func onOpenDirectoryTap() {
        presentSelectDirectoryDialog()
    }
    
}

// MARK: - Interactor - Presenter
extension HomePresenter: HomeInteractorOutput {
    
}

// MARK: - Router - Presenter
extension HomePresenter: HomeRouterOutput {
    
}

private extension HomePresenter {
    
    func presentSelectDirectoryDialog() {
        let dialog = NSOpenPanel()
        dialog.title = "Choose directory with photos"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseFiles = false
        dialog.canChooseDirectories = true
        
        switch dialog.runModal() {
        case NSApplication.ModalResponse.OK:
            guard let result = dialog.url else {
                return
            }
            
            let path = result.path()
            view.setText(string: path)
            
        default:
            break
        }
    }
    
}
