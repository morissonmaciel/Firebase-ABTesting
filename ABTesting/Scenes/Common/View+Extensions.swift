//
//  OnboardView+Extensions.swift
//  ABTesting
//
//  Created by Morisson Marcel on 09/02/22.
//

import SwiftUI

extension Button {
    func onboardingButton(foregroundColor: Color = .white, backgroundColor: Color = ITIColor.itiPink.color, flex: Bool = false, disabled: Bool = false) -> some View {
        self
            .buttonStyle(.plain)
            .padding()
            .padding(.horizontal, 32.0)
            .frame(maxWidth: flex ? .infinity : 400)
            .background(disabled ? Color.secondary.opacity(0.15) : backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(24.0)
            .disabled(disabled)
    }
}

extension TextField {
    func onboardingField(keyboard: UIKeyboardType = .default, autoCapitalization: UITextAutocapitalizationType = .none) -> some View {
        self
            .font(.title3)
            .keyboardType(keyboard)
            .autocapitalization(autoCapitalization)
            .disableAutocorrection(true)
            .padding(.vertical, 4.0)
            .background((
                VStack {
                    Spacer()
                    Divider()
                        .background(ITIColor.itiPink.color)
                }
            ))
    }
}

struct OnboardingView_PreviewProvider: PreviewProvider {
    @State static var navContext = Navigator.Context()
    @State static var cpf = ""
    
    static var previews: some View {
        VStack {
            Text("Bem-vindo")
            TextField("000.000.000-00", text: $cpf)
                .onboardingField()
            
            Spacer()
            
            Button(action: {}) {
                Text("Continuar")
            }
            .onboardingButton(flex: true, disabled: true)
        }
        .padding()
    }
}
