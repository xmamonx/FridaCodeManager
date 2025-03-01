 /* 
 AboutView.swift 

 Copyright (C) 2023, 2024 SparkleChan and SeanIsTethered 
 Copyright (C) 2024 fridakitten 

 This file is part of FridaCodeManager. 

 FridaCodeManager is free software: you can redistribute it and/or modify 
 it under the terms of the GNU General Public License as published by 
 the Free Software Foundation, either version 3 of the License, or 
 (at your option) any later version. 

 FridaCodeManager is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of 
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 GNU General Public License for more details. 

 You should have received a copy of the GNU General Public License 
 along with FridaCodeManager. If not, see <https://www.gnu.org/licenses/>. 
 */ 

import SwiftUI
import UIKit

struct Frida: View {
    @Binding var hello: UUID
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("About")) {
                    Text("FridaCodeManager \(global_version)")
                }
                Section(header: Text("Credits")) {
                    cell(credit: "SeanIsNotAConstant", role: "Main Developer", url: "https://github.com/fridakitten.png")
                    cell(credit: "AppInstaller iOS", role: "Compiling Genius", url: "https://github.com/AppInstalleriOSGH.png")
                    cell(credit: "Snoolie", role: "Helping Hand", url: "https://github.com/0xilis.png")
                    cell(credit: "HAHALOSAH", role: "Helping Hand", url: "https://github.com/HAHALOSAH.png")
                    cell(credit: "MudSplasher", role: "Icon Designer", url: "https://github.com/MudSplasher.png")
                    cell(credit: "meighler", role: "Licensor", url: "https://github.com/meighler.png")
                }
                Section(header: Text("Side Credits")) {
                    cell(credit: "Opa334", role: "Trollstore Helper", url: "https://github.com/opa334.png")
                    cell(credit: "Theos", role: "SDK", url: "https://github.com/theos.png")
                }
                Section(header: Text("Supporters")) {
                    cell(credit: "RoothideDev", role: "Giving me Power", url: "https://github.com/roothide.png")
                    cell(credit: "Speedyfriend67", role: "Making Projects using FCM", url: "https://github.com/speedyfriend433.png")
                    cell(credit: "Burhan Rana", role: "Making videos about my tools", url: "https://github.com/burhangee.png")
                }
            }
            .id(hello)
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(InsetGroupedListStyle())
        }
    }
}
