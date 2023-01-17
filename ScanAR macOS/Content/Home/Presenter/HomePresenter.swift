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
    
    private var selectedFolderURL: URL?
    
}

// MARK: - Module Input
extension HomePresenter: HomeModuleInput {
    
}

// MARK: - View - Presenter
extension HomePresenter: HomeViewOutput {
    
    func onViewDidLoad() {
        let configuration: HomeViewConfiguration = .init(dragAndDropOutput: self)
        
        view.setup(with: configuration)
    }
    
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

extension HomePresenter: DragAndDropViewDelegate {
    
    func dragDropView(_ dragDropView: DragAndDropView, droppedFileWithURL URL: URL) {
        selectedFolderURL = URL
        view.setText(string: URL.path())
    }
    
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
            
            selectedFolderURL = result
            let path = result.path()
            view.setText(string: path)
            
        default:
            break
        }
    }
    
}
