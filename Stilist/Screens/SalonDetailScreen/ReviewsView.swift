//
//  ReviewsView.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.12.2024.
//

import SwiftUI

struct ReviewsView: View {
    
    @State var reviews: [Review] = []
    
    var body: some View {
        Text("Yorumlar")
            .font(.headline)
        VStack(spacing: 10) {
            ForEach(reviews) { review in
                CommentCell(review: review)
                Divider()
            }
            
        }
    }
}

#Preview {
    ReviewsView()
}
