//
//  ScoreView.swift
//  Milestone2
//
//  Created by admin on 14.08.2022.
//

import SwiftUI

struct ScoreView: View {
    @ObservedObject var data: Data
    @State private var progress = 0.0
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(red: 51/255, green: 51/255, blue: 51/255)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                RingProgressView(data: data, progress: $progress)
                    .frame(width: 200, height: 200)
                    .padding()
                
                Spacer()
                
                Button("New game") {
                    data.showGameView = false
                    data.resetGame()
                    presentationMode.wrappedValue.dismiss()
                    print("correct \(data.correctAnswersScore)")
                    print("correct \(data.totalScore)")
                    
                }
                .padding(40)
                .background(data.colorPink)
                .foregroundColor(data.colorGray)
                .cornerRadius(20)
                .padding()
                .padding(.bottom)
            }
        }
    }
    func setProgress() {
        let persentage = Double(data.correctAnswersScore) / Double(data.amountOfLevels)
        withAnimation(.easeInOut(duration: 2)) {
            progress = persentage
        }
    }
    
}

struct RingProgressView: View {
    @ObservedObject var data: Data
    @Binding var progress: Double
    @State private var color = Color.teal
    
    var body: some View {
        ZStack{
            HStack{
                Text("\(data.scoreToShow)")
                    .font(.system(size: 90).weight(.semibold))
                withAnimation{
                    Text("|\(data.amountOfLevels)")
                        .font(.system(size: 50).weight(.semibold))
                        .opacity(0.5)
                }
            }
            .offset(x: 25)
            .foregroundColor(data.colorPink)
            .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/2)
            .background(data.colorGray)
            .clipShape(Circle())
            .padding(10)
            
            Circle()
                .stroke(lineWidth: 30)
                .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/2)
                .foregroundColor(data.colorYellow)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style:StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                .foregroundColor(data.colorPink)
                .rotationEffect(Angle.degrees(90))
                .animation(.easeInOut, value: progress)
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(data: Data())
    }
}
