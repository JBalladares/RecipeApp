//
//  CameraScanView.swift
//  Recipes
//
//  Created by Jaime Balladares on 4/5/25.
//

import SwiftUI

struct CameraScanView: View {
    var body: some View {
        //Future feature to incorporate.
        
        ZStack{
            Color.black.ignoresSafeArea(edges: .all)
            //Glass Card
            ZStack {
                //Card
                RoundedRectangle(cornerRadius: 25)
                
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Scan Your Fridge!")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .fontWeight(.regular)
                                .padding(.top, 2)
                        }
                        
                        //Message
                        Text("Feature coming soon! Using your phone's camera we can help you idenify what food items you have and recommend recipes! Stay tuned 🙂")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                        
                    }.padding(.all)
                }
            }
            .opacity(0.75)
            .background(.thinMaterial)
            .frame(width: 375, height: 175)
            .cornerRadius(25)
        }
    }
}

#Preview {
    CameraScanView()
}
