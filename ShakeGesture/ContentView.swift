//
//  ContentView.swift
//  ShakeGesture
//
//  Created by Lukas Havlicek on 09/05/2020.
//  Copyright © 2020 Lukas Havlicek. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
  @State private var rolledIt = false
  @State private var numberOfDices: Int = 1
  @State private var showingSheetView = false
  @State private var spacerLength: CGFloat = 150
  @State private var initialOpacity: Double = 1
  @ObservedObject var userSettings = UserSettings()
  
  var body: some View {
    ZStack {
      ShakableViewRepresentable()
        .allowsHitTesting(false)
      VStack {
        HStack {
          Spacer()
          Button(action: {
            self.showingSheetView = true
          }) {
            Image(systemName: "square.grid.2x2")
              .font(.largeTitle)
              .foregroundColor(.primary)
              .padding(20)
          }
        }
        Spacer()
      }
      .sheet(isPresented: $showingSheetView) {
        SheetView(numberOfDices: self.$numberOfDices, rolledIt: self.$rolledIt, spacerLength: self.$spacerLength)
      }
      VStack {
        Spacer(minLength: spacerLength)
        if rolledIt {
          if numberOfDices == 1 {
            MovingDiceView()
          } else if numberOfDices == 2 {
            HStack {
              Spacer()
              MovingDiceView()
              HorizontalSpacer()
              MovingDice2View()
                .rotationEffect(Angle(degrees: 180))
              Spacer()
            }
          } else if numberOfDices == 3 {
            VStack {
              MovingDiceView()
              VerticalSpacer()
              HStack {
                Spacer()
                MovingDice2View()
                HorizontalSpacer()
                MovingDice3View()
                  .rotationEffect(Angle(degrees: 180))
                Spacer()
              }
            }
          } else if numberOfDices == 4 {
            VStack {
              HStack {
                Spacer()
                MovingDiceView()
                  .rotationEffect(Angle(degrees: 180))
                HorizontalSpacer()
                MovingDice2View()
                Spacer()
              }
              VerticalSpacer()
              HStack {
                Spacer()
                MovingDice3View()
                HorizontalSpacer()
                MovingDice4View()
                  .rotationEffect(Angle(degrees: 180))
                Spacer()
              }
            }
          }
        } else {
          if numberOfDices == 1 {
            UnknownView()
          } else if numberOfDices == 2 {
            HStack {
              Spacer()
              UnknownView()
              HorizontalSpacer()
              UnknownView()
              Spacer()
            }
          } else if numberOfDices == 3 {
            VStack {
              UnknownView()
              VerticalSpacer()
              HStack {
                Spacer()
                UnknownView()
                HorizontalSpacer()
                UnknownView()
                Spacer()
              }
            }
          } else if numberOfDices == 4 {
            VStack {
              HStack {
                Spacer()
                UnknownView()
                HorizontalSpacer()
                UnknownView()
                Spacer()
              }
              VerticalSpacer()
              HStack {
                Spacer()
                UnknownView()
                HorizontalSpacer()
                UnknownView()
                Spacer()
              }
            }
          }
        }
        Spacer()
        Text("Shake your phone for the roll")
          .font(.system(size: 22))
          .fontWeight(.light)
          .padding(.bottom, 40)
          .foregroundColor(.primary)
        Text("Clear the dice")
          .foregroundColor(.primary)
          .padding(20)
          .background(Color.clearance)
          .clipShape(RoundedRectangle(cornerRadius: 20))
          .clipped()
          .onTapGesture {
            self.rolledIt = false
          }
        .padding(.bottom, 70)
      }
      .onReceive(messagePublisher) { _ in
        self.rolledIt = true
      }
      if !userSettings.isInitial {
        InitialView()
          .opacity(initialOpacity)
          .onAppear {
            self.hide()
        }
      } else {
        InitialView().hidden()
      }
    }
  }
  func hide() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
      withAnimation(.linear(duration: 0.3)) {
        self.initialOpacity = 0
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
struct UnknownView: View {
  var body: some View {
    Image("unknown")
      .resizable()
      .frame(width: 100, height: 100)
      .scaledToFit()
  }
}
struct HorizontalSpacer: View {
  var body: some View {
    Rectangle()
      .foregroundColor(.clear)
      .frame(width: 10, height: 100)
  }
}
struct VerticalSpacer: View {
  var body: some View {
    Rectangle()
      .foregroundColor(.clear)
      .frame(width: 100, height: 10)
  }
}
