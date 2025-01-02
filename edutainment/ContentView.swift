import SwiftUI

struct ContentView: View {
    @State private var selectedNum: Int = 1
    @State private var randomNum: Int = Int.random(in: 1...12)
    @State private var answer: Int? = nil
    @State private var numberOfQuestions = 1
    @State private var currentQuestion = 1
    @State private var NumberOfCorrectAnswers = 0
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("Multiplication Table Test")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .cornerRadius(15)
                
            Spacer()
            Stepper("Test number \t \(selectedNum)", value: $selectedNum, in: 1...12)
                .fontWeight(.semibold)
            Stepper("Number of questions \t \(numberOfQuestions)", value: $numberOfQuestions, in: 1...12)
                .fontWeight(.semibold)
            Spacer()
            MultiplicationView(selectedNum: selectedNum, randomNum: randomNum)
            Spacer()
            TextField("Your answer", value: $answer, format: .number)
                .padding(15)
                .frame(maxWidth: .infinity, maxHeight: 50)  // Use maxWidth: .infinity to expand the width
                .background(.ultraThinMaterial)
                .cornerRadius(15)  // Apply rounded corners here
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Spacer()
            Spacer()
        }
        
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        
        .background(Gradient(colors: [.red, .orange]))  // Background for VStack container
        .ignoresSafeArea()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Game Over"),
                message: Text("You got \(NumberOfCorrectAnswers) out of \(numberOfQuestions)"),
                primaryButton: .default(Text("Restart")) {
                    resetGame()
                },
                secondaryButton: .cancel()
            )
            
        }
        
        .onSubmit {
            checkAnswer()
            if numberOfQuestions == currentQuestion {
                showAlert = true
            }
            withAnimation(.easeIn) {
                NextQuestion()
                answer = nil
            }
        }
    }
    
    func NextQuestion() {
        currentQuestion += 1
        randomNum = Int.random(in: 1...12)
    }
    
    func resetGame() {
        NumberOfCorrectAnswers = 0
        currentQuestion = 0
    }
    
    func checkAnswer() {
        let solution = selectedNum * randomNum
        if solution == answer {
            NumberOfCorrectAnswers += 1
        }
        print(NumberOfCorrectAnswers)
        print(numberOfQuestions)
        print(currentQuestion)
    }
}

#Preview {
    ContentView()
}

struct MultiplicationView: View {
    var selectedNum :Int
    var randomNum : Int
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("\(selectedNum)")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .frame(width: 120, height: 100)
            .background(Gradient(colors: [.red, .orange]))
            .cornerRadius(25)  // Use .cornerRadius instead of clipShape for rounded corners
            Spacer()
            Text("X")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            VStack {
                Text("\(randomNum)")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .frame(width: 120, height: 100)
            .background(Gradient(colors: [.red, .orange]))
            .cornerRadius(25)  // Same here for consistency
            Spacer()
        }
    }
}
