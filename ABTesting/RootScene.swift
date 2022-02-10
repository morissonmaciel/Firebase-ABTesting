//
//  RootScene.swift
//  ABTesting
//
//  Created by Morisson Marcel on 09/02/22.
//

import SwiftUI
import Combine

struct RootScene: View {
    @StateObject var navigationContext = Navigator.Context()
    @State var isRootNavigationActive = false
    
    func decideNextScene() -> some View {
        let simplifiedSteps = ABTestingCases.casesStates[.onboardingWithSimplifiedSteps] ?? false
        let segmentationForm = ABTestingCases.casesStates[.showSegmentationForm] ?? false
        
        return Group {
            if segmentationForm {
                SegmentationForm()
            } else if simplifiedSteps {
                Navigator.scene(to: .simplifiedScene)
            } else {
                Navigator.scene(to: .cpfScene)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Button(action: { }, label: {
                    NavigationLink(destination: decideNextScene(), isActive: $isRootNavigationActive) {
                        Text("Criar Cadastro")
                    }
                })
                .onboardingButton(foregroundColor: ITIColor.itiPink.color, backgroundColor: .white, flex: true)
            }
            .padding()
            .navigationBarHidden(true)
            .background((
                Image("Splash")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
            ))
        }
        .environmentObject(navigationContext)
        .onReceive(Just(navigationContext.showingRootScene)) { state in
            isRootNavigationActive = state
        }
    }
}

struct RootScene_Previews: PreviewProvider {
    static var previews: some View {
        RootScene()
    }
}
