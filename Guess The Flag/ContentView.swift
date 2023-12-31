//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Sean Walker on 7/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var questionsAnswered = 0
    @State private var lastAnswer = 0
    @State private var gameOver = false
    @State private var spinAmount = 0.0
    @State private var fadeButtons = false
    
    struct FlagImage: View {
        var country: String
        
        var body: some View {
            Image(country)
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops:[
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of").foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) {number in
                        Button {
                            lastAnswer = number
                            fadeButtons = true
                                withAnimation {
                                    spinAmount += 360
                                }
                            questionsAnswered += 1
                            flagTapped()
                        } label: {
                            FlagImage(country: countries[number])
                        }
                        .opacity(fadeButtons && (lastAnswer != number) ? 0.25 : 1)
                        .scaleEffect(fadeButtons && (lastAnswer != number) ? 0.9 : 1)
                        .animation(.default, value: fadeButtons)
                        .rotation3DEffect(.degrees(lastAnswer == number ? spinAmount : 0), axis: (x: 1, y: 0, z: 0))
                    }
                    
                }
                
                .frame(maxWidth: .infinity )
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)/\(questionsAnswered)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if (lastAnswer != correctAnswer) {
                Text("That is the flag of \(countries[lastAnswer])")
            }
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("New Game", action: reset)
        } message: {
            Text("You scored \(score)/8")
        }
    }
    
    func flagTapped() {
        if lastAnswer == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        if (questionsAnswered == 8) {
            gameOver = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        
            
        countries.shuffle()
        fadeButtons = false
        
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        score = 0
        questionsAnswered = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
