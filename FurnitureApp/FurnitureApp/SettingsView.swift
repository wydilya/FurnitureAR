//
//  SettingsView.swift
//  FurnitureApp
//
//  Created by Ilya Zelkin on 30.05.2022.
//  Copyright © 2022 Ilya Zelkin. All rights reserved.
//

import SwiftUI

enum Setting {
    case peopleOcclussion
    case objectOcclussion
    case lidarDebug
    case multiuser
    
    var label: String {
        get {
            switch self {
            case .peopleOcclussion, .objectOcclussion:
                return "Occlusion"
            case .lidarDebug:
                return "LiDAR"
            case .multiuser:
                return "Multiuser"
            }
        }
    }
    
    var systemIconName: String {
        get {
            switch self {
            case .peopleOcclussion:
                return "person"
            case .objectOcclussion:
                return "cube.box.fill"
            case .lidarDebug:
                return "light.min"
            case .multiuser:
                return "person.2"
            }
        }
    }
}

struct SettingsView: View {
    @Binding var showSettings: Bool
    
    var body: some View {
        NavigationView {
            SettingsGrid()
                .navigationTitle(Text("Settings"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            self.showSettings.toggle()
                        } label: {
                            Text("Done").bold()
                        }
                    }
                }
        }
    }
}

struct SettingsGrid: View {
    @EnvironmentObject var sessionSettings: SessionSettings
    private let gridItemLayout = [GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 25)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 25) {
                SettingToggleButton(setting: .peopleOcclussion, isOn: $sessionSettings.isPeopleOcclusionEnabled)
                SettingToggleButton(setting: .objectOcclussion, isOn: $sessionSettings.isObjectOcclusionEnabled)
                SettingToggleButton(setting: .lidarDebug, isOn: $sessionSettings.isLidarDebugEnabled)
                SettingToggleButton(setting: .multiuser, isOn: $sessionSettings.isMultiuserEnabled)
            }
        }
        .padding(.top, 35)
    }
}

struct SettingToggleButton: View {
    let setting: Setting
    @Binding var isOn: Bool
    
    var body: some View {
        Button {
            self.isOn.toggle()
            print("\(#file) - \(setting): \(self.isOn)")
        } label: {
            VStack {
                Image(systemName: setting.systemIconName)
                    .font(.system(size: 35))
                    .foregroundColor(self.isOn ? .indigo : Color(UIColor.secondaryLabel))
                    .buttonStyle(.plain)
                
                Text(setting.label)
                    .font(.system(size: 17, weight: .medium, design: .default))
                    .foregroundColor(self.isOn ? .indigo : Color(UIColor.secondaryLabel))
                    .padding(.top, 5)
            }
        }
        .frame(width: 100, height: 100)
        .background(Color(UIColor.secondarySystemFill))
        .cornerRadius(20.0)
    }
}
