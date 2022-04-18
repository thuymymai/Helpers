//
//  AvailableTasksView.swift
//  Helper
//
//  Created by Annie Huynh on 5.4.2022.
//

import SwiftUI

struct TaskList: View {
    var body: some View {
        ZStack {
            Color("Primary").edgesIgnoringSafeArea(.all)
            VStack {
                Text("Your tasks")
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                TaskCard1()
                    .frame(width: 330)
                    .background()
                    .cornerRadius(10)
                    .shadow(radius: 10)
                TaskCard2()
                    .frame(width: 330)
                    .background()
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }.frame(maxHeight: .infinity, alignment: .leading)
        }
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList()
    }
}

struct TaskCard1: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Dog Walking")
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
                Text("Helper: John Doe")
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
            }
            .layoutPriority(100)
            Text("Pending")
                .frame(width: 80)
                .font(.headline)
                .padding(10)
                .background(.red)
                .cornerRadius(10)
                .foregroundColor(.white)
        }
        .frame(width: 320)
        .padding()
    }
}

struct TaskCard2: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Personal assistant")
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
                Text("Helper: Tom H")
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
            }
            .layoutPriority(100)
            Text("Done")
                .frame(width: 80)
                .font(.headline)
                .padding(10)
                .background(.green)
                .cornerRadius(10)
                .foregroundColor(.white)
        }
        .frame(width: 320)
        .padding()
    }
}
