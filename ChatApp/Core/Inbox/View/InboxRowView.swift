//
//  InboxRowView.swift
//  ChatApp
//
//  Created by Jason Ngo on 22/05/2024.
//

import SwiftUI
import Kingfisher

struct InboxRowView: View {
    let message: Message
    var body: some View {
        HStack(alignment: .top,spacing: 12) {
            ZStack {
                CircularProfileImageView(imageId: message.user?.profileImageUrl, size: .medium)
                KFImage(URL(string: message.user?.profileImageUrl ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .foregroundStyle(Color(.systemGray4))
                    .clipShape(Circle())
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(message.user?.fullName ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(getMessageText())
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            HStack {
                Text(message.timestampString)
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundStyle(.gray)
        }
        .frame(height: 72)
    }
    
    private func getMessageText() -> String{
        if let isImage = message.isImage, isImage {
            return "Sent picture"
        } else if let isVideo = message.isVideo, isVideo {
            return "Sent video"
        } else if let isAudio = message.isAudio, isAudio {
            return "Sent voice message"
        } else {
            return message.messageText
        }
    }
}

