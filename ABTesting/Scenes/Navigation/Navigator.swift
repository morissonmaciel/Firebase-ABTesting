//
//  Navigator.swift
//  ABTesting
//
//  Created by Morisson Marcel on 09/02/22.
//

import SwiftUI

enum Route {
    case rootScene
    case cpfScene
    case emailScene
    case birthDateScene
    case endOnboardingScene
    case simplifiedScene
    
    // FORMS
    case leavingOnboardingForm
}

struct Navigator {
    class Context: ObservableObject {
        @Published var showingRootScene = false
    }

    static func scene(to route: Route) -> some View {
        Group {
            switch route {
            case .rootScene:
                RootScene()
            case .cpfScene:
                CPFScene()
            case .emailScene:
                EmailScene()
            case .birthDateScene:
                BirthDateScene()
            case .endOnboardingScene:
                EndOnboardingScene()
            case .simplifiedScene:
                SimplifiedScene()
            case .leavingOnboardingForm:
                LeavingOnboardForm()
            }
        }
    }
}
