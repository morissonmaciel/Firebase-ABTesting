//
//  BirthDateScene.swift
//  ABTesting
//
//  Created by Morisson Marcel on 09/02/22.
//

import SwiftUI

struct BirthDateScene: View {
    @EnvironmentObject var userData: UserDataViewModel
    var mask = Mask(maskFormat: "##/##/####")
    
    var body: some View {
        OnboardingView(title: "seus dados") {
            VStack(alignment: .leading) {
                Text("Qual sua data de nascimento?")
                TextField("00/00/0000",
                          text: Binding<String>(
                            get: { userData.birthDate },
                            set: { value in userData.birthDate = mask.formateValue(value) }
                          ))
                    .onboardingField(keyboard: .numberPad)
            }
            
            Spacer()
            
            Button(action: {}) {
                NavigationLink(destination: Navigator.scene(to: .endOnboardingScene)) {
                    Text("Concluir")
                }
            }
            .onboardingButton(flex: true, disabled: userData.birthDate.isEmpty)
        }
    }
}

struct BirthDateScene_Previews: PreviewProvider {
    @StateObject static var navContext = Navigator.Context()
    @StateObject static var userData = UserDataViewModel()
    
    static var previews: some View {
        NavigationView {
            BirthDateScene()
                .environmentObject(Self.navContext)
                .environmentObject(Self.userData)
        }
    }
}
