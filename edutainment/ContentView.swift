//
//  ContentView.swift
//  edutainment
//
//  Created by Hadi Al zayer on 02/07/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedNum : Int = 1
    @State private var randomNum: Int = Int.random(in: 1...12)
    @State private var answer : Int? = nil
    @State private var numberOfQuestions = 1
    @State private var currentQuestion = 1
    @State private var NumberOfCorrectAnswers = 0
    @State private var showAlert = false
   
    var body: some View {
        
        VStack {
            Text("Multiplication table")
                .font(.title)
            Stepper("Multiplication table for \(selectedNum)",value: $selectedNum ,in: 1...12)
            Stepper("number of questions \(numberOfQuestions)",value: $numberOfQuestions ,in: 1...12)
            
            Text("\(selectedNum) * \(randomNum)")
            TextField(
                "Your answer", value: $answer, format: .number)
            .padding(10)
            .foregroundColor(.white)
            .background(.gray)
            
          
            
            
            Text("The selceted number of Qustion is \(numberOfQuestions) \n The current Question is \(currentQuestion)")
            
        }
        .padding()
        .alert(isPresented: $showAlert){
            Alert(
            title: Text("Game Over" ),
            message: Text("You got \(NumberOfCorrectAnswers) out of \(numberOfQuestions)"),
            primaryButton: .default(Text("restart")){
                resetGame()
            }, secondaryButton: .cancel()
           
            
            )
            
        }
        .onSubmit {
           checkAnswer()
            if(numberOfQuestions == currentQuestion){
                showAlert = true
            }
            withAnimation(.easeIn){
                NextQuestion()
                answer = nil
            }
        }
    }
    func NextQuestion(){
        currentQuestion += 1
        randomNum = Int.random(in: 1...12)
        
    }
    func resetGame(){
        NumberOfCorrectAnswers = 0
        currentQuestion = 0
    }
    func checkAnswer()  {
        
        let solution = selectedNum * randomNum
        
        if(solution == answer){
            NumberOfCorrectAnswers += 1
        }else{
            NumberOfCorrectAnswers += 0
        }
        print(NumberOfCorrectAnswers)
        print(numberOfQuestions)
        print(currentQuestion)
    }
    
}

#Preview {
    ContentView()
}
