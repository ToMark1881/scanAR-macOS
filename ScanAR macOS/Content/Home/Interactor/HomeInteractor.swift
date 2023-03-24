//  VIPER Template created by Vladyslav Vdovychenko
//  
//  HomeInteractor.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 16.01.2023.
//

import Foundation
import RealityKit
import SceneKit.ModelIO

typealias ProcessingQuality = PhotogrammetrySession.Request.Detail
typealias Model = ModelEntity
typealias SessionRequest = PhotogrammetrySession.Request
typealias ModelAsset = MDLAsset

final class HomeInteractor: BaseInteractor {
    
    weak var output: HomeInteractorOutput!
    
    var directoryURL: URL?
    var processingQuality: ProcessingQuality = .preview
    
}

extension HomeInteractor: HomeInteractorInput {
    
    func generatePreview() {
        guard let inputURL = directoryURL  else {
            return
        }
        
        do {
            let session = try PhotogrammetrySession(input: inputURL,
                                                    configuration: PhotogrammetrySession.Configuration())
            
            let temporaryDirectory = URL(fileURLWithPath: NSTemporaryDirectory(),
                                         isDirectory: true).appendingPathComponent("previewModel.usdz")
            
            let request = PhotogrammetrySession.Request.modelFile(url: temporaryDirectory, detail: .preview)
            try session.process(requests: [request])
            
            try performSessionOutputs(session)
        } catch let error {
            output.didReceiveError(error)
            print(error.localizedDescription)
        }
    }
    
    func createModel() {
        guard let inputURL = directoryURL,
              let outputURL = outputURL else {
            return
        }
        
        do {
            let session = try PhotogrammetrySession(input: inputURL,
                                                    configuration: PhotogrammetrySession.Configuration())
            
            let request = PhotogrammetrySession.Request.modelFile(url: outputURL, detail: processingQuality)
            try session.process(requests: [request])
            
            try performSessionOutputs(session)
        } catch let error {
            output.didReceiveError(error)
            print(error.localizedDescription)
        }
    }
    
    func shareModel(from sender: NSView) {
        guard let url = outputURL else {
            return
        }
        
        let sharingPicker = NSSharingServicePicker(items: [url])
        sharingPicker.show(relativeTo: .zero, of: sender, preferredEdge: .minY)
    }
    
}

private extension HomeInteractor {
    
    var outputURL: URL? {
        guard let url = directoryURL,
              let outputURL = URL(string: url.absoluteString + "/model.usdz")  else {
            return nil
        }
        
        return outputURL
    }
    
    func performSessionOutputs(_ session: PhotogrammetrySession) throws {
        Task {
            for try await output in session.outputs {
                switch output {
                case .requestProgress(let request, let fraction):
                    await MainActor.run {
                        self.output.didUpdateProgress(fraction: fraction, for: request)
                    }
                    print("Progress: \(fraction)")
                    
                case .requestComplete(let request, let result):
                    await MainActor.run {
                        switch result {
                        case .modelFile(let url):
                            self.output.didGenerateModel(with: url, for: request)
                            print("Result output at \(url)")
                            
                        case .modelEntity(let model):
                            self.output.didGeneratePreview(model: model, for: request)
                            print("Preview model generated")
                        default:
                            break
                        }
                    }
                    
                case .requestError(let request, let error):
                    self.output.didReceiveError(error)
                    print("Request \(request) get error \(error)")
                    
                case .processingComplete:
                    print("Completed!")
                default:
                    break
                }
            }
        }
    }
    
}
