//
//  Model.swift
//  FurnitureApp
//
//  Created by Ilya Zelkin on 26.05.2022.
//  Copyright © 2022 Ilya Zelkin. All rights reserved.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case table
    case chair
    case decor
    case light
    
    var label: String {
        get {
            switch self {
            case .table:
                return "Table"
            case .chair:
                return "Chair"
            case .decor:
                return "Decor"
            case .light:
                return "Light"
            }
        }
    }
}

class Model {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink { loadComplition in
                switch loadComplition {
                case .failure(let error): print("Unable to load modelEntity for \(filename). Error \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { modelEntity in
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
                
                print("modelEntity for \(self.name) has been loaded")
            }
        
    }
}

struct Models {
    var all: [Model] = []
    
    init() {
        //Tables
        let poolTable = Model(name: "pool_table", category: .table, scaleCompensation: 20/100) //0.32/100
        let vascoTable = Model(name: "vasco_table", category: .table, scaleCompensation: 20/100)//, scaleCompensation: 0.32/100)
        let victorianTable = Model(name: "victorian_table", category: .table, scaleCompensation: 10/100)
        
        self.all += [poolTable, vascoTable, victorianTable]
        
        //Chairs
        let chairSwan = Model(name: "chair_swan", category: .chair)//0.32/100)
        let diningChair = Model(name: "dining_chair", category: .chair, scaleCompensation: 1.0/100)
        
        self.all += [chairSwan, diningChair]
        
        //Decor
        let cupSet = Model(name: "cup_saucer_set", category: .decor)
        let teapot = Model(name: "teapot", category: .decor)
        let fenderStratocaster = Model(name: "fender_stratocaster", category: .decor, scaleCompensation: 1.5/100)
        let tvRetro = Model(name: "tv_retro", category: .decor)
        let gift = Model(name: "gift", category: .decor, scaleCompensation: 0.01/100)
        let plant = Model(name: "plant", category: .decor, scaleCompensation: 10/100)
        let tableClock = Model(name: "table_clock", category: .decor, scaleCompensation: 7/100)
        
        self.all += [cupSet, teapot, fenderStratocaster, tvRetro, gift, plant, tableClock]
        
        //Lamp
        let tableLamp = Model(name: "table_lamp", category: .light, scaleCompensation: 8/100)
        let deskLamp = Model(name: "desk_lamp", category: .light, scaleCompensation: 1/100)
        let lamp = Model(name: "lamp", category: .light, scaleCompensation: 0.1/100)
        
        self.all += [tableLamp, deskLamp, lamp]
    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter({$0.category == category})
    }
}
