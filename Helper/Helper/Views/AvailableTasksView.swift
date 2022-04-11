//
//  AvailableTasksView.swift
//  Helper
//
//  Created by Annie Huynh on 5.4.2022.
//

import SwiftUI

struct AvailableTasksView: View {
    
    var body: some View {
        VStack {
            
            TaskCard()
        }
        
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
                .shadow(radius: 5)
            
            
        )
        
        .padding([.top, .horizontal])
        
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
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    Text("Dog Walking")
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
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
            
            VStack(alignment: .center) {
                Text("Time")
                    .font(.headline)
                    .foregroundColor(Color("Primary"))
                    .fontWeight(.semibold)
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
        }
        .padding() 
    }
}

