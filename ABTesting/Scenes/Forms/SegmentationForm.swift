//
//  SegmentationForm.swift
//  ABTesting
//
//  Created by Morisson Marcel on 10/02/22.
//

import SwiftUI

struct SegmentationForm: View {
    @EnvironmentObject var analyticsData: AnalyticsDataViewModel
    
    func decideNextScene() -> some View {
        let simplifiedSteps = ABTestingCases.casesStates[.onboardingWithSimplifiedSteps] ?? false
        
        return Group {
            if simplifiedSteps {
                Navigator.scene(to: .simplifiedScene)
            } else {
                Navigator.scene(to: .cpfScene)
            }
        }
    }
    
    var body: some View {
        OnboardingView(title: "um pouco sobre você?") {
            Spacer()
            
            Text("Pode nos contar um pouco mais de você?")
                .font(.title2)
                .foregroundColor(ITIColor.itiPink.color)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            VStack(alignment: .leading, spacing: 24.0) {
                HStack {
                    Text("qual sua faixa etaria?")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Picker(selection: $analyticsData.selectedAgeRangeIndex) {
                        ForEach(analyticsData.allAgeRanges.indices) { i in
                            Text(analyticsData.allAgeRanges[i].rawValue)
                        }
                    } label: {
                        Text("Selecione Faixa Etária")
                    }
                    .frame(minWidth: 120.0)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 6.0)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.secondary)
                    )
                }
                
                HStack {
                    Text("em que região você nasceu?")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Picker(selection: $analyticsData.selectedBornRegionIndex) {
                        ForEach(analyticsData.allBornRegions.indices) { i in
                            Text(analyticsData.allBornRegions[i].rawValue)
                        }
                    } label: {
                        Text("Selecione a região")
                    }
                    .frame(minWidth: 120.0)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 6.0)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.secondary)
                    )
                }
                
                HStack {
                    Text("qual sua etnia?")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Picker(selection: $analyticsData.selectedRaceIndex) {
                        ForEach(analyticsData.allRaces.indices) { i in
                            Text(analyticsData.allRaces[i].rawValue)
                        }
                    } label: {
                        Text("Selecione sua etnia")
                    }
                    .frame(minWidth: 120.0)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 6.0)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.secondary)
                    )
                }
            }
            .padding()

            Spacer()
            
            HStack {
                Button { } label: {
                    NavigationLink(destination: decideNextScene()) {
                        Text("Ignorar")
                    }
                }
                .onboardingButton(foregroundColor: Color.primary, backgroundColor: Color.clear)
                
                Button { } label: {
                    NavigationLink(destination: decideNextScene()) {
                        Text("Enviar")
                    }.simultaneousGesture(
                        TapGesture().onEnded {
                            analyticsData.setAnswerSegmentationForm()
                        }
                    )
                }
                .onboardingButton(disabled: (analyticsData.selectedAgeRange == nil || analyticsData.selectedAgeRange == .noSelection) || (analyticsData.selectedBornRegion == nil || analyticsData.selectedBornRegion == .noSelection) || (analyticsData.selectedRace == nil || analyticsData.selectedRace == .noSelection))
                
            }
        }
    }
}

struct SegmentationForm_Previews: PreviewProvider {
    @StateObject static var analyticsData = AnalyticsDataViewModel(dummy: true)
    
    static var previews: some View {
        NavigationView {
            SegmentationForm()
                .environmentObject(analyticsData)
        }
    }
}
