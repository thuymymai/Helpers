//
//  AvailableTasksView.swift
//  Helper
//
//  Created by Annie Huynh on 5.4.2022.
//

import SwiftUI

struct AvailableTasksView: View {
    
    var body: some View {
        GeometryReader{geometry in
            ZStack{
                Color("Background")
                    .edgesIgnoringSafeArea(.top)
                TaskCard()
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.25)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
            }
            
        }
    }
}


struct AvailableTasksView_Previews: PreviewProvider {
    static var previews: some View {
        AvailableTasksView()
    }
}

struct TaskCard: View {
    @State var showAlert: Bool = false
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Dog Walking")
                    .font(.headline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                Spacer()
                Text("Time")
                    .font(.headline)
                    .foregroundColor(Color("Primary"))
                    .fontWeight(.semibold)
            }.padding(.horizontal,15)
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("John Doe")
                        .font(.subheadline)
                        .fontWeight(.regular)
                    
                    HStack {
                        Label("Time", systemImage: "clock")
                            .foregroundColor(.secondary)
                        Text("|")
                            .foregroundColor(.secondary)
                        Label("Location", systemImage: "mappin")
                            .foregroundColor(.secondary)
                    }
                    Label("Disability: wheelchair", systemImage: "figure.roll")
                        .foregroundColor(.primary)
                }
                .layoutPriority(100)
                Spacer()
                Button(action: {
                    showAlert.toggle()
                })
                {
                    Text("Accept Task")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 100, height: 30)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                }
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Accept Task"), message: Text("Confirm accepting this task"), primaryButton: .default(Text("OK"), action: {
                        print("Confirmed")
                    }), secondaryButton: .cancel())
                })
            }
            .padding(.horizontal)
        }
    }
}

