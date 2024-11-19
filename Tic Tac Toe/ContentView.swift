import SwiftUI

struct ContentView: View {
    @State private var moves = Array(repeating: "", count: 9)
    @State private var xTurn = true
    @State private var gameOver = false
    @State private var winMessage = ""
    
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .font(.bold(.title)())
            
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(120)), count: 3)) {
                ForEach(0..<9) { index in
                    ZStack {
                        Color.blue
                        Color.white
                            .opacity(moves[index] == "" ? 1 : 0)
                        Text(moves[index])
                            .font(.system(size: 90))
                            .fontWeight(.heavy)
                    }
                    .frame(width: 120, height: 120)
                    .cornerRadius(30)
                    .onTapGesture {
                        if moves[index] == "" && !gameOver {
                            withAnimation {
                                moves[index] = xTurn ? "X" : "O"
                                xTurn.toggle()
                                checkForWin()
                            }
                        }
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
        .alert(isPresented: $gameOver) {
            Alert(title: Text(winMessage), dismissButton: .default(Text("Play Again")) {
                withAnimation {
                    moves = Array(repeating: "", count: 9)
                    xTurn = true
                    gameOver = false
                    winMessage = ""
                }
            })
        }
    }
    
    private func checkForWin() {
        checkLine(a: 0, b: 1, c: 2)
        checkLine(a: 3, b: 4, c: 5)
        checkLine(a: 6, b: 7, c: 8)
        checkLine(a: 0, b: 3, c: 6)
        checkLine(a: 1, b: 4, c: 7)
        checkLine(a: 2, b: 5, c: 8)
        checkLine(a: 0, b: 4, c: 8)
        checkLine(a: 2, b: 4, c: 6)
        
        if !gameOver && !moves.contains("") {
            winMessage = "Cat's Game!"
            gameOver = true
        }
    }
    
    private func checkLine(a: Int, b: Int, c: Int) {
        if moves[a] != "" && moves[a] == moves[b] && moves[b] == moves[c] {
            winMessage = "\(moves[a]) is the winner!"
            gameOver = true
        }
    }
}

#Preview {
    ContentView()
}
