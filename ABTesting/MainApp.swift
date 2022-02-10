//
//  MainApp.swift
//  ABTesting
//
//  Created by Morisson Ferreira Maciel on 11/01/22.
//

import SwiftUI
import Firebase

@main
struct MainApp: App {
    @StateObject var userDataViewModel = UserDataViewModel()
    @StateObject var analyticsDataViewModel = AnalyticsDataViewModel()
    @State var canProceed = false
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if canProceed {
                    RootScene()
                        .environmentObject(userDataViewModel)
                        .environmentObject(analyticsDataViewModel)
                } else {
                    VStack {
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background((
                        Image("Splash")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                    ))
                }
            }
            .onAppear {
                DispatchQueue.global(qos: .userInitiated).async {
                    ABTestingCases.configure {
                        self.canProceed = true
                    }
                }
            }
        }
    }
    
}
