//
//  KeyboardView.swift
//  WhatWord
//
//  Created by Eduardo  Villalpando  on 21/08/24.
//

import SwiftUI

struct WWKeyboardViewType: Hashable {
    let name: String
    let icon: String
}

var wwKeyboardViewTypes: [WWKeyboardViewType] = [
    WWKeyboardViewType(name: "generative", icon: "sparkles.rectangle.stack.fill"),
    WWKeyboardViewType(name: "drawing", icon: "scribble.variable"),
    WWKeyboardViewType(name: "camera", icon: "camera.fill"),
    WWKeyboardViewType(name: "keyboard", icon: "keyboard.fill"),
    WWKeyboardViewType(name: "settings", icon: "gearshape.fill"),
]

struct KeyboardContainerView: View {
    var onKeyboardTypeChange: (WWKeyboardViewType) -> Void
    var onWordSubmit: (String) -> Void
    var onWordDelete: (String) -> Void
    @State private var wwKeyboardType = 0
    @State private var showingSettings = false
    @State var currentWord: String = ""
    var body: some View {
        VStack {
            Picker("Keyboard Type", selection: $wwKeyboardType) {
                ForEach(wwKeyboardViewTypes.indices, id: \.self) { index in
                    Image(systemName: wwKeyboardViewTypes[index].icon)
                }
            }
                .onReceive([self.wwKeyboardType].publisher.first(), perform: { keyboardType in
                    self.onKeyboardTypeChange(wwKeyboardViewTypes[keyboardType])
                })
                .pickerStyle(.segmented)
                .padding()
            // Current Word
            /*if (wwKeyboardViewTypes[wwKeyboardType].name != "keyboard" && wwKeyboardViewTypes[wwKeyboardType].name != "settings") {
                KeyboardWordContainerView(
                    currentWord: $currentWord,
                    onWordSubmit: {word in
                        
                    }
                )
            }*/
            // Keyboards
            switch(wwKeyboardViewTypes[wwKeyboardType].name) {
                case "generative":
                    KeyboardGenerativeView(onWordSubmit: onWordSubmit, onWordDelete: onWordDelete)
                case "drawing":
                    Spacer()
                case "settings":
                    Button("Open Settings") {
                        showingSettings.toggle()
                    }
                        .sheet(isPresented: $showingSettings){
                            SettingsView()
                        }
                default:
                    Divider()
            }
        }
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
    }
}


#Preview {
    KeyboardContainerView(
        onKeyboardTypeChange: { keyboardType in 
            print("HI")
        },
        onWordSubmit: {word in},
        onWordDelete: {word in}
    )
}
