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
    private let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            // Target row
            HStack {
                Text("Put the BullsEye as close as you can to: ").modifier(LabelStyle())
                Text("\(targetValue)").modifier(ValueStyle())
            }
            Spacer()
            
            // Slider row
            HStack {
                Text("1").modifier(ValueStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(ValueStyle())
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            Spacer()
            
            // Button row
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
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
            .background(Image("Button")).modifier(Shadow())
            Spacer()
            
            // Score row
            HStack {
                Button(action: {
                    self.resetProgress()
                }) {
                    Image("StartOverIcon")
                    Text("Start Over").modifier(ButtonSmallTextStyle())
                }
                .background(Image("Button")).modifier(Shadow())
                Spacer()
                
                Text("Score:").modifier(LabelStyle())
                Text("\(totalScore)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(roundNumber)").modifier(ValueStyle())
                Spacer()
                Button(action: {}) {
                    Image("InfoIcon")
                    Text("Info").modifier(ButtonSmallTextStyle())
                }
                .background(Image("Button")).modifier(Shadow())
            }
            .padding(.bottom, 20)
            .padding(.leading, 20)
            .padding(.trailing, 40)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
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
