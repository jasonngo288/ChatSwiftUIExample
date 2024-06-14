//
//  RegistrationView.swift
//  ChatApp
//
//  Created by Jason Ngo on 22/05/2024.
//

import SwiftUI
import PhotosUI
import Foundation
import Combine

struct ProfileUpdateInfoView: View {
    @StateObject private var viewModel = ProfileUpdateInfoViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @State var showImagePickerAlertOptions: Bool = false
    @State var sourceTypeSelected: ImagePickerSourceType = .none
    
    var body: some View {
        LoadingIndicator(isShowing: .constant(viewModel.state == .isLoading)) {
            List{
                Section("") {
                    VStack(alignment: .leading, spacing: 0){
                        HStack {
                            Button{
                                showImagePickerAlertOptions.toggle()
                            } label: {
                                CircularProfileImageView(imageId: viewModel.currentUser?.profileImageUrl, size: .medium, imageState: viewModel.imageState)
                                    .overlay(alignment: .bottomTrailing) {
                                        Image(systemName: "pencil.circle.fill")
                                            .symbolRenderingMode(.multicolor)
                                            .font(.system(size: 22))
                                            .foregroundColor(.accentColor)
                                    }
                            }
                            Text("Enter your name and add an option profile picture")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                .padding(.leading, 10)
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                        Divider()
                        TextField("Enter your name", text: $viewModel.fullName)
                            .font(.body)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                        Divider()
                    }
                }
                Section("PHONE NUMBER") {
                    VStack(alignment: .leading, spacing: 0){
                        Text(viewModel.phoneNunber)
                            .font(.body)
                    }
                }
                Section("ABOUT") {
                    VStack(alignment: .leading, spacing: 0){
                        TextField("", text: $viewModel.about)
                            .font(.body)
                    }
                }
                Section(footer: VStack{
                    Button {
                        viewModel.saveInfoUser()
                    } label: {
                        Text("Save")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 360,height: 44)
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }) {
                    EmptyView()
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(Text("Edit Profile"))
            .navigationBarTitleDisplayMode(.inline)
            .confirmationDialog("Select an option", isPresented: $showImagePickerAlertOptions, actions: {
                Button("Take photo") {
                    setSourceType(type: .camera)
                }
                Button("Choose photo") {
                    setSourceType(type: .photoLibrary)
                }
            })
            .fullScreenCover(isPresented: isShowImagePicker()) {
                ImagePickerView(sourceType: sourceTypeSelected, onImagePicked: { image in
                    viewModel.setImageSelection(from: image)
                }) { // dismiss
                    sourceTypeSelected = .none
                }
            }
            .onReceive(viewModel.$isGoNextScreen) { isNext in
                if isNext {
                    dismiss()
                }
            }
        }
    }
    
    func isShowImagePicker() -> Binding<Bool>{
        switch sourceTypeSelected {
        case .camera, .photoLibrary, .savedPhotosAlbum:
            return .constant(true)
        default:
            return .constant(false)
        }
    }
    
    func setSourceType(type: ImagePickerSourceType) {
        showImagePickerAlertOptions.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.sourceTypeSelected = type
        }
    }
}

#Preview {
    ProfileUpdateInfoView()
}
