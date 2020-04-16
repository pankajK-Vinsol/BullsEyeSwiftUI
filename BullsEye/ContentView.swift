//
//  ContentView.swift
//  BullsEye
//
//  Created by Pankaj kumar on 16/04/20.
//  Copyright © 2020 Pankaj kumar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var alertIsVisible = false
    @State private var sliderValue = 50.0
    @State private var targetValue = Int.random(in: 2...99)
    @State private var totalScore = 0
    @State private var roundNumber = 1
    
    var body: some View {
      VStack {
        Spacer()
        
        // Target row
        HStack {
          Text("Put the BullsEye as close as you can to: ")
          Text("\(targetValue)")
        }
        Spacer()
        
        // Slider row
        HStack {
          Text("1")
          Slider(value: $sliderValue, in: 1...100)
          Text("100")
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        Spacer()
        
        // Button row
        Button(action: {
            self.alertIsVisible = true
        }) {
          Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/)
        }
        .alert(isPresented: $alertIsVisible) { () -> Alert in
          return Alert(title: Text("\(alertTitle())"),
                       message: Text("The slider's value is: \(roundedPointsValue()).\n Your score for this round is: \(pointsForThisRound())"),
                       dismissButton: .default(Text("Awesome!")) {
                        self.totalScore = self.totalScore + self.pointsForThisRound()
                        self.roundNumber += 1
                        self.targetValue = Int.random(in: 2...99)
            })
        }
        Spacer()
        
        // Score row
        HStack {
          Button(action: {
            self.resetProgress()
          }) {
            Text("Start Over")
          }
          Spacer()
          Text("Score:")
          Text("\(totalScore)")
          Spacer()
          Text("Round:")
          Text("\(roundNumber)")
          Spacer()
          Button(action: {}) {
            Text("Info")
          }
        }
        .padding(.bottom, 20)
        .padding(.leading, 20)
        .padding(.trailing, 20)
      }
    }
    
    private func roundedPointsValue() -> Int {
        Int(sliderValue.rounded())
    }
    
    private func amountOff() -> Int {
      abs(targetValue - roundedPointsValue())
    }
    
    private func pointsForThisRound() -> Int {
        let maximumScore = 100
        let difference = amountOff()
        let bonus: Int
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        return maximumScore - difference + bonus
    }
    
    private func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    
    private func resetProgress() {
        totalScore = 0
        roundNumber = 1
        sliderValue = 50.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width))
    }
}
