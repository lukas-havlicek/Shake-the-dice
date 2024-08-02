//
//  Helper.swift
//  ShakeGesture
//
//  Created by Lukas Havlicek on 17/05/2020.
//  Copyright © 2020 Lukas Havlicek. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
  static let clearance = Color("clearance")
  static let initBackground = Color("initial_background")
}

struct SheetButton: ViewModifier {
  func body(content: Content) -> some View {
    content
      .frame(width: 250)
      .padding(10)
      .background(Color.clear)
      .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.primary, lineWidth: 1))
  }
}

class UserSettings: ObservableObject {
  @Published var isInitial: Bool {
    didSet {
      UserDefaults.standard.set(isInitial, forKey: "isInitial")
    }
  }
  init() {
    self.isInitial = UserDefaults.standard.bool(forKey: "isInitial") //as? Bool ?? true
  }
}
