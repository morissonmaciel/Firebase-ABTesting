//
//  ABTestingCases.swift
//  ABTesting
//
//  Created by Morisson Marcel on 03/02/22.
//

import Foundation
import FirebaseRemoteConfig

enum ABTestingCases: String, CaseIterable {
    case onboardingWithSimplifiedSteps
    case leavingFormEnabled
    case showSegmentationForm
    
    private(set) static var configured = false
    
    static var casesStates: [ABTestingCases: Bool] = [
        .onboardingWithSimplifiedSteps: false,
        .leavingFormEnabled : false,
        .showSegmentationForm : false
    ]
}

extension ABTestingCases {
    
    private static func loadDefaultValues() {
        let defaults = [ABTestingCases.onboardingWithSimplifiedSteps.rawValue : "",
                        ABTestingCases.leavingFormEnabled.rawValue: "",
                        ABTestingCases.showSegmentationForm.rawValue : ""]
        
        RemoteConfig.remoteConfig().setDefaults(defaults as [String: NSObject])
    }
    
    private static func configDebugMode() {
        let settings = RemoteConfigSettings()
        
#if DEBUG
        settings.minimumFetchInterval = 0
#endif
        
        RemoteConfig.remoteConfig().configSettings = settings
    }
    
    static func configure(_ completition: @escaping () -> Void) {
        guard !Self.configured else {
            completition()
            return
        }
        
        Self.loadDefaultValues()
        Self.configDebugMode()
        
        RemoteConfig.remoteConfig().fetch { _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            RemoteConfig.remoteConfig().activate { _, _ in
                for caseState in ABTestingCases.allCases {
                    ABTestingCases.casesStates[caseState] = RemoteConfig.remoteConfig()[caseState.rawValue].boolValue
                }
                
                Self.configured = true
                completition()
            }
        }
    }
}
