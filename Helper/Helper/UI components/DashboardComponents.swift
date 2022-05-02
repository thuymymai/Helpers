//
//  DashboardComponents.swift contains category items, image slideshow UI components
//  Helper
//
//
//  Created by Annie Huynh on 28.4.2022.
//

import SwiftUI

struct ImageSlideShow: View{
    
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    @State private var currentIndex = 0
    
    var body: some View{
        GeometryReader{ geometry in
            TabView(selection: $currentIndex){
                ForEach(0..<4){image in
                    Image("\(image)")
                        .resizable()
                        .scaledToFill()
                        .overlay(Color.black.opacity(0.06))
                        .tag(image)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onReceive(timer, perform: {_ in withAnimation{
                currentIndex = currentIndex < 4 ? currentIndex + 1 :0
                    }
                })
        }
    }
}

struct CategoriesView: View {
    
    var categoryName: String
    var numberOfTasks: String
    var ImageName: String
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(width: 110, height: 140)
                .shadow(radius: 5)
            VStack(alignment: .leading){
                Text(categoryName)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .padding(.top,25)
                Text(numberOfTasks)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                Image(ImageName)
                    .resizable()
                    .frame(width: 100, height: 75,alignment: .center)
                    .padding(.bottom,20)
            }
        }
    }
}

