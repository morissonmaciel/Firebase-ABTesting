//
//  EndOnboardingScene.swift
//  ABTesting
//
//  Created by Morisson Marcel on 09/02/22.
//

import SwiftUI

struct EndOnboardingScene: View {
    @EnvironmentObject var analyticsData: AnalyticsDataViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text("Obrigado 🎉")
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Text("E seja bem vindo ao nosso app. Agora só começar a poupar!")
                .font(.title2)
                .foregroundColor(.white)
            
            Text(";)")
                .font(.title)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .navigationBarHidden(true)
        .background((
            Image("Splash")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        ))
        .onAppear {
            analyticsData.setConversion()
        }
    }
}

struct EndOnboardingScene_Previews: PreviewProvider {
    @StateObject static var analyticsData = AnalyticsDataViewModel(dummy: true)
    
    static var previews: some View {
        NavigationView {
            EndOnboardingScene()
                .environmentObject(analyticsData)
        }
    }
}
