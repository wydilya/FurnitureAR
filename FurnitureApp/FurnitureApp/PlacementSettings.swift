//
//  PlacementSettings.swift
//  FurnitureApp
//
//  Created by Ilya Zelkin on 26.05.2022.
//  Copyright © 2022 Ilya Zelkin. All rights reserved.
//

import SwiftUI
import RealityKit
import Combine

class PlacementSettings: ObservableObject {
    //the user selects a model in BrowseView
    @Published var selectedModel: Model? {
        willSet(newValue) {
            print("Setting electedModel to \(String(describing: newValue?.name))")
        }
    }
    
    //When the user taps confirm in PlacementView
    @Published var confirmedModel: Model? {
        willSet(newValue) {
            guard let model = newValue else {
                print("Clearing confirmedModel")
                return
            }
            print("Setting confirmedModel to \(model.name)")
            
            self.recentlyPlaced.append(model)
        }
    }
    
    @Published var recentlyPlaced: [Model] = []
    
    var sceneObserver: Cancellable?
}
