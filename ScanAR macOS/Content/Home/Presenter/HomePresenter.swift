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
    
    func onViewDidLoad() {
        let configuration: HomeViewConfiguration = .init(dragAndDropOutput: self)
        
        view.setup(with: configuration)
    }
    
    func onGeneratePreviewTap() {
        view.showLoading()
        
        interactor.generatePreview()
    }
    
    func onCreateModelTap() {
        view.showLoading()
        
        interactor.createModel()
    }
    
    func onReducedQualitySelect() {
        interactor.processingQuality = .reduced
    }
    
    func onMediumQualitySelect() {
        interactor.processingQuality = .medium
    }
    
    func onFullQualitySelect() {
        interactor.processingQuality = .full
    }
    
    func onRawQualitySelect() {
        interactor.processingQuality = .raw
    }
    
}

// MARK: - Interactor - Presenter
extension HomePresenter: HomeInteractorOutput {
    
    func didUpdateProgress(fraction: Double, for request: SessionRequest) {
        view.updateProgress(fraction * 100)
    }
    
    func didGeneratePreview(model: Model, for request: SessionRequest) {
        
    }
    
    func didGenerateModel(with outputURL: URL, for request: SessionRequest) {
        let asset = ModelAsset(url: outputURL)
        
        view.setModelAsset(asset)
    }
    
    func didReceiveError(_ error: Error) {
        
    }
    
}

// MARK: - Router - Presenter
extension HomePresenter: HomeRouterOutput {
    
}

extension HomePresenter: DragAndDropViewDelegate {
    
    func dragDropView(_ dragDropView: DragAndDropView, droppedFileWithURL URL: URL) {
        interactor.directoryURL = URL
    }
    
    func dragDropView(didTapOnOpenDirectory dragDropView: DragAndDropView) {
        presentSelectDirectoryDialog()
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
            
            interactor.directoryURL = result
            
        default:
            break
        }
    }
    
}
