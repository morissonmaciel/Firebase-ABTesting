//
//  LeavingOnboardForm.swift
//  ABTesting
//
//  Created by Morisson Marcel on 09/02/22.
//

import SwiftUI

struct LeavingOnboardForm: View {
    @EnvironmentObject var navigationContext: Navigator.Context
    @EnvironmentObject var analyticsData: AnalyticsDataViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Spacer()
            
            Text("🥺")
                .font(.largeTitle)
                .foregroundColor(ITIColor.itiPink.color)
            
            Text("Antes de sair, poderia nos contar o motivo da sua desistência?")
                .font(.title2)
                .foregroundColor(ITIColor.itiPink.color)
            
            Picker(selection: $analyticsData.selectedReasonIndex) {
                ForEach(analyticsData.allLeavingReasons.indices) { i in
                    Text(analyticsData.allLeavingReasons[i].rawValue).tag(i)
                }
            } label: {
                Text("Selecione um motivo: ")
            }
            .pickerStyle(WheelPickerStyle())

            Spacer()
            
            HStack {
                Button {
                    navigationContext.showingRootScene = false
                } label: {
                    Text("Ignorar")
                }
                .onboardingButton(foregroundColor: Color.primary, backgroundColor: Color.clear)
                
                Button {
                    analyticsData.setAnswerLeavingForm()
                    navigationContext.showingRootScene = false
                } label: {
                    Text("Enviar")
                }
                .onboardingButton(disabled: analyticsData.selectedReason == nil || analyticsData.selectedReason == .noSelection)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .navigationBarHidden(true)
        .onAppear {
            analyticsData.enableLeavingExperiment()
        }
    }
}

struct LeavingOnboardForm_Previews: PreviewProvider {
    @StateObject static var analyticsData = AnalyticsDataViewModel(dummy: true)
    @StateObject static var navContext = Navigator.Context()
    
    static var previews: some View {
        NavigationView {
            LeavingOnboardForm()
                .environmentObject(Self.navContext)
                .environmentObject(Self.analyticsData)
        }
    }
}
