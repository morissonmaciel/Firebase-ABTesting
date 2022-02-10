//
//  EmailScene.swift
//  ABTesting
//
//  Created by Morisson Marcel on 09/02/22.
//

import SwiftUI

struct EmailScene: View {
    @EnvironmentObject var userData: UserDataViewModel
    
    var body: some View {
        OnboardingView(title: "seus dados") {
            VStack(alignment: .leading) {
                Text("Qual o seu email?")
                TextField("seu@email.com", text: $userData.email)
                    .onboardingField(keyboard: .emailAddress)
            }
            
            Spacer()
            
            Button(action: {}) {
                NavigationLink(destination: Navigator.scene(to: .birthDateScene)) {
                    Text("Continuar")
                }
            }
            .onboardingButton(flex: true, disabled: userData.email.isEmpty)
        }
    }
}

struct EmailScene_Previews: PreviewProvider {
    @StateObject static var navContext = Navigator.Context()
    @StateObject static var userData = UserDataViewModel()
    
    static var previews: some View {
        NavigationView {
            EmailScene()
                .environmentObject(Self.navContext)
                .environmentObject(Self.userData)
        }
    }
}
