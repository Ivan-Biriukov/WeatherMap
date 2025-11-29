import Foundation

extension CGSize {
    /// Returns a size that fits within the target size while preserving aspect ratio.
    /// - Parameter to: The target size to fit within.
    /// - Returns: A new size scaled to fit while maintaining proportions.
    func aspectFit(_ to: CGSize) -> CGSize {
        let scaleX = to.width / self.width
        let scaleY = to.height / self.height
        
        let aspectRatio = min(scaleX, scaleY)
        
        return CGSize(width: aspectRatio * width, height: aspectRatio * height)
    }
}
