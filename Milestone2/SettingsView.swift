//
//  SettingsView.swift
//  Milestone2
//
//  Created by admin on 13.08.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var data: Data
    
    var body: some View {
        
        ZStack {
            
            Color(red: 51/255, green: 51/255, blue: 51/255)
                .ignoresSafeArea()
            VStack {
                
                Spacer()
                
                HStack(alignment: .center, spacing: 20) {
                    
                    Text("Difficulty level:  \(data.difficultyLevel)")
                    Stepper("", value: $data.difficultyLevel.animation(.default), in: 1...5, step: 1)
                }
                .padding(20)
                .background(data.colorPink)
                .foregroundColor(data.colorDark)
                .cornerRadius(20)
                .padding()
                
                HStack(alignment: .center, spacing: 10) {
                    
                    Text("Amount of levels:  \(data.amountOfLevels)")
                    Stepper("", value: $data.amountOfLevels.animation(.easeInOut(duration: 0.2)), in: 1...20, step: data.amountOfLevels == 1 ? 4 : 5)
                }
                .padding(20)
                .background(data.colorPink)
                .foregroundColor(data.colorDark)
                .cornerRadius(20)
                .padding()
                
                Spacer()
                
                Button {
                    data.showSettingsView.toggle()
                    data.resetGame()
                } label: {
                    
                    Image(systemName:"house.fill")
                        .frame(width: 200,height: 70, alignment: .center)
                        .background(data.colorYellow)
                        .clipShape(Circle())
                        .font(.system(size: 25).weight(.semibold))
                        .foregroundColor(data.colorDark)
                        .padding(40)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(data: Data())
    }
}
