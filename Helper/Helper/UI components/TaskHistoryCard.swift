//
//  TaskHistoryCard.swift
//  Helper
//
//  Created by Dang Son on 1.5.2022.
//

import Foundation
import SwiftUI

struct TaskHistoryCard: View {
    
    @State var taskTitle: String
    @State var user: String?
    @State var location: String
    @State var time: Date?
    @State var date: Date?
    @State var status: Int16
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                VStack(alignment: .leading, spacing:10) {
                    Text(taskTitle)
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    Label(user ?? "No volunteer assigned", systemImage: "person")
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                Spacer()
                
                if (user == "No volunteer assigned") {
                    Text("Pending")
                        .frame(width: 80)
                        .font(.headline)
                        .padding(10)
                        .background(.orange)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                } else {
                    switch (status) {
                    case 0:
                        Text("Ongoing")
                            .frame(width: 80)
                            .font(.headline)
                            .padding(10)
                            .background(Color("Primary"))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    case 1:
                        Text("Done")
                            .frame(width: 80)
                            .font(.headline)
                            .padding(10)
                            .background(.green)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    default:
                        Text("task")
                    }
                }
            }
            .padding(.horizontal)
            
            Label(time!.formatted(date: .omitted, time: .complete), systemImage: "clock")
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.horizontal)
            Label("Location: \(location)", systemImage: "mappin")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
        }
        .padding(.vertical)
        .layoutPriority(100)
    }
}
