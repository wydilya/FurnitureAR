//
//  SessionSettings.swift
//  FurnitureApp
//
//  Created by Ilya Zelkin on 30.05.2022.
//  Copyright © 2022 Ilya Zelkin. All rights reserved.
//

import SwiftUI

class SessionSettings: ObservableObject {
    @Published var isPeopleOcclusionEnabled: Bool = false
    @Published var isObjectOcclusionEnabled: Bool = false
    @Published var isLidarDebugEnabled : Bool = false
    @Published var isMultiuserEnabled : Bool = false
}
