//
//  OnboardingView.swift
//  ABTesting
//
//  Created by Morisson Marcel on 09/02/22.
//

import SwiftUI

struct OnboardingView<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationContext: Navigator.Context
    
    @State var presentingModal = false
    @State var modalOpacity: CGFloat = 0.0
    @State var modalOffset: CGFloat = 400.0
    
    var title: String
    var contens: Content
    
    init(title: String, @ViewBuilder contents: () -> Content) {
        self.title = title
        self.contens = contents()
    }
    
    var modalBackground: some View {
        Group {
            if presentingModal {
                VStack{
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.25))
                .edgesIgnoringSafeArea(.all)
                .opacity(modalOpacity)
                .onAppear {
                    withAnimation {
                        modalOpacity = 1.0
                    }
                }
                .onTapGesture {
                    presentingModal = false
                }
            }
        }
    }
    
    var modalAlert: some View {
        Group {
            if presentingModal {
                VStack{
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Deseja realmente sair?")
                            .font(.headline)
                        
                        Text("Você pode continuar o cadastro posteriormente se quiser.")
                            .font(.subheadline)
                        
                        HStack {
                            Button {
                                presentingModal = false
                            } label: {
                                Text("Cancelar")
                            }
                            .onboardingButton(foregroundColor: Color.primary, backgroundColor: Color.secondary.opacity(0.15))
                                                        
                            Button {
                                navigationContext.showingRootScene = false
                            } label: {
                                Group {
                                    if ABTestingCases.casesStates[.leavingFormEnabled] ?? false {
                                        NavigationLink(destination: Navigator.scene(to: .leavingOnboardingForm)) {
                                            Text("Sair")
                                        }
                                    } else {
                                        Text("Sair")
                                    }
                                }
                            }
                            .onboardingButton()
                        }
                    }
                    .padding()
                    .padding(.bottom, 32.0)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBackground))
                    .cornerRadius(8.0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .offset(y: modalOffset)
                .onAppear {
                    withAnimation {
                        modalOffset = 0.0
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            contens
        }
        .navigationBarTitle(title, displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: (
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.backward")
                    .imageScale(.large)
            }.buttonStyle(.plain)
        ))
        .navigationBarItems(trailing: (
            Button(action: {
                modalOpacity = 0.0
                modalOffset = 400.0
                presentingModal = true
            }) {
                Image(systemName: "xmark")
                    .imageScale(.large)
            }.buttonStyle(.plain)
        ))
        .padding()
        .overlay((
            ZStack {
                modalBackground
                modalAlert
            }
        ))
    }
}

struct OnboardingView_Previews: PreviewProvider {
    @StateObject static var navContext = Navigator.Context()
    
    static var previews: some View {
        NavigationView {
            OnboardingView(title: "seus dados") {
                VStack(alignment: .leading) {
                    Text("Qual sua data de nascimento?")
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Continuar")
                }
                .onboardingButton(flex: true)
            }
        }
        .environmentObject(Self.navContext)
    }
}
