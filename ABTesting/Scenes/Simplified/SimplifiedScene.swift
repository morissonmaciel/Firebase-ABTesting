//
//  SimplifiedScene.swift
//  ABTesting
//
//  Created by Morisson Marcel on 09/02/22.
//

import SwiftUI

struct SimplifiedScene: View {
    @EnvironmentObject var userData: UserDataViewModel
    var cpfMask = Mask(maskFormat: "###.###.###-##")
    var birthMask = Mask(maskFormat: "##/##/####")
    
    var body: some View {
        OnboardingView(title: "dados pessoais") {
            VStack(spacing: 24.0) {
                VStack(alignment: .leading) {
                    Text("qual seu CPF?")
                    TextField("000.000.000-00",
                              text: Binding<String>(
                                get: { userData.cpf },
                                set: { value in userData.cpf = cpfMask.formateValue(value) }
                              ))
                        .onboardingField(keyboard: .numberPad)
                }
                
                VStack(alignment: .leading) {
                    Text("qual seu email?")
                    TextField("seu@email.com", text: $userData.email)
                        .onboardingField(keyboard: .emailAddress)
                }
                
                VStack(alignment: .leading) {
                    Text("quando você nasceu?")
                    TextField("00/00/0000",
                              text: Binding<String>(
                                get: { userData.birthDate },
                                set: { value in userData.birthDate = birthMask.formateValue(value) }
                              ))
                        .onboardingField(keyboard: .numberPad)
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                NavigationLink(destination: Navigator.scene(to: .endOnboardingScene)) {
                    Text("Concluir")
                }
            }
            .onboardingButton(flex: true, disabled: userData.cpf.isEmpty || userData.email.isEmpty || userData.birthDate.isEmpty)
        }
    }
}

struct SimplifiedScene_Previews: PreviewProvider {
    @StateObject static var navContext = Navigator.Context()
    @StateObject static var userData = UserDataViewModel()
    
    static var previews: some View {
        NavigationView {
            SimplifiedScene()
                .environmentObject(navContext)
                .environmentObject(userData)
        }
    }
}
