//
//  NewGameView.swift
//  Milestone2
//
//  Created by admin on 13.08.2022.
//

import SwiftUI

struct NewGameView: View {
    
    @ObservedObject var data: Data
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            
            Color(red: 232/255, green: 221/255, blue: 181/255)
                .ignoresSafeArea()
            VStack {
                
                Text("\(data.firstNumber) × \(data.secondNumber)")
                    .padding(40)
                    .frame(width: UIScreen.main.bounds.width, height: 100)
                    .background(data.colorDark)
                    .foregroundColor(data.colorYellow)
                    .shadow(radius: 3, x: -3,y: 2)
                    .padding()
                
                Spacer()
                
                ForEach(0..<4) { button in
                    
                    let possibleAnswer = data.firstNumber * data.arrayOfNumbers[button]
                    Button("\(possibleAnswer)") {
                        if data.totalScore == data.amountOfLevels - 1 {
                            if data.checkAnswer(numOne: data.correctAnswer, numTwo: possibleAnswer) {
                                data.totalScore += 1
                                data.correctAnswersScore += 1
                                data.scoreToShow = data.correctAnswersScore
                            } else {
                                data.totalScore += 1
                            }
                            presentationMode.wrappedValue.dismiss()
                            data.showScoreView.toggle()
                        } else {
                            if data.checkAnswer(numOne: data.correctAnswer, numTwo: possibleAnswer) {
                                data.totalScore += 1
                                data.correctAnswersScore += 1
                            } else {
                                data.totalScore += 1
                            }
                            data.setUpGame()
                        }
                    }
                    .frame(width: 350, height: 100, alignment: .center)
                    .background(data.colorGray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 3, x: -3,y: 2)
                    .foregroundColor(data.colorYellow)
                    .sheet(isPresented: $data.showScoreView) {
                        ScoreView(data: data)
                    }
                }
                Spacer()
            }
            .font(.largeTitle.weight(.semibold))
        }
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView(data: Data())
    }
}
