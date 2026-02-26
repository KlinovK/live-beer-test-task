//
//  QRCodeView.swift
//  Live Beer App
//
//  Created by Константин Клинов on 26/02/26.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct BarcodeView: View {
    
    let code: String
    private let context = CIContext()
    private let filter = CIFilter.code128BarcodeGenerator()
    
    var body: some View {
        VStack(spacing: 12) {
            
            if let uiImage = generateBarcode(from: code) {
                Image(uiImage: uiImage)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(height: 100)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
            }
            
            Text(code)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColor.primaryText)
        }
    }
    
    private func generateBarcode(from string: String) -> UIImage? {
        
        filter.message = Data(string.utf8)
        
        guard let outputImage = filter.outputImage else { return nil }
        
        // Увеличиваем без размытия
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        let scaledImage = outputImage.transformed(by: transform)
        
        if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        
        return nil
    }
}
