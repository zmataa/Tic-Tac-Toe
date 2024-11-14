//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Zane Matarieh on 11/14/24.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = Array(repeating: "", count: 9)
    @State private var xTurn = true
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .font(.bold(.title)())
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(120)), count: 3), content: {
                ForEach(0..<9) { index in
                    ZStack {
                        Color.blue
                        Color.white
                            .opacity(moves[index] == "" ? 1 : 0)
                        Text(moves[index])
                            .font(.system(size: 90))
                            .fontWeight(.heavy)
                    }
                            .frame(width: 120, height: 120, alignment: .center)
                            .cornerRadius(30)
                            .onTapGesture {
                                withAnimation(.default){
                                    if(moves[index] == "")
                                    {
                                        moves[index] = xTurn ? "X" : "O"
                                        xTurn.toggle()
                                    }
                                }
                            }
                            .rotation3DEffect(.degrees(moves[index] == "" ? 180 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                }
            })
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
