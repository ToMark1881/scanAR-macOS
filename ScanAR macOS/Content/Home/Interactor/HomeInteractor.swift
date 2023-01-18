//  VIPER Template created by Vladyslav Vdovychenko
//  
//  HomeInteractor.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 16.01.2023.
//

import Foundation
import RealityKit

typealias ProcessingQuality = PhotogrammetrySession.Request.Detail

final class HomeInteractor: BaseInteractor {
    
    weak var output: HomeInteractorOutput!
    
    var directoryURL: URL?
    var processingQuality: ProcessingQuality = .reduced
    
}

extension HomeInteractor: HomeInteractorInput {
    
    func generatePreview() {
        createModel(with: .preview)
    }
    
    func createModel() {
        createModel(with: processingQuality)
    }
    
}

private extension HomeInteractor {
    
    func createModel(with quality: ProcessingQuality) {
        guard let url = directoryURL,
              let outputURL = URL(string: url.absoluteString + "/model.usdz")  else {
            return
        }
        
        let configuration: PhotogrammetrySession.Configuration = .init()
        do {
            let session = try PhotogrammetrySession(input: url,
                                                    configuration: configuration)
            
            
            try session.process(requests: [
                .modelFile(url: outputURL,
                           detail: quality)
            ])
            
            Task {
                for try await output in session.outputs {
                    switch output {
                    case .requestProgress(let request, let fraction):
                        print("Progress: \(fraction)")
                    case .requestComplete(let request, let result):
                        if case .modelFile(let url) = result {
                            print("Result output at \(url)")
                        }
                    case .requestError(let request, let error):
                        "Request \(request) get error \(error)"
                    case .processingComplete:
                        print("Completed!")
                    default:
                        break
                    }
                }
            }
        } catch let error {
            print(error)
        }
    }
    
}
