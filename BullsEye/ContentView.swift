//
//  ContentView.swift
//  BullsEye
//
//  Created by Pankaj kumar on 16/04/20.
//  Copyright © 2020 Pankaj kumar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    
    var body: some View {
      VStack {
        Spacer()
        
        // Target row
        HStack {
          Text("Put the bullseye as close as you can to:")
          Text(/*@START_MENU_TOKEN@*/"100"/*@END_MENU_TOKEN@*/)
        }
        Spacer()
        
        // Slider row
        HStack {
          Text("1")
          Slider(value: self.$sliderValue, in: 1...100)
          Text("100")
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        Spacer()
        
        // Button row
        Button(action: {
          print("Button pressed!")
          self.alertIsVisible = true
        }) {
          Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/)
        }
        .alert(isPresented: $alertIsVisible) { () -> Alert in
          let roundedValue: Int = Int(self.sliderValue.rounded())
          return Alert(title: Text("Hello there!"), message: Text("The slider's value is \(roundedValue)."), dismissButton: .default(Text("Awesome!")))
        }
        Spacer()
        
        // Score row
        HStack {
          Button(action: {}) {
            Text("Start Over")
          }
          Spacer()
          Text("Score:")
          Text("999999")
          Spacer()
          Text("Round:")
          Text("999")
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width))
    }
}
