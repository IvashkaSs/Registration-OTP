import UIKit

class CustomNavigationBar: UINavigationBar {
    
    // MARK: – Properties
    private var lineLayer: CALayer?
    
    // MARK: – Methods
    private func addLineView() {
        if lineLayer == nil {
            
            let line = CALayer()
            let media = CACurrentMediaTime()
            
            line.frame = CGRectMake(0.0, frame.height - 1, frame.width, 1.0)
            line.backgroundColor = UIColor.grayButton.cgColor
            
            layer.addSublayer(line)
            
            lineLayer = line
        }
    }
    
    func setup() {
        tintColor = UIColor.blackButton
        
        addLineView()
    }
}
