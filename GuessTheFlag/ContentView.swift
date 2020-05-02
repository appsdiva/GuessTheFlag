//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Stacey Smith on 4/30/20.
//  Copyright © 2020 AppsDevo. All rights reserved.
//

import SwiftUI 



struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var playerScore = 0
    @State private var selectedNumber = 0
    
    @State private var showingScore = false
    @State private var correctFlag = false
    @State private var wrongFlag = false
    
    
    var body: some View {
        ZStack {
           
            LinearGradient(gradient: Gradient(colors: [.yellow, .orange,.red]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 30) {
                VStack {
                Text("Tap the flag of")
                    .foregroundColor(.white)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                Text(countries[correctAnswer])
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                }
                
           ForEach(0 ..< 3) { number in
                Button(action: {
                    self.flagTapped(number)
                }) {
                    Image(self.countries[number])
                        .renderingMode(.original)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        .shadow(color: .black, radius: 8)
                }
            }
               
                VStack {
                Text("Current Score:")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    
                    Text("\(playerScore)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                }
               
        }
    }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
        })
    }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreMessage = "It is the flag of \(countries[correctAnswer])!"
            playerScore += 1
            correctFlag = true
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That's The flag of \(countries[number])!"
            playerScore -= 1
            wrongFlag = true
        }

        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        wrongFlag = false
        correctFlag = false
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
