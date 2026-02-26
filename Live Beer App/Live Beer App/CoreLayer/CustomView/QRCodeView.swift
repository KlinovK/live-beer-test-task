//
//  QRCodeView.swift
//  Live Beer App
//
//  Created by Константин Клинов on 26/02/26.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

// View that displays a Code128 barcode and its numeric value
struct BarcodeView: View {
    
    let code: String
    
    // Core Image context and filter for barcode generation
    private let context = CIContext()
    private let filter = CIFilter.code128BarcodeGenerator()
    
    var body: some View {
        VStack(spacing: 12) {
            
            // Generate and display barcode image
            if let uiImage = generateBarcode(from: code) {
                Image(uiImage: uiImage)
                    .resizable()
                    .interpolation(.none)     // Keep sharp edges
                    .scaledToFit()
                    .frame(height: 100)
                    .padding()
                    .background(Color.white)  // Barcode must be on white background
                    .cornerRadius(12)
            }
            
            // Show barcode value below
            Text(code)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColor.primaryText)
        }
    }
    
    // Generates Code128 barcode image from string
    private func generateBarcode(from string: String) -> UIImage? {
        
        // Convert string to Data
        filter.message = Data(string.utf8)
        
        guard let outputImage = filter.outputImage else { return nil }
        
        // Scale without blurring
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        let scaledImage = outputImage.transformed(by: transform)
        
        // Convert CIImage to UIImage
        if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        
        return nil
    }
}
