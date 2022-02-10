//
//  CPFScene.swift
//  ABTesting
//
//  Created by Morisson Marcel on 09/02/22.
//

import SwiftUI

struct CPFScene: View {
    @EnvironmentObject var userData: UserDataViewModel
    var mask = Mask(maskFormat: "###.###.###-##")
    
    var body: some View {
        OnboardingView(title: "seus dados") {
            VStack(alignment: .leading) {
                Text("Qual o número do CPF?")
                TextField("000.000.000-00",
                          text: Binding<String>(
                            get: { userData.cpf },
                            set: { value in userData.cpf = mask.formateValue(value) }
                          ))
                    .onboardingField(keyboard: .numberPad)
            }
            
            Spacer()
            
            Button(action: {}) {
                NavigationLink(destination: Navigator.scene(to: .emailScene)) {
                    Text("Continuar")
                }
            }
            .onboardingButton(flex: true, disabled: userData.cpf.isEmpty)
        }
    }
}

struct CPFScene_Previews: PreviewProvider {
    @StateObject static var navContext = Navigator.Context()
    @StateObject static var userData = UserDataViewModel()
    
    static var previews: some View {
        NavigationView {
            CPFScene()
                .environmentObject(Self.navContext)
                .environmentObject(Self.userData)
        }
    }
}
