//
//  CommentCell.swift
//  Stilist
//
//  Created by Yasin Cetin on 15.12.2024.
//

import SwiftUI

struct CommentCell: View {
    @State var review: Review
    var body: some View {
        HStack {
            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)
            VStack(alignment: .leading) {
                Text(review.reviewerName ?? "yorumcu adı boş")
                    .font(.headline)
                Text(review.comment ?? "yorum boş")
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack {
                Text(review.timeAgo ?? "")
                Image(systemName: "heart")
            }
        }
    }
}

