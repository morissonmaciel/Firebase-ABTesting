//
//  UserDataViewModel.swift
//  ABTesting
//
//  Created by Morisson Ferreira Maciel on 03/02/22.
//

import Combine
import SwiftUI

class UserDataViewModel: ObservableObject {
    @Published var cpf = ""
    @Published var name = ""
    @Published var email = ""
    @Published var birthDate = ""
}
