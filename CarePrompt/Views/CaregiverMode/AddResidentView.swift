import SwiftUI
import SwiftData
import PhotosUI

struct AddResidentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var unit = ""
    @State private var roomNumber = ""
    @State private var selectedLanguage = LanguageHelper.availableLanguages.first(where: { $0.id.contains("en") }) ?? LanguageHelper.availableLanguages[0]
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var photoData: Data?
    @State private var showingValidationAlert = false

    var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !unit.trimmingCharacters(in: .whitespaces).isEmpty &&
        !roomNumber.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Resident Info") {
                    TextField("Full Name", text: $name)
                    TextField("Unit", text: $unit)
                    TextField("Room Number", text: $roomNumber)
                }

                Section("Language") {
                    Picker("Preferred Language", selection: $selectedLanguage) {
                        ForEach(LanguageHelper.availableLanguages) { language in
                            Text(language.displayName).tag(language)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section("Photo (Optional)") {
                    PhotosPicker(selection: $selectedPhoto, matching: .images) {
                        photoPickerLabel
                    }
                    .onChange(of: selectedPhoto) { _, newItem in
                        Task {
                            photoData = try? await newItem?.loadTransferable(type: Data.self)
                        }
                    }
                }
            }
            .navigationTitle("Add Resident")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard isFormValid else {
                            showingValidationAlert = true
                            return
                        }
                        saveResident()
                    }
                }
            }
            .alert("Missing Information", isPresented: $showingValidationAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Please enter a name, unit, and room number before saving.")
            }
        }
    }
    
    @ViewBuilder
    private var photoPickerLabel: some View {
        HStack {
            if let photoData, let uiImage = UIImage(data: photoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.crop.circle.badge.plus")
                    .font(.system(size: 40))
                    .foregroundStyle(Color.accentColor)
            }
            Text(photoData == nil ? "Add Photo" : "Change Photo")
                .foregroundStyle(Color.accentColor)
        }
    }

    private func saveResident() {
        let resident = Resident(
            name: name.trimmingCharacters(in: .whitespaces),
            unit: unit.trimmingCharacters(in: .whitespaces),
            roomNumber: roomNumber.trimmingCharacters(in: .whitespaces),
            preferredLanguage: selectedLanguage.id,
            photoData: photoData
        )
        modelContext.insert(resident)
        dismiss()
    }
}
