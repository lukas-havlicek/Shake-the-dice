//
//  SheetView.swift
//  ShakeGesture
//
//  Created by Lukas Havlicek on 16/05/2020.
//  Copyright © 2020 Lukas Havlicek. All rights reserved.
//

import SwiftUI

struct SheetView: View {
  @Environment(\.presentationMode) var presentationMode
  @Binding var numberOfDices: Int
  @Binding var rolledIt: Bool
  @Binding var spacerLength: CGFloat
  @ObservedObject var userSettings = UserSettings()
  
  var body: some View {
    VStack(spacing: 20) {
      Button(action: {
        self.numberOfDices = 1
        self.rolledIt = false
        self.spacerLength = 150
        self.presentationMode.wrappedValue.dismiss()
      }) {
        DiceView()
          .modifier(SheetButton())
      }
      .padding(.top, 100)
      Button(action: {
        self.numberOfDices = 2
        self.rolledIt = false
        self.spacerLength = 150
        self.presentationMode.wrappedValue.dismiss()
      }) {
        HStack {
          DiceView()
          DiceView()
        }.modifier(SheetButton())
      }
      Button(action: {
        self.numberOfDices = 3
        self.rolledIt = false
        self.spacerLength = 100
        self.presentationMode.wrappedValue.dismiss()
      }) {
        HStack {
          DiceView()
          DiceView()
          DiceView()
        }.modifier(SheetButton())
      }
      Button(action: {
        self.numberOfDices = 4
        self.rolledIt = false
        self.spacerLength = 100
        self.presentationMode.wrappedValue.dismiss()
      }) {
        HStack {
          DiceView()
          DiceView()
          DiceView()
          DiceView()
        }.modifier(SheetButton())
      }
      Spacer()
      Toggle(isOn: $userSettings.isInitial) {
        Text("Skip initial animation")
          .fontWeight(.light)
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 30)
    }
  }
}

struct SheetView_Previews: PreviewProvider {
  @State static var numerOdDices = 1
  @State static var rolledIt = false
  @State static var spacerLength: CGFloat = 150
  static var previews: some View {
    SheetView(numberOfDices: $numerOdDices, rolledIt: $rolledIt, spacerLength: $spacerLength)
  }
}
struct DiceView: View {
  var body: some View {
    Image("6")
      .renderingMode(.original)
      .resizable()
      .frame(width: 50, height: 50)
      .scaledToFit()
  }
}
