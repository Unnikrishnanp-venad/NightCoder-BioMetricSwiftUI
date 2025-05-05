//
//  OnboardingState.swift
//  MyFirstSwiftUI App
//
//  Created by Unnikrishnan P on 4/30/25.
//

import Foundation
import SwiftData

@Model
class OnboardingState {
    var viewed: Bool = false
    
    init(viewed: Bool) {
        self.viewed = viewed
    }
}
