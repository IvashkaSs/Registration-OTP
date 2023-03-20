import UIKit

class OneTimeCodeTextField: UITextField {
    // MARK: - Initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.layer.cornerRadius = 8
    }
    
    // MARK: - Methods
    override func deleteBackward() {
        text = ""
    
        _ = delegate?.textField?(self, shouldChangeCharactersIn: NSRange(), replacementString: "")
    }
}
