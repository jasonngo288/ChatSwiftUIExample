//
//  CircularProfileImageView.swift
//  ChatApp
//
//  Created by Jason Ngo on 22/05/2024.
//

import SwiftUI

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    case xxLarge
    
    var dimension: CGFloat {
        switch self {
        case .xxSmall:
            return 28
        case .xSmall:
            return 32
        case .small:
            return 40
        case .medium:
            return 56
        case .large:
            return 64
        case .xLarge:
            return 80
        case .xxLarge:
            return 120
        }
    }
}

struct CircularProfileImageView: View {
    @StateObject var viewModel = CircularProfileImageViewModel()
    var imageId: String? = nil {
        didSet {
            self.fetchData()
        }
    }
    let size: ProfileImageSize
    var imageState: ImageState = .empty
    var body: some View {
        Group{
            switch imageState {
            case .empty:
                if let _imageId = imageId, _imageId.isEmpty == false {
                    if !viewModel.imageData.isEmpty, let data = Data(base64Encoded: viewModel.imageData), let uiImage = UIImage(data: data) {
                        renderImageView(state: .success(Image(uiImage: uiImage)))
                    } else {
                        renderImageView(state: .loading)
                    }
                } else {
                    renderImageView(state: imageState)
                }
            default:
                renderImageView(state: imageState)
            }
        }.onAppear {
            if let _ = self.imageId {
                self.fetchData()
            }
        }
    }
    
    private func renderImageView(state: ImageState) -> some View {
        return ProfileImageView(imageState: state, size: size).clipShape(Circle())
    }
    
    private func fetchData() {
        self.viewModel.fetchImageUrl(imageId: self.imageId)
    }
}

struct ChatImageView: View {
    @StateObject var viewModel = CircularProfileImageViewModel()
    var imageId: String? = nil {
        didSet {
            self.fetchData()
        }
    }
    var imageState: ImageState = .empty
    var body: some View {
        Group{
            switch imageState {
            case .empty:
                if let _imageId = imageId, _imageId.isEmpty == false {
                    if !viewModel.imageData.isEmpty, let data = Data(base64Encoded: viewModel.imageData), let uiImage = UIImage(data: data) {
                        renderImageView(state: .success(Image(uiImage: uiImage)))
                    } else {
                        renderImageView(state: .loading)
                    }
                } else {
                    renderImageView(state: imageState)
                }
            default:
                renderImageView(state: imageState)
            }
        }.onAppear {
            if let _ = self.imageId {
                self.fetchData()
            }
        }
    }
    
    private func renderImageView(state: ImageState) -> some View {
        return ProfileImageView(imageState: state, size: .xxLarge).frame(width: 100, height: 180)
            .padding(.top,6)
            .padding(.horizontal)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    private func fetchData() {
        self.viewModel.fetchImageUrl(imageId: self.imageId)
    }
}

struct ProfileImageView: View {
    let imageState: ImageState
    let size: ProfileImageSize
    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
        case .loading:
            ProgressView().frame(width: size.dimension, height: size.dimension)
        case .empty:
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .scaledToFill()
                .foregroundStyle(Color(.systemGray4))
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .scaledToFill()
                .foregroundStyle(Color(.systemGray4))
        }
    }
}


enum ImageState {
    case empty
    case loading
    case success(Image)
    case failure(Error)
}

enum TransferError: Error {
    case importFailed
}

#Preview {
    CircularProfileImageView(size: .medium)
}

class CircularProfileImageViewModel: ObservableObject {
    
    @Published var imageData: String = ""
    
    func fetchImageUrl(imageId: String?) {
        Task {
            await UploadFileService.shared.fetchImage(withID: imageId) { mediaFile in
                DispatchQueue.main.async {
                    self.imageData = mediaFile?.mediaData ?? ""
                }
            }
        }
    }
}
