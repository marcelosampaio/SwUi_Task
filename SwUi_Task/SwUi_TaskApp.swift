//
//  SwUi_TaskApp.swift
//  SwUi_Task
//
//  Created by Marcelo Sampaio on 04/12/22.
//

import SwiftUI

@main
struct SwUi_TaskApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(stock: Stock(high: 0, low: 0, current: 0, name: Constants.loadMessage))
        }
    }
}
