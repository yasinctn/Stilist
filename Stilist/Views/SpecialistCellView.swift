//
//  SpecialistCellView.swift
//  Stilist
//
//  Created by Yasin Cetin on 12.01.2025.
//

import SwiftUI

struct SpecialistCellView: View {
    
    @State var specialist: Specialist
    
    var body: some View {
        Image(systemName: "person")
            .resizable()
            .frame(width: 60, height: 60)
            .foregroundColor(.gray)
        Text("\(specialist.name) \(specialist.surname)")
            .font(.subheadline)
    }
}

