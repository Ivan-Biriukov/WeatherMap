import UIKit.UIImage

extension UIImage {
    /// Reduces the image to the required size while preserving the aspect ratio
    func downSize(to targetSize: CGSize) -> UIImage? {
        let aspectSize = self.size.aspectFit(targetSize)
        let renderer = UIGraphicsImageRenderer(size: aspectSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: aspectSize))
        }
    }
}
