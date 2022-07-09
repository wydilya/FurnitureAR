//
//  View+Extensions.swift
//  FurnitureApp
//
//  Created by Ilya Zelkin on 30.05.2022.
//  Copyright © 2022 Ilya Zelkin. All rights reserved.
//

import SwiftUI

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}
