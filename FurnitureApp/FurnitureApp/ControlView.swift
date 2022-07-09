//
//  ControlView.swift
//  FurnitureApp
//
//  Created by Ilya Zelkin on 25.05.2022.
//  Copyright © 2022 Ilya Zelkin. All rights reserved.
//

import SwiftUI

struct ControlView: View {
    @Binding var isControlsVisible: Bool
    @Binding var showBrowse: Bool
    @Binding var showSettings: Bool
    
    var body: some View {
        VStack {
            
            ControlVisibilityToggleButton(isControlsVisible: $isControlsVisible)
            
            Spacer()
            
            if isControlsVisible {
                ControlButtonBar(showBrowse: $showBrowse, showSettings: $showSettings)
            }
        }
    }
}

struct ControlVisibilityToggleButton: View {
    @Binding var isControlsVisible: Bool
    
    var body: some View {
        HStack {
            
            Spacer()
            
            ZStack {
                Color.black.opacity(0.25)
                
                Button {
                    print("Control Visibility Toggle Button Pressed")
                    self.isControlsVisible.toggle()
                } label: {
                    Image(systemName: isControlsVisible ? "rectangle" : "slider.horizontal.below.rectangle")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .buttonStyle(.plain)
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8.0)
        }
        .padding(.top, 45)
        .padding(.trailing, 20)
    }
}

struct ControlButtonBar: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var showBrowse: Bool
    @Binding var showSettings: Bool
    
    var body: some View {
        HStack {
            //RecentlyButton
            MostRecentlyPlacedButton().hidden(self.placementSettings.recentlyPlaced.isEmpty)
            
            Spacer()
            
            //Browse Button
            ControlButton(systemIconName: "square.grid.2x2") {
                print("Browse Button Pressed")
                self.showBrowse.toggle()
            }.sheet(isPresented: $showBrowse) {
                //Browse View
                BrowseView(showBrowse: $showBrowse)
            }
            
            Spacer()
            
            //Settings Button
            ControlButton(systemIconName: "slider.horizontal.3") {
                print("Settings Button Pressed")
                self.showSettings.toggle()
            }.sheet(isPresented: $showSettings) {
                SettingsView(showSettings: $showSettings)
            }
        }
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.black.opacity(0.25))
    }
}

struct ControlButton: View {
    let systemIconName: String
    let action: () -> ()
    
    var body: some View {
        HStack {
            Button {
                self.action()
            } label: {
                Image(systemName: systemIconName)
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(.plain)
            }
            .frame(width: 50, height: 50)
        }
    }
}

struct MostRecentlyPlacedButton: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    var body: some View {
        Button {
            print("Most Recently Placed Button Pressed")
            self.placementSettings.selectedModel = self.placementSettings.recentlyPlaced.last
        } label: {
            if let mostRecentlyPlacedModel = self.placementSettings.recentlyPlaced.last {
                Image(uiImage: mostRecentlyPlacedModel.thumbnail)
                    .resizable()
                    .aspectRatio(1/1, contentMode: .fit)
            } else {
                Image(systemName: "clock.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(.plain)
            }
        }
        .frame(width: 50, height: 50)
        .background(Color.white)
        .cornerRadius(8.0)
    }
}
