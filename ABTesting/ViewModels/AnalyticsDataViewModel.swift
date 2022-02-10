//
//  AnalyticsDataViewModel.swift
//  ABTesting
//
//  Created by Morisson Marcel on 09/02/22.
//

import Combine
import FirebaseAnalytics

class AnalyticsDataViewModel: ObservableObject {
    
    enum AgeRange: String, CaseIterable {
        case noSelection = "Sem informação"
        case youth = "18 a 28 anos"
        case mature = "29 anos a 40 anos"
        case senior = "41 a 80 anos"
    }
    
    enum BornRegion: String, CaseIterable {
        case noSelection = "Sem informação"
        case ne = "Nordeste"
        case se = "Sudeste"
        case co = "Centro-Oeste"
        case n = "Norte"
        case s = "Sul"
    }
    
    enum Race: String, CaseIterable {
        case noSelection = "Sem informação"
        case white = "Branca"
        case brown = "Parda"
        case black = "Negra"
        case yellow = "Amarela"
    }
    
    enum LeavingReason: String, CaseIterable {
        case noSelection = "Sem motivo"
        case extensiveSteps = "Muitos passos"
        case dontHaveDocuments = "Não tinha meus documentos"
    }

    @Published private(set) var allAgeRanges: [AgeRange]
    @Published var selectedAgeRange: AgeRange?
    @Published var selectedAgeRangeIndex = 0 {
        didSet {
            selectedAgeRange = allAgeRanges[selectedAgeRangeIndex]
        }
    }
    
    @Published private(set) var allBornRegions: [BornRegion]
    @Published var selectedBornRegion: BornRegion?
    @Published var selectedBornRegionIndex = 0 {
        didSet {
            selectedBornRegion = allBornRegions[selectedBornRegionIndex]
        }
    }
    
    @Published private(set) var allRaces: [Race]
    @Published var selectedRace: Race?
    @Published var selectedRaceIndex = 0 {
        didSet {
            selectedRace = allRaces[selectedRaceIndex]
        }
    }
    
    @Published private(set) var allLeavingReasons: [LeavingReason]
    @Published var selectedReason: LeavingReason?
    @Published var selectedReasonIndex = 0 {
        didSet {
            selectedReason = allLeavingReasons[selectedReasonIndex]
        }
    }
    
    var dummy = false
    
    init(dummy: Bool = false) {
        self.dummy = dummy
        self.allAgeRanges = AgeRange.allCases
        self.allBornRegions = BornRegion.allCases
        self.allRaces = Race.allCases
        self.allLeavingReasons = LeavingReason.allCases
    }
    
    func setConversion() {
        if !dummy {
            Analytics.logEvent("onboardingConversions", parameters: nil)
        }
    }
    
    func enableLeavingExperiment() {
        if !dummy {
            Analytics.logEvent("leavingOnboarding", parameters: nil)
        }
    }

    func setAnswerLeavingForm() {
        guard !dummy, let leavingReason = selectedReason else {
            return
        }
        
        Analytics.logEvent("answeredLeaveOnboardingForm", parameters: ["leavingReason" : leavingReason.rawValue])
    }
    
    func setAnswerSegmentationForm() {
        guard !dummy, let ageRange = selectedAgeRange, let bornRegion = selectedBornRegion, let race = selectedRace else {
            return
        }
        
        Analytics.logEvent("answeredSegmentationData",
                           parameters: ["age" : ageRange.rawValue,
                                        "region": bornRegion.rawValue,
                                        "race" : race.rawValue ])
    }
}
